#!/usr/bin/env sh

goal=$(readlink-f "$(eval_gettext "\$GSH_HOME/Castle/Main_tower/First_floor/Second_floor/Top_of_the_tower")")
current=$(readlink-f "$PWD")

if [ "$goal" != "$current" ]
then
    echo "$(gettext "You are not at the top of the tower!")"
    echo "$(gettext "You need to start over from the start.")"
    cd "$GSH_HOME"
    unset goal current
    false
elif [ ! -f "$current/keg_of_cider.txt" ]
then
    echo "$(gettext "You haven't created the keg of cider yet!")"
    echo "$(gettext "Run: python cider_press.py")"
    unset goal current
    false
elif [ "$(cat "$current/keg_of_cider.txt")" != "Lots of NA cider!!!" ]
then
    echo "$(gettext "The keg doesn't contain the right cider!")"
    echo "$(gettext "Run: python cider_press.py")"
    unset goal current
    false
else
    unset goal current
    true
fi
