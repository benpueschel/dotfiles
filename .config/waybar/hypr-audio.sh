#!/usr/bin/env bash

# This script is used to toggle the pavucontrol window using hyprctl.
# The window will be placed at the top right corner of the screen,
# 34 pixels from the top and 0 pixels from the right.
# The window will have no border, no rounding, no animations, and will be floating.
# The window will have a size of 30% of the screen width and 40% of the screen height.

PROCESS_NAME="pavucontrol"

IS_RUNNING=$(pgrep -x $PROCESS_NAME)

if [ -z "$IS_RUNNING" ]; then
	hyprctl dispatch exec "[noborder; norounding; noanim; floating; size 30% 40%; move 100%-w-0 34]" $PROCESS_NAME
else
	pkill $PROCESS_NAME
fi
