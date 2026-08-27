#!/usr/bin/env sh

goal=$(readlink-f "$(eval_gettext "\$GSH_HOME/Castle/Main_tower/First_floor/Second_floor/Top_of_the_tower")")
current=$(readlink-f "$PWD")

# Check if we're at the top of the tower
if [ "$goal" != "$current" ]
then
    echo "$(gettext "You are not at the top of the tower!")"
    echo "$(gettext "You need to start over from the start.")"
    cd "$GSH_HOME"
    unset goal current
    false
    exit 1
fi

# Check if keg_of_cider.txt exists
if [ ! -f "$current/keg_of_cider.txt" ]
then
    echo "$(gettext "You haven't created the keg of cider yet!")"
    echo "$(gettext "Run: python cider_press.py")"
    unset goal current
    false
    exit 1
fi

# Check if the file contains the correct text
expected_content="Lots of NA cider!!!"
actual_content=$(cat "$current/keg_of_cider.txt")

if [ "$actual_content" != "$expected_content" ]
then
    echo "$(gettext "The keg doesn't contain the right cider!")"
    echo "$(gettext "Run: python cider_press.py")"
    unset goal current
    false
    exit 1
fi

# All checks passed!
unset goal current
true
