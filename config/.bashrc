#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

RED="\[\033[31m\]"
GREEN="\[\033[32m\]"
YELLOW="\[\033[33m\]"
BLUE="\[\033[34m\]"
CLEAR="\[\033[00m\]"

parse_git_branch() {
	git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

alias ls="ls --color=auto"
alias grep="grep --color=auto"

PS1="\u@\h: \W${GREEN}\$(parse_git_branch)${CLEAR} \$ "

bind '"\C-f":"$HOME/.config/scripts/tmux_sessioniser.sh\n"'
