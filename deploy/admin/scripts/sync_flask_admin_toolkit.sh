#!/usr/bin/env bash
# Sync ~/code/hobs/flask-admin-toolkit (this app's auth dependency, see
# ../pyproject.toml's `[tool.uv.sources]`) into deploy/flask-admin-toolkit.
# It's not published anywhere, so any install of this app's deps needs this
# run first. Mirrors rtod's scripts/sync_flask_admin_toolkit.sh.
#
# Usage:
#   ./scripts/sync_flask_admin_toolkit.sh                 # local copy
#   ./scripts/sync_flask_admin_toolkit.sh <host> [remote_dir]   # over ssh
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."   # -> repo root

SRC="${GSH_ADMIN_TOOLKIT_SRC:-$HOME/code/hobs/flask-admin-toolkit}"

if [ "$#" -eq 0 ]
then
    DEST="deploy/flask-admin-toolkit"
    mkdir -p "$DEST"
    cp -r "$SRC/pyproject.toml" "$SRC/README.md" "$SRC/src" "$DEST/"
    echo "Synced $SRC -> $DEST"
else
    HOST="$1"
    REMOTE_DIR="${2:-~/GameShell-Browser/deploy/flask-admin-toolkit}"
    ssh "${HOST}" "mkdir -p ${REMOTE_DIR}"
    scp -r "$SRC/pyproject.toml" "$SRC/README.md" "$SRC/src" "${HOST}:${REMOTE_DIR}/"
    echo "Synced $SRC -> ${HOST}:${REMOTE_DIR}"
fi
