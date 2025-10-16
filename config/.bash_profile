#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -d $HOME/.local/bin ]; then
	export PATH=$HOME/.local/bin:$PATH
fi
