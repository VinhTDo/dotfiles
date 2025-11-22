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

if [[ -d $HOME/.config/composer && -d $HOME/.config/composer/vendor && -d $HOME/.config/composer/vendor/bin ]]; then
	export PATH=$HOME/.config/composer/vendor/bin:$PATH
fi

if [ -e /usr/bin/google-chrome-stable ]; then
	export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
fi

if [ -d $ANDROID_HOME/emulator ]; then
	export PATH=$ANDROID_HOME/emulator:$PATH
fi
