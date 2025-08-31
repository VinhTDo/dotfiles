#!/bin/sh

PROJECT_DIR=$HOME/projects

if [[ ! -d $PROJECT_DIR ]]; then
	exit 1
fi

SELECTED_PROJECT=$(find $PROJECT_DIR -mindepth 1 -maxdepth 1 -type d | fzf)

if [[ -z $SELECTED_PROJECT ]]; then
	exit 0
fi

PROJECT_NAME=$(basename $SELECTED_PROJECT)

if [[ -z $TMUX || -z $(pidof tmux) ]]; then
	tmux new-session -s $PROJECT_NAME -c $SELECTED_PROJECT
	exit 0
fi

if [[ ! tmux- has-session -t=$SELECTED_PROJECT 2> /dev/null  ]]; then
	tmux -ds $PROJECT_NAME -c $SELECTED_PROJECT
fi

if [[ -z $TMUX ]]; then
	tmux attach -t $PROJECT_NAME
else
	tmux switch-client -t $PROJECT_NAME
fi
