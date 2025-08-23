#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <theme-name>"
	exit 1
fi

THEME_NAME=$1
STATUS_BAR_DIR=$HOME/.config/themes/${THEME_NAME}/waybar
WAYBAR_STYLE=$([[ -d $STATUS_BAR_DIR && -e ${STATUS_BAR_DIR}/style.css ]] && echo ${STATUS_BAR_DIR}/style.css || echo $HOME/.config/waybar/style.css)

killall waybar 2> /dev/null

waybar -s $WAYBAR_STYLE &
