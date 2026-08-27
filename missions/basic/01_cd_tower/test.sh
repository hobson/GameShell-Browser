#!/usr/bin/env sh

gsh assert check false

cd ..
gsh assert check false

cd
gsh assert check false

# Navigate to the top of the tower - should still fail without the keg
tower="$(eval_gettext "\$GSH_HOME/Castle/Main_tower/First_floor/Second_floor/Top_of_the_tower")"
cd "$tower"
gsh assert check false

# Run the python script - should create keg_of_cider.txt
python cider_press.py
gsh assert check true

# Verify the file was created with correct content
gsh assert test -f keg_of_cider.txt
gsh assert test "$(cat keg_of_cider.txt)" = "Lots of NA cider!!!"

# Test from a different location - should fail
cd "$(eval_gettext "\$GSH_HOME/Castle/Main_tower/First_floor/Second_floor/Top_of_the_tower")/.."
gsh assert check false
