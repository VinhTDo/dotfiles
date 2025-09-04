#!/bin/sh

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CLEAR="\033[00m"

PACMAN_PACKAGES=(
	"hyprland" "hyprpaper" "hyprlock" "hypridle"
	"hyprshot" "jq" "neovim" "ghostty"
	"lua" "fd" "ripgrep" "ttf-jetbrains-mono"
	"ttf-jetbrains-mono-nerd" "rofi" "waybar" "pipewire"
	"pipewire-audio" "pipewire-alsa" "pipewire-pulse" "tmux" "fzf"
	"dunst" "xdg-desktop-portal-hyprland"
)
AUR_PACKAGES=("wlogout")
AUR_PACKAGE_MANAGER=paru

log_error() {
	TIMESTAMP=$(date +"%d/%m/%Y %H:%M:%S")
	echo -e "[${TIMESTAMP}] ${RED}ERROR:${CLEAR} $1\n"
	exit 1
}

check_initialisation() {
	if [[ $(id -u) = 0 ]]; then
		log_error "This script must NOT be run as root user."
	fi

	if ! ping -q -c 1 -W 1 8.8.8.8 > /dev/null 2>&1; then
		log_error "No internet connection."
	fi

	if [[ -z $(pacman -Q | grep $AUR_PACKAGE_MANAGER) ]]; then
		log_error "AUR package manager not found."
	fi
}

check_pacman_packages() {
	MISSING_PACKAGES=()

	for PACKAGE in ${PACMAN_PACKAGES[@]}; do
		if ! is_installed $PACKAGE; then
			MISSING_PACKAGES+=($PACKAGE)
			echo -e "${YELLOW}$PACKAGE not installed.${CLEAR}"
		else
			echo -e "${GREEN}$PACKAGE already installed.${CLEAR}"
		fi
	done

	if [[ -n ${MISSING_PACKAGES[@]} ]]; then
		echo -e "${GREEN}Installing missing pacman packages...${CLEAR}"
		sleep 1
		sudo pacman -S ${MISSING_PACKAGES[@]} --noconfirm
	fi
}

check_aur_packages() {
	MISSING_PACKAGES=()

	for PACKAGE in ${AUR_PACKAGES[@]}; do
		if ! is_installed $PACKAGE; then
			MISSING_PACKAGES+=($PACKAGE)
			echo -e "${YELLOW}$PACKAGE not installed.${CLEAR}"
		else
			echo -e "${GREEN}$PACKAGE already installed.${CLEAR}"
		fi
	done

	if [[ -n ${MISSING_PACKAGES[@]} ]]; then
		echo -e "${GREEN}Installing missing AUR packages...${CLEAR}"
		${AUR_PACKAGE_MANAGER} -S ${MISSING_PACKAGES[@]} --noconfirm --skipreview
	fi
}

symlink_dotfiles() {
	CONFIG_DOTFILE_DIR=$HOME/.dotfiles/config
	THEME_DOTFILE_DIR=$HOME/.dotfiles/themes
	MISC_DOTFILE_DIR=$HOME/.dotfiles/misc

	OUTPUT_DIR=$HOME/.config

	for DIRECTORY in $CONFIG_DOTFILE_DIR/*; do
		DIRECTORY_NAME=$(basename $DIRECTORY)

		if [ -L $OUTPUT_DIR/$DIRECTORY_NAME ] && [ -e $OUTPUT_DIR/$DIRECTORY_NAME ]; then
			echo -e "${GREEN}Symlink already exists.${CLEAR}"
		else
			echo -e "${GREEN}Creating symlink for $DIRECTORY_NAME${CLEAR}"
			ln -s $CONFIG_DOTFILE_DIR/$DIRECTORY_NAME $OUTPUT_DIR/$DIRECTORY_NAME
			echo -e "${GREEN}$DIRECTORY_NAME symlink has been created.${CLEAR}"
		fi
	done

	DIRECTORY_NAME=$(basename $THEME_DOTFILE_DIR)

	if [ -L $OUTPUT_DIR/$DIRECTORY_NAME ] && [ -e $OUTPUT_DIR/$DIRECTORY_NAME ]; then
		echo -e "${GREEN}Symlink already exists.${CLEAR}"
	else
		echo -e "${GREEN}Creating symlink for $DIRECTORY_NAME${CLEAR}"
		ln -s $THEME_DOTFILE_DIR $OUTPUT_DIR/$DIRECTORY_NAME
		echo -e "${GREEN}$DIRECTORY_NAME symlink has been created.${CLEAR}"
	fi

	DIRECTORY_NAME=$(basename $MISC_DOTFILE_DIR)

	if [ -L $OUTPUT_DIR/$DIRECTORY_NAME ] && [ -e $OUTPUT_DIR/$DIRECTORY_NAME ]; then
		echo -e "${GREEN}Symlink already exists.${CLEAR}"
	else
		echo -e "${GREEN}Creating symlink for $DIRECTORY_NAME${CLEAR}"
		ln -s $MISC_DOTFILE_DIR $OUTPUT_DIR/$DIRECTORY_NAME
		echo -e "${GREEN}$DIRECTORY_NAME symlink has been created.${CLEAR}"
	fi

	HIDDEN_FILES=$(ls -A $CONFIG_DOTFILE_DIR | grep "^\.")

	for FILE in $HIDDEN_FILES; do
		if [ -L $HOME/$FILE ] && [ -e $HOME/$FILE ]; then
			echo -e "${GREEN}Symlink already exists.${CLEAR}"
		else
			echo -e "${GREEN}Creating symlink for $FILE${CLEAR}"
			ln -s $CONFIG_DOTFILE_DIR/$FILE $HOME/$FILE
			echo -e "${GREEN}$FILE symlink has been created.${CLEAR}"
		fi
	done

}

is_installed() {
	pacman -Qq "$1" > /dev/null 2>&1
}

check_initialisation

echo -e "${GREEN}Checking dependencies...${CLEAR}\n"
sleep 1

check_pacman_packages
check_aur_packages

echo -e "\n${GREEN}Symlinking dotfiles...${CLEAR}\n"
sleep 1

symlink_dotfiles
