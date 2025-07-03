# Arch Dots: The Ultimate Automated Arch Linux + Hyprland Rice

This repository provides a modern, automated, and beautiful setup for Arch Linux, including:

- Hyprland (Wayland compositor with animations)
- Waybar (status bar)
- mako (notifications)
- wofi (launcher)
- swww (animated wallpapers)
- eww (widgets)
- Kitty (terminal)
- tmux (terminal multiplexer)
- Neovim IDE (with LSP, AI, themes, and easy keybinds)
- Fish + Oh My Fish (shell and theme manager)
- Wallpapers
- GRUB theme
- Animations and visual polish
- Extra tools for productivity, development, and gaming

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/youruser/arch-dots.git
   cd arch-dots
   ```
2. Run the interactive installer:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   - Use the menu to select what you want to install (full setup, visuals, dev tools, creative/gaming apps, etc.)
3. Log out and select **Hyprland** as your graphical session.

## Customization
- Place your wallpapers in `dotfiles/wallpapers/`.
- Change the GRUB theme in `dotfiles/grub-themes/`.
- Edit any config in `dotfiles/` to your liking.
- Add your own scripts in `dotfiles/scripts/`.
- Add eww widgets in `dotfiles/eww/` and swww scripts in `dotfiles/swww/`.

## Main Apps & Tools
| App/Tool                | Purpose                                 |
|-------------------------|-----------------------------------------|
| hyprland                | Wayland compositor                      |
| waybar                  | Status bar                              |
| mako                    | Notifications                           |
| wofi                    | App launcher                            |
| swww                    | Animated wallpapers                     |
| eww                     | Custom widgets                          |
| kitty                   | Terminal emulator                       |
| tmux                    | Terminal multiplexer                    |
| neovim (IDE)            | Modern code editor                      |
| fish + oh-my-fish       | Shell + theme manager                   |
| pamac                   | GUI package manager                     |
| gh                      | GitHub CLI                              |
| yazi                    | TUI file manager                        |
| bat, fd, rg, btop, zoxide, fzf, lazygit | Productivity CLI tools |
| ufw, openvpn            | Firewall & VPN                          |
| neofetch, fastfetch     | System info with ASCII art              |
| appflowy, obs-studio, gimp, kdenlive, lm studio, ferdium, inkscape, darktable, discord, blender, insomnia, blueman, pavucontrol, flameshot, copyq, cliphist, jenkins, beekeeper-studio, vscodium, podman, steam, heroic-games-launcher | Creative, dev, and gaming apps |

> Some apps (appflowy, heroic, ferdium, lm studio, beekeeper-studio) may require AUR. Use pamac or yay if not installed by default.

## Post-install
- The shell is automatically set to fish.
- Use the alias `dotbackup` to quickly push your dotfiles to GitHub.
- Run `dotfiles/scripts/postinstall.sh` if you need to reinstall fonts.

## Screenshots
_Add your screenshots and GIFs here to showcase your setup._

## Troubleshooting
- If a program doesn't start, check logs in ~/.local/share or ~/.cache.
- If the shell doesn't change to fish, run `chsh -s $(which fish)` manually.
- If a font is missing, run `dotfiles/scripts/postinstall.sh`.
- For AUR apps, use `pamac build <app>` or `yay -S <app>`.

## Changelog
- v1.0: First full version with Hyprland, Neovim IDE, extra tools, creative/gaming apps, and full automation.

## Contribution
- Pull requests and suggestions are welcome.
- License: MIT

---
Enjoy your fully automated, beautiful, and powerful Arch Linux + Hyprland setup! 