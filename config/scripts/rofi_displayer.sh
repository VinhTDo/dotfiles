#!/bin/sh

CURRENT_THEME_DIRS=($(hyprctl hyprpaper listactive))
CURRENT_THEME=$(basename ${CURRENT_THEME_DIRS[1]%/*/*})

ROFI_DIR=$HOME/.config/themes/${CURRENT_THEME}/rofi
ROFI_THEME=$([[ -d $ROFI_DIR && -e ${ROFI_DIR}/style.rasi ]] && echo ${ROFI_DIR}/style.rasi || echo "android_notification")

rofi -show drun -theme $ROFI_THEME
