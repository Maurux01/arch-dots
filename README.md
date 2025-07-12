# Arch Dots - Hyprland Configuration

A complete and modern Hyprland configuration for Arch Linux with a dynamic login system based on wallpapers.

## 🚀 Features

- **Hyprland** - Modern and fast Wayland compositor
- **Dynamic login** - Lock screen theme that adapts to your wallpaper
- **EWW widgets** - Customizable desktop widgets
- **Waybar** - Minimalist status bar
- **Kitty** - GPU-accelerated terminal
- **Neovim** - Editor configured with LSP and plugins
- **Fish Shell** - Interactive shell with autocompletion (not zsh)
- **Gaming optimized** - Steam, Lutris, Wine, GameMode
- **Development** - Node.js, Python, Rust, Go, Java
- **Hyperlock** - Native Hyprland screen locker
- **Enhanced notifications** - Notification system with animations and colors
- **Proper installation** - Everything installed in standard system locations

## Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/mauruxu01/archriced.git
   cd archriced
   ```

2. **Give execution permissions to the installer (if needed):**
   ```sh
   chmod +x install.sh
   ```

3. **Run the installer:**
   ```sh
   ./install.sh
   ```

The installation script:
- ✅ Updates the system
- ✅ Installs all dependencies
- ✅ Configures Hyprland and components
- ✅ Installs system utilities
- ✅ Configures development tools
- ✅ Installs fonts and themes
- ✅ Configures Hyperlock
- ✅ Configures enhanced notifications
- ✅ Copies all dotfiles to correct system locations
- ✅ Verifies complete installation
- ✅ Configures the system

### Complete uninstallation

```bash
# Uninstall everything
./uninstall.sh
```

The uninstallation script:
- ✅ Creates a complete backup
- ✅ Uninstalls all packages
- ✅ Removes configurations
- ✅ Restores default configurations
- ✅ Cleans the system

## 🎨 Dynamic Login Features

The dynamic login system automatically analyzes your wallpaper and generates a lock screen theme that adapts to the dominant colors.

### Included functions:

- **Wallpaper analysis** - Extracts dominant colors
- **Theme generation** - Creates swaylock themes automatically
- **Automatic rotation** - Changes wallpapers automatically
- **Control widget** - EWW widget to manage wallpapers

### Useful commands:

```bash
# Lock screen with dynamic theme
./utils.sh lock

# Change wallpaper manually
./utils.sh wallpaper

# Start automatic rotation daemon
./utils.sh wallpaper-daemon

# Analyze current wallpaper
./utils.sh analyze-wallpaper
```

## 🛠️ Utility Scripts

### `utils.sh`

Main utility script with multiple functions:

```bash
# See all options
./utils.sh

# Wallpaper management
./utils.sh wallpaper [command]
./utils.sh wallpaper-daemon [start|stop|status]

# Screen lock
./utils.sh lock

# System maintenance
./utils.sh maintenance

# System information
./utils.sh info

# Wallpaper analysis
./utils.sh analyze-wallpaper [path]
```

### Hyperlock

Native Hyprland screen locker:

```bash
# Lock screen
hyperlock

# Configure Hyperlock
nano ~/.config/hyperlock/config.toml

# Check Hyperlock status
systemctl --user status hyperlock
```

### Enhanced Notifications

Notification system with animations, colors and intelligent handling of multiple notifications:

```bash
# Test volume notifications
~/.config/scripts/notification-enhancer.sh volume 75 false

# Test brightness notifications
~/.config/scripts/notification-enhancer.sh brightness 60

# Test music notifications
~/.config/notification-enhancer.sh music "Song Title" "Artist" play

# Test system notifications
~/.config/scripts/notification-enhancer.sh system "Test message" normal
```

**Included features:**
- **Colors by application** - Discord (blue), Spotify (green), Firefox (orange)
- **Visual progress bars** - For volume and brightness
- **Multiple notification handling** - Intelligent queue
- **Smooth animations** - Fluid transitions
- **Specific icons** - By application type
- **System notifications** - With different urgency levels

### Clipboard and History

Complete clipboard system with history:

```bash
# Open CopyQ history
SUPER + V

# Open cliphist history
SUPER + SHIFT + V

# Alternative for cliphist
SUPER + CTRL + V

# Screenshot to clipboard
SUPER + SHIFT + S
```

**Included tools:**
- **CopyQ** - Advanced clipboard manager with GUI
- **cliphist** - Terminal clipboard history
- **wl-clipboard** - Clipboard tools for Wayland

## 📁 Installation Locations

### System Directory Structure

All components are installed in standard system locations:

```
~/.config/
├── hypr/           # Hyprland configuration
├── nvim/           # Neovim configuration
├── fish/           # Fish shell configuration
├── kitty/          # Kitty terminal configuration
├── waybar/         # Waybar configuration
├── eww/            # EWW widgets configuration
├── wofi/           # Wofi launcher configuration
├── mako/           # Notifications configuration
├── swww/           # Wallpapers configuration
├── tmux/           # TMUX configuration
├── neofetch/       # Neofetch configuration
├── fastfetch/      # Fastfetch configuration
└── scripts/        # Utility scripts

~/.local/
├── bin/            # Executable scripts
└── share/
    └── wallpapers/ # System wallpapers

