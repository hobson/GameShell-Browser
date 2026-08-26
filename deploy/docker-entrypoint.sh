#!/bin/sh
#
# docker-entrypoint.sh — container ENTRYPOINT; conditionally hides python
# before handing off to the game.
#
# Runs as gsh-user (never root — see Dockerfile's USER directive), so it
# can only touch $HOME, not the real /usr/bin/python3. That's enough: it
# writes shim scripts into a directory prepended to PATH, ahead of the
# real interpreter, rather than removing anything from the image itself.
# This keeps the toggle a pure per-session decision (GSH_ENABLE_PYTHON is
# passed in by deploy/gsh-session.sh from deploy/config.env) with no image
# rebuild required to flip it.
#
# GSH_ENABLE_PYTHON unset or "1" (default) -> python/python3 untouched.
# GSH_ENABLE_PYTHON="0"                     -> both report "command not found".

set -eu

if [ "${GSH_ENABLE_PYTHON:-1}" = "0" ]
then
    SHIM_DIR="$HOME/.gsh-shims"
    mkdir -p "$SHIM_DIR"
    for bin in python python3
    do
        cat > "$SHIM_DIR/$bin" <<EOF
#!/bin/sh
echo "$bin: command not found" >&2
exit 127
EOF
        chmod +x "$SHIM_DIR/$bin"
    done
    PATH="$SHIM_DIR:$PATH"
    export PATH
fi

exec bash ./gameshell.sh "$@"
