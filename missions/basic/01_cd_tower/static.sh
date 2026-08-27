#!/usr/bin/env sh
tower="$(eval_gettext "\$GSH_HOME/Castle/Main_tower/First_floor/Second_floor/Top_of_the_tower")"
mkdir -p "$tower"

# Create the cider_press.py script in the top of the tower. It presses
# whatever barrel_of_apples file the player brings up from the Cellar
# (missions/basic/02_cd.._cellar/static.sh creates the original, signed
# copy at $GSH_HOME/Castle/Cellar/barrel_of_apples -- that mission's
# static.sh has already run by the time the player reaches mission 1, since
# start.sh sources every mission's static.sh up front to build the whole
# world map).
#
# The player is expected to *move* (mv) the barrel to the tower, so the
# Cellar copy won't necessarily still be around to compare against -- the
# script instead re-verifies the self-contained signature scripts/sign_file
# embedded in the barrel (a leading "sha1@random" line covering the rest of
# the file's bytes), the same anti-tampering scheme already used elsewhere
# in this game. That also makes running the press directly against the
# barrel's original Cellar location (no move needed) just as valid.
cat > "$tower/cider_press.py" <<'PYTHON_SCRIPT'
#!/usr/bin/env python3
"""Press a barrel of apples into a keg of cider.

Reads a barrel_of_apples file and verifies its signature -- a leading
"sha1@random" line covering the rest of the file, written by
scripts/sign_file when the original barrel was placed in the castle's
Cellar -- before pressing it into a fresh keg of (non-alcoholic) cider.
Checking the file's own embedded signature (rather than comparing it
against a second copy) works no matter where the barrel currently is,
including after it's been moved out of the Cellar.
"""
import argparse
import hashlib
import os
import sys

DEFAULT_BARREL = "./barrel_of_apples"
SIGNED_NAME = "barrel_of_apples"  # basename sign_file embedded at signing time


def parse_args():
    parser = argparse.ArgumentParser(
        description="Press a barrel of apples into a keg of cider.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "barrel_of_apples",
        nargs="?",
        default=DEFAULT_BARREL,
        help=(
            "path to the barrel_of_apples file to press. The barrel_of_apples "
            "file can be found in the Cellar directory, inside the Castle "
            "directory (Castle/Cellar/barrel_of_apples)."
        ),
    )
    return parser.parse_args()


def signature_valid(data: bytes) -> bool:
    """Re-check the "sha1@random" signature scripts/sign_file wrote as the
    barrel's first line, covering "SIGNED_NAME@random\\n" plus the rest of
    the file's bytes.
    """
    if b"\n" not in data:
        return False
    header, rest = data.split(b"\n", 1)
    try:
        signed_sum, random_salt = header.decode().split("@", 1)
    except ValueError:
        return False
    expected = hashlib.sha1(f"{SIGNED_NAME}@{random_salt}\n".encode() + rest).hexdigest()
    return signed_sum == expected


def main():
    args = parse_args()

    if not os.path.isfile(args.barrel_of_apples):
        print(f"✗ No barrel of apples found at '{args.barrel_of_apples}'!", file=sys.stderr)
        sys.exit(1)

    with open(args.barrel_of_apples, "rb") as f:
        data = f.read()

    if not signature_valid(data):
        print("✗ This isn't the real barrel of apples from the Cellar!", file=sys.stderr)
        sys.exit(1)

    with open("keg_of_cider.txt", "w") as f:
        f.write("Lots of NA cider!!!")
    print("✓ A fresh keg of cider has been created!")


if __name__ == "__main__":
    main()
PYTHON_SCRIPT

chmod +x "$tower/cider_press.py"
