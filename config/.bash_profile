#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -d $HOME/.local/bin ]; then
	export PATH=$HOME/.local/bin:$PATH
fi

if [ -d /usr/share/dotnet ]; then
	export DOTNET_CLI_TELEMETRY_OPTOUT=1
fi
