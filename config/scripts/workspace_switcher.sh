#!/bin/sh

CURRENT_THEME_DIRS=($(hyprctl hyprpaper listactive))
CURRENT_THEME=$(basename ${CURRENT_THEME_DIRS[1]%/*/*})

. $HOME/.config/scripts/wallpaper_changer.sh $CURRENT_THEME
