#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <theme-name>"
	exit 1
fi

THEME_NAME=$1
STATUS_BAR_DIR=$HOME/.config/themes/${THEME_NAME}/waybar
STYLE_FILE=$STATUS_BAR_DIR/style.css

killall waybar 2> /dev/null

if [[ -d "$STATUS_BAR_DIR" && -e $STYLE_FILE ]]; then
	waybar -s $STYLE_FILE &
else
	waybar &
fi
