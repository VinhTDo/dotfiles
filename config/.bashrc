#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
CLEAR='\033[0m'

parse_git_branch() {
	if [ -d .git ]; then
		echo -e "${GREEN}($(git branch --show-current))${CLEAR}"
	fi
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\u@\h: \W $(parse_git_branch)\$ '
