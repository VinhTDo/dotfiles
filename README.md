# Zenless Zone Zero Dotfiles for Hyprland
A custom-made environment based on the theme of Zenless Zone Zero.

These dotfiles are highly customisable, designed to give you full control
for your setup.

All themes are based on Agents in Zenless Zone Zero.

> [!NOTE]
> This configuration only works, if you're on an [ArchLinux](https://archlinux.org/)-based distro.

## Features
* Fast theme switcher to switch themes
* Built-in TMUX sessioniser to switch projects
* Built-in Neovim custom folder as an IDE
* Custom themes for users to modify
* Screenshot feature of an entire montior

## Getting Started
### Installation
1. Clone the repository
```sh
git clone https://github.com/VinhTDo/dotfiles.git ~/.dotfiles
```
2. Manually symlink directories from config folder to config
> [!NOTE]
> Delete existing folders in .config folder. Exclude .bashrc and .tmux.conf
```sh
ln -s <folder-from-dotfile> <new-symlink-path>
```
3. Repeat the same from step 2, but now symlink .bashrc and .tmux.conf

## Dependencies
| App | Package |
| -------------- | --------------- |
| Windows Manager | Hyprland |
| Shell | Bash *(default on Linux)* |
| Editor | Neovim |
| Terminal | Ghostty |
| Status Bar | Waybar |
| Wallpaper | Hyprpaper |
| Screenshot | Hyprshot |
| Menu | Rofi |
| Lock Screen | Hyprlock |
| Idle Management | Hypridle |
| Font | Jetbrains Mono Nerd Font *(optional)* |
| Sessioniser | Tmux |
| Fuzzy Finder | Fzf |

## Keybindings
| Keymap | Description |
| -------------- | --------------- |
| $SUPER + Q | Open terminal |
| $SUPER + C | Close active window |
| $SUPER + M | Exit Hyprland |
| $SUPER + R | Open menu |
| $SUPER + V | Toggle floating window |
| $SUPER + LEFT | Move focus to left |
| $SUPER + RIGHT | Move focus to right |
| $SUPER + UP | Move focus to up |
| $SUPER + DOWN | Move focus to down |
| $SUPER + SHIFT + T | Open theme selector |
| PRINT | Screenshot output |
| $SUPER + [1-5] | Switch to workspace 1-5 |
| $SUPER + SHIFT + [1-5] | Move active to workspace 1-5 |

## Screenshots
![Screenshot 01](./misc/screenshots/screenshot-01.png "screenshot-01.png")
![Screenshot 02](./misc/screenshots/screenshot-02.png "screenshot-02.png")
![Screenshot 03](./misc/screenshots/screenshot-03.png "screenshot-03.png")
![Screenshot 04](./misc/screenshots/screenshot-04.png "screenshot-04.png")

## License
This repository is licensed under the GPL v3 license.
See LICENSE for more details.
