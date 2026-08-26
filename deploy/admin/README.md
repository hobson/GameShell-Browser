# deploy/admin — GameShell session settings page

A small password-protected Flask-Admin app for toggling two per-deployment
settings without SSHing in: whether `python`/`python3` are available in the
game shell, and which mission list (`*.idx` file) a fresh session boots
into. Settings are written to `../config.env`, read fresh by
`../gsh-session.sh` on every new connection — no rebuild, no restart.

See `docs/browser-deployment.md`'s "Admin panel" section for the full
install/deploy walkthrough. Quick local run:

```sh
./scripts/sync_flask_admin_toolkit.sh      # pulls in the shared auth package
uv venv && uv pip install -e .
cp .env.sample .env
python -c "import secrets; print(secrets.token_hex(32))"   # -> SECRET_KEY
uv run scripts/hash_password.py 'your password'            # -> ADMIN_PASSWORD_HASH
# fill both into .env, then:
uv run app.py    # http://127.0.0.1:7683
```

Auth is `flask_admin_toolkit.PasswordAuthMixin`/`make_login_blueprint` — one
shared admin password (not per-user accounts), the same pattern
`~/code/hobs/flask-admin-toolkit`'s README documents and `rtod` already
depends on for its own search/sort views.
