#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <theme-name>"
	exit 1
fi

THEME_NAME=$1
WALLPAPER_DIR=$HOME/.config/themes/${THEME_NAME}/wallpapers

hyprctl hyprpaper unload all

sleep 0.1

hyprctl hyprpaper preload $WALLPAPER_DIR/default.png
hyprctl hyprpaper preload $WALLPAPER_DIR/partial.png
hyprctl hyprpaper preload $WALLPAPER_DIR/full.png

. $HOME/.config/scripts/wallpaper_changer.sh $THEME_NAME
. $HOME/.config/scripts/status_bar_changer.sh $THEME_NAME
