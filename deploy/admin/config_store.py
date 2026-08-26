"""Read/write deploy/config.env — the flat KEY=value file gsh-session.sh
sources on every new session (see its own comments). Kept intentionally
dumb (no quoting, no comments preserved on save) since the only writer is
this app's settings form and the only values are a 0/1 flag and a path.
"""
from __future__ import annotations

import os
from pathlib import Path

DEFAULTS = {
    "GSH_ENABLE_PYTHON": "1",
    "GSH_INDEX_FILE": "missions/default.idx",
}


def load_config(path: Path) -> dict[str, str]:
    """Returns DEFAULTS overlaid with whatever `path` actually has set —
    same fallback behaviour as gsh-session.sh, so the form never shows a
    blank field just because the file is missing or partial.
    """
    values = dict(DEFAULTS)
    if not path.exists():
        return values
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        key = key.strip()
        if key in DEFAULTS:
            values[key] = value.strip()
    return values


def save_config(path: Path, values: dict[str, str]) -> None:
    """Atomic write (temp file + rename) so a session mid-launch never sees
    a half-written file — gsh-session.sh sources this with no locking.
    """
    merged = dict(DEFAULTS)
    merged.update(values)
    lines = [
        "# deploy/config.env — written by deploy/admin's settings page.",
        "# See deploy/config.env.sample for what each key does.",
        "",
    ]
    lines += [f"{key}={value}" for key, value in merged.items()]
    tmp_path = path.with_suffix(path.suffix + ".tmp")
    tmp_path.write_text("\n".join(lines) + "\n")
    os.replace(tmp_path, path)
