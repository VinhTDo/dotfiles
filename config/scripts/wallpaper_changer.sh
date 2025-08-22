#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <theme-name>"
	exit 1
fi

THEME_NAME=$1
THEME_DIR=$HOME/.config/themes/$THEME_NAME

echo "Changing wallpaper..."

WALLPAPER_DIR=$THEME_DIR/wallpapers
CURRENT_WORKSPACE=$(hyprctl activeworkspace -j | jq ".id")

case $CURRENT_WORKSPACE in
	1|5)
		hyprctl hyprpaper reload ,"$WALLPAPER_DIR/default.png"
		;;
	2|4)
		hyprctl hyprpaper reload ,"$WALLPAPER_DIR/partial.png"
		;;
	3)
		hyprctl hyprpaper reload ,"$WALLPAPER_DIR/full.png"
		;;
	*)
		echo "Invalid wallpaper"
		echo "Failed to change wallpaper"
		exit 1
esac

echo "Wallpaper successfully changed"
