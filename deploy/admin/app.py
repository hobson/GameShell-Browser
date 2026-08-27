"""GameShell admin panel — lets an instructor toggle whether python is
available in the game shell and pick which mission list new sessions boot
into, without SSHing in. See docs/browser-deployment.md's "Admin panel"
section for install/deploy instructions.

Deliberately not a database-backed Flask-Admin ModelView — there's no
model here, just two settings persisted to ../config.env (read fresh by
gsh-session.sh on every new session, see that script and config_store.py).
One AdminIndexView instead, following flask_admin_toolkit's documented
single-shared-password auth pattern (the same package rtod's curation.py
depends on for search/sort — see its own pyproject.toml).
"""
from __future__ import annotations

import os
from pathlib import Path

from dotenv import load_dotenv
from flask import Flask, flash, redirect, request, url_for
from flask_admin import Admin, AdminIndexView, expose
from flask_admin.theme import Bootstrap4Theme
from flask_admin_toolkit import PasswordAuthMixin, make_login_blueprint
from werkzeug.middleware.proxy_fix import ProxyFix

from config_store import load_config, save_config

REPO_ROOT = Path(__file__).resolve().parents[2]
CONFIG_PATH = REPO_ROOT / "deploy" / "config.env"

load_dotenv(Path(__file__).resolve().parent / ".env")


def _available_index_files() -> list[str]:
    """Every mission list (*.idx under missions/) an instructor could pick,
    as paths relative to missions/ — what GSH_INDEX_FILE actually needs:
    gsh-session.sh's positional arg is forwarded into a self-extracting
    archive, where make_index prefixes every path with $GSH_MISSIONS/ (see
    scripts/make_index's GSH_EXEC_FILE branch), so a REPO_ROOT-relative path
    like "missions/default.idx" resolves to a nonexistent doubled
    "missions/missions/default.idx". default.idx always sorts first.
    """
    missions_dir = REPO_ROOT / "missions"
    paths = sorted(
        p.relative_to(missions_dir).as_posix()
        for p in missions_dir.rglob("*.idx")
    )
    paths.sort(key=lambda p: (p != "default.idx", p))
    return paths


class _HomeView(PasswordAuthMixin, AdminIndexView):
    @expose("/", methods=["GET", "POST"])
    def index(self):
        current = load_config(CONFIG_PATH)
        index_files = _available_index_files()

        if request.method == "POST":
            index_file = request.form.get("index_file", current["GSH_INDEX_FILE"])
            if index_file not in index_files:
                flash(f"Unknown index file: {index_file}", "error")
            else:
                save_config(
                    CONFIG_PATH,
                    {
                        "GSH_ENABLE_PYTHON": "1" if request.form.get("python_enabled") else "0",
                        "GSH_INDEX_FILE": index_file,
                    },
                )
                flash("Saved — takes effect for the next session that connects.", "success")
                return redirect(url_for("admin.index"))

        return self.render(
            "gsh_admin/index.html",
            current=current,
            index_files=index_files,
        )


def create_app() -> Flask:
    app = Flask(__name__)
    # Reached two ways: directly at 127.0.0.1:7683 (e.g. over an SSH tunnel,
    # no prefix) or via Caddy's `handle_path /admin/*` (see deploy/Caddyfile),
    # which strips "/admin" and forwards it as X-Forwarded-Prefix instead.
    # ProxyFix folds that back into SCRIPT_NAME so url_for()/redirects come
    # out right either way -- same fix rtod's curation.py needed for the
    # same "path-prefixed behind a stripping proxy" situation, done here via
    # werkzeug's built-in middleware instead of a hand-rolled one.
    app.wsgi_app = ProxyFix(app.wsgi_app, x_prefix=1, x_proto=1, x_host=1)

    app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY")
    if not app.config["SECRET_KEY"]:
        raise RuntimeError("SECRET_KEY must be set in deploy/admin/.env — see .env.sample")

    password_hash = os.environ.get("ADMIN_PASSWORD_HASH")
    if not password_hash:
        raise RuntimeError(
            "ADMIN_PASSWORD_HASH must be set in deploy/admin/.env — "
            "generate one with scripts/hash_password.py"
        )
    app.register_blueprint(make_login_blueprint(lambda: password_hash))

    Admin(
        app,
        name="GameShell Admin",
        theme=Bootstrap4Theme(swatch="flatly"),
        index_view=_HomeView(url="/"),
    )

    return app


app = create_app()

if __name__ == "__main__":
    port = int(os.environ.get("GSH_ADMIN_PORT", "7683"))
    app.run(host="127.0.0.1", port=port, debug=False)
