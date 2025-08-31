#!/bin/sh

THEME_DIR=$HOME/.config/themes/
SELECTED_THEME=$(
	find $THEME_DIR -mindepth 1 -maxdepth 1 -type d -print0 |
	shuf -z -n 1 |
	xargs -0
)

THEME_NAME=$(basename $SELECTED_THEME)

$HOME/.config/scripts/theme_switcher.sh $THEME_NAME
