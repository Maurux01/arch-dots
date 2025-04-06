# dotfiles for Arch Linux with Hyprland and Wayland

This repository contains configuration files and scripts for customizing your Arch Linux environment using Hyprland as the window manager and Wayland as the display server.

## Directory Structure

- **hypr/**: Contains configuration files for Hyprland.
  - `hyprland.conf`: Configuration settings for window management and layout options.
  - `hyprpaper.conf`: Wallpaper settings for Hyprland.
  
- **waybar/**: Contains configuration files for Waybar.
  - `config`: Configuration for Waybar modules and settings.
  - `style.css`: CSS styles for customizing the appearance of Waybar.
  
- **kitty/**: Configuration for the Kitty terminal emulator.
  - `kitty.conf`: Settings including font and keybindings.
  
- **rofi/**: Configuration for the Rofi application launcher.
  - `config.rasi`: Appearance and behavior settings for Rofi.
  
- **swaylock/**: Configuration for the Swaylock lock screen.
  - `config`: Lock screen options.
  
- **dunst/**: Configuration for the Dunst notification daemon.
  - `dunstrc`: Notification display settings.
  
- **scripts/**: Contains startup scripts.
  - `startup.sh`: Shell script to launch applications and services at startup.
  
- **.gitignore**: Specifies files and directories to be ignored by Git.

## Setup Instructions

1. Clone this repository to your home directory:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   ```

2. Create symbolic links for the configuration files:
   ```bash
   ln -sf ~/.dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
   ln -sf ~/.dotfiles/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
   ln -sf ~/.dotfiles/waybar/config ~/.config/waybar/config
   ln -sf ~/.dotfiles/waybar/style.css ~/.config/waybar/style.css
   ln -sf ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
   ln -sf ~/.dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi
   ln -sf ~/.dotfiles/swaylock/config ~/.config/swaylock/config
   ln -sf ~/.dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc
   ```

3. Make the startup script executable:
   ```bash
   chmod +x ~/.dotfiles/scripts/startup.sh
   ```

4. Add the startup script to your session startup applications.

## Usage Guidelines

- Modify the configuration files as needed to suit your preferences.
- Refer to the documentation for each application for more detailed configuration options.