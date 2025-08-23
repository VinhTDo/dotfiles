#!/bin/sh

ICONS_DIR=$HOME/.config/misc/theme-icons
ICONS_LIST=$(ls -1 $ICONS_DIR)

CURRENT_THEME_DIRS=($(hyprctl hyprpaper listactive))
CURRENT_THEME=$(basename ${CURRENT_THEME_DIRS[1]%/*/*})
ROFI_DIR=$HOME/.config/themes/${CURRENT_THEME}/rofi
ROFI_THEME=$([[ -d $ROFI_DIR && -e ${ROFI_DIR}/style.rasi ]] && echo ${ROFI_DIR}/style.rasi || echo "android_notification")

SELECTED_THEME=$(
	for ICON in $ICONS_LIST;
	do echo -en "${ICON%.*}\0icon\x1f$ICONS_DIR/$ICON\n";
	done |
	rofi -dmenu -p "" -theme $ROFI_THEME
)

if [ -n $SELECTED_THEME ]; then
	. $HOME/.config/scripts/theme_switcher.sh $SELECTED_THEME
else
	echo "Cancel selecting..."
	exit
fi
