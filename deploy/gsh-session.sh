#!/usr/bin/env bash
#
# gsh-session.sh — launch one throwaway GameShell container per connection.
#
# Used as the command ttyd runs for each browser connection:
#     ttyd -W -s 9 ./deploy/gsh-session.sh
#
# The `-s 9` matters: ttyd's default kill signal (SIGHUP) is ignored by the
# docker CLI, so sessions never die. SIGKILL is the only one that lands.
#
# NOTE: this script does NOT clean up its own container. It can't -- ttyd
# SIGKILLs its entire process group on disconnect, so anything we leave behind
# here dies too. Killing the `docker run` client also does NOT stop the
# container. Cleanup is handled by deploy/gsh-janitor.sh, which runs outside
# ttyd entirely. Both must be running.

set -uo pipefail

IMAGE="${GSH_IMAGE:-gameshell}"

# Per-deployment session defaults -- read fresh on every connection, so the
# admin app (deploy/admin/) can change these and have it take effect on the
# very next session, with no rebuild or service restart. Missing file (a
# deployment that hasn't set this up) falls back to the defaults below,
# unchanged from this script's behaviour before config.env existed.
GSH_ENABLE_PYTHON=1
GSH_INDEX_FILE=default.idx
CONFIG_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config.env"
# shellcheck disable=SC1090
[ -f "$CONFIG_FILE" ] && . "$CONFIG_FILE"

# The name is the handle the janitor uses to find and reap this container.
# The `gsh-` prefix is load-bearing -- the janitor only ever touches `gsh-*`.
NAME="gsh-$$-${RANDOM}"

# `exec` REPLACES this shell with docker -- same PID, no bash left behind to
# catch or defer signals. docker must be in the foreground for -it to work.
# The trailing GSH_INDEX_FILE arg is forwarded by gameshell.sh straight into
# start.sh, which already accepts an index-file path positionally.
exec docker run --rm -it \
    --name "$NAME" \
    --memory 256m \
    --cpus 0.5 \
    --network none \
    --pids-limit 128 \
    -e "GSH_ENABLE_PYTHON=${GSH_ENABLE_PYTHON}" \
    "$IMAGE" ${GSH_INDEX_FILE:+"$GSH_INDEX_FILE"}
