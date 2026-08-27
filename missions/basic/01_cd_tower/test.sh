#!/usr/bin/env sh

# NOTE: `gsh assert check ...` re-starts mission 1 after every call (it calls
# __gsh_start, which re-sources this mission's init.sh -- and init.sh does
# `cd $GSH_HOME` -- see missions/basic/01_cd_tower/init.sh). So every block
# below re-`cd`s explicitly right before it needs a particular location;
# nothing here relies on cwd surviving across a `gsh assert` call.

tower="$(eval_gettext "\$GSH_HOME/Castle/Main_tower/First_floor/Second_floor/Top_of_the_tower")"
cellar="$(eval_gettext "\$GSH_HOME/Castle/Cellar")"
barrel_name="$(gettext "barrel_of_apples")"

gsh assert check false

cd ..
gsh assert check false

cd
gsh assert check false

# At the top of the tower, but no barrel and no keg yet
cd "$tower"
gsh assert check false

# Running the press with no barrel present should fail, and create no keg
cd "$tower"
python cider_press.py
gsh assert check false

# A fake barrel (wrong contents, no valid signature) should be rejected
cd "$tower"
echo "not really apples" > barrel_of_apples
python cider_press.py
gsh assert check false
rm -f "$tower/barrel_of_apples"

# Passing an explicit path to the still-in-the-Cellar barrel should work,
# with no move required
cd "$tower"
python cider_press.py "$cellar/$barrel_name"
gsh assert check true
rm -f "$tower/keg_of_cider.txt"

# The intended flow: move (mv) the real barrel up from the Cellar, then
# press it from its default location -- should succeed even though the
# Cellar no longer has a copy to compare against
mv "$cellar/$barrel_name" "$tower/"
cd "$tower"
python cider_press.py
gsh assert check true

# Verify the keg was created with correct content
test "$(cat "$tower/keg_of_cider.txt")" = "Lots of NA cider!!!" || echo "FAIL: unexpected keg_of_cider.txt content" >&2

# Put the barrel back in the Cellar and clean up the tower's keg -- leave the
# world as we found it, since 02_cd.._cellar/static.sh only creates the
# barrel once at game init and won't recreate it if this mission is re-run
# (e.g. `gsh auto` right after `gsh test`, as `make tests-bash` does).
mv "$tower/barrel_of_apples" "$cellar/"
rm -f "$tower/keg_of_cider.txt"

# Test from a different location - should fail
cd "$tower/.."
gsh assert check false
