#!/usr/bin/env sh

tower="$(eval_gettext '$GSH_HOME/Castle/Main_tower/First_floor/Second_floor/Top_of_the_tower')"
cellar="$(eval_gettext '$GSH_HOME/Castle/Cellar')"

mv "$cellar/$(gettext "barrel_of_apples")" "$tower/"
cd "$tower"
python royal_cider_press.py
gsh check
