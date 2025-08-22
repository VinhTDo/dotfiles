#!/bin/sh

ICONS_DIR=$HOME/.config/misc/theme-icons
ICONS_LIST=$(ls -1 $ICONS_DIR)

SELECTED_THEME=$(
	for ICON in $ICONS_LIST;
	do echo -en "${ICON%.*}\0icon\x1f$ICONS_DIR/$ICON\n";
	done |
	rofi -dmenu -p "" -show-icons
)

if [ -n $SELECTED_THEME ]; then
	. $HOME/.config/scripts/theme_switcher.sh $SELECTED_THEME
else
	echo "Cancel selecting..."
	exit
fi