~/.cache/
└── nvim/           # Neovim cache
```

### Installation Verification

The script includes automatic verification that checks:
- ✅ All configurations in correct locations
- ✅ Executable scripts with correct permissions
- ✅ System directories created correctly
- ✅ Main components working

## 🐚 Shell Configuration

### Fish Shell (No ZSH)

This configuration uses **Fish shell** instead of zsh for the following reasons:

- **Better Wayland integration** - Fish works better with Wayland applications
- **Intelligent autocompletion** - Suggestions based on history
- **Cleaner syntax** - Less complexity than zsh
- **Included configuration** - Already configured with themes and plugins
- **htop included** - Advanced process monitor

### Fish Shell Features:

```bash
# Fish is already configured as default shell
# You don't need to install zsh or oh-my-zsh

# Useful Fish commands:
fish_config web    # Configure Fish via web
fish_update_completions  # Update completions
```

### htop - Process Monitor

htop is included in the installation for advanced process monitoring:

```bash
# Open htop
htop

# Alternative with btop (more modern)
btop
```

## 🎮 Gaming

- **Steam** - Gaming platform
- **Lutris** - Game manager
- **Wine** - Windows compatibility
- **GameMode** - Automatic optimization
- **MangoHud** - Performance overlay
- **Heroic Games Launcher** - Epic Games Store

## 💻 Development

Included development tools:

- **Node.js & npm** - JavaScript runtime
- **Python & pip** - Python interpreter
- **Rust** - Rust programming language
- **Go** - Go programming language
- **Java JDK** - Java development kit
- **GCC & CMake** - Compilers and build tools
- **Git** - Version control
- **LazyGit** - TUI for Git
- **Neovim** - Editor configured with LSP

## ⌨️ Keyboard Shortcuts

### Hyprland
- `SUPER + RETURN` - Open terminal
- `SUPER + D` - Application launcher
- `SUPER + Q` - Close window
- `SUPER + SHIFT + L` - Lock screen
- `SUPER + SHIFT + C` - Reload configuration
- `SUPER + SHIFT + Q` - Exit Hyprland

### Navigation
- `SUPER + HJKL` - Navigate between windows
- `SUPER + 1-9` - Change workspace
- `SUPER + SHIFT + HJKL` - Move windows
- `SUPER + SHIFT + 1-9` - Move window to workspace

### Multimedia
- `XF86AudioPlay` - Play/Pause
- `XF86AudioNext` - Next song
- `XF86AudioPrev` - Previous song
- `XF86AudioMute` - Mute (with animated notification)
- `XF86AudioRaiseVolume` - Raise volume (with animated notification)
- `XF86AudioLowerVolume` - Lower volume (with animated notification)
- `XF86MonBrightnessUp` - Raise brightness (with animated notification)
- `XF86MonBrightnessDown` - Lower brightness (with animated notification)

### Clipboard
- `SUPER + V` - Open CopyQ history
- `SUPER + SHIFT + V` - Open cliphist history
- `SUPER + CTRL + V` - Alternative cliphist
- `SUPER + SHIFT + S` - Screenshot to clipboard

## 🎨 Themes and Customization

### Included themes:
- **Catppuccin** - Modern dark theme
- **Papirus** - Consistent icons
- **Bibata** - Animated cursor

### Fonts:
- **JetBrains Mono** - Programming font
- **Fira Code** - Font with ligatures
- **Noto Fonts** - Universal fonts

## 🔧 Configuration

### Main files:
- `~/.config/hypr/hyprland.conf` - Hyprland configuration
- `~/.config/waybar/config` - Waybar configuration
- `~/.config/eww/eww.yuck` - EWW widgets
- `~/.config/kitty/kitty.conf` - Terminal configuration
- `~/.config/nvim/init.lua` - Neovim configuration

### Customization:
1. Edit configuration files
2. Reload Hyprland with `SUPER + SHIFT + C`
3. Changes apply immediately

## 🐛 Troubleshooting

### Common problems:

**Hyprland doesn't start:**
```bash
# Check logs
journalctl --user -f

# Check configuration
./utils.sh info
```

**Wallpapers don't change:**
```bash
# Check swww
./utils.sh info

# Restart daemon
./utils.sh wallpaper-daemon restart
```

**Hyperlock doesn't work:**
```bash
# Check installation
./utils.sh info

# Reconfigure Hyperlock
yay -S hyperlock --noconfirm
```

### Useful logs:
- `~/.local/share/hyprland/hyprland.log` - Hyprland logs
- `./utils.sh debug` - Complete debug
- `journalctl --user -f` - User logs

## 📁 Project Structure

```
archriced/
├── install.sh              # Complete installation
├── uninstall.sh            # Complete uninstallation
├── utils.sh                # Main utilities
├── README.md               # Documentation
└── dotfiles/               # Configurations
    ├── hypr/               # Hyprland
    ├── waybar/             # Status bar
    ├── eww/                # Widgets
    ├── kitty/              # Terminal
    ├── nvim/               # Editor
    ├── fish/               # Shell
    └── wallpapers/         # Example wallpapers
```

## 🤝 Contributing

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is under the MIT License. See the `LICENSE` file for more details.

## 🙏 Acknowledgments

- [Hyprland](https://hyprland.org/) - Wayland compositor
- [EWW](https://github.com/elkowar/eww) - Wayland widgets
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Color palette
- [JaKooLit](https://github.com/JaKooLit/Arch-Hyprland) - Script inspiration

## 📞 Support

If you have problems or questions:

1. Check the [Troubleshooting](#-troubleshooting) section
2. Run `./utils.sh debug` and share the logs
3. Open an issue on GitHub with detailed information

---

**Enjoy your new Hyprland configuration! 🎉** 