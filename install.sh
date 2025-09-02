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
	"dunst"
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
		${AUR_PACKAGE_MANAGER} -S ${MISSING_PACKAGES[@]} --noconfirm --skipreview
	fi
}

is_installed() {
	pacman -Qq "$1" > /dev/null 2>&1
}

check_initialisation

echo -e "${GREEN}Checking dependencies...${CLEAR}\n"
sleep 1

check_pacman_packages
check_aur_packages
