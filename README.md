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
- **Multimedia tools** - LMMS, Pixelorama, Upscayl
- **Image & SVG support** - View images and SVG in Neovim and Kitty
- **Hyperlock** - Native Hyprland screen locker
- **Enhanced notifications** - Notification system with animations and colors
- **Proper installation** - Everything installed in standard system locations
- **Security tools** - UFW firewall, WireGuard VPN, Fail2ban, ClamAV

## 📦 Installation

### Quick Install

1. **Clone the repository:**
   ```sh
   git clone https://github.com/mauruxu01/archriced.git
   cd archriced
   ```

2. **Give execution permissions to the installer:**
   ```sh
   chmod +x install.sh
   ```

3. **Run the unified installer:**
   ```sh
   ./install.sh
   ```

The unified installation script includes:
- ✅ Updates the system
- ✅ Installs all dependencies (core + AUR)
- ✅ Configures Hyprland and components
- ✅ Installs system utilities
- ✅ Configures development tools
- ✅ Installs fonts and themes
- ✅ Configures Hyperlock
- ✅ Configures enhanced notifications
- ✅ Installs multimedia tools (LMMS, Pixelorama, Upscayl)
- ✅ Installs image support (Neovim + Kitty)
- ✅ Installs security tools (UFW, WireGuard, Fail2ban, ClamAV)
- ✅ Configures firewall and VPN
- ✅ Copies all dotfiles to correct system locations
- ✅ Verifies complete installation
- ✅ Configures the system

## 🗑️ Uninstallation

### Complete Uninstallation

```bash
# Uninstall everything with backup
./uninstall.sh
```

The unified uninstallation script:
- ✅ Creates a complete backup of your current setup
- ✅ Uninstalls all packages (core + AUR)
- ✅ Removes all configurations
- ✅ Restores default system configurations
- ✅ Cleans the system completely
- ✅ Provides backup location for restoration

## 🔧 Maintenance & Repair

### System Repair

```bash
# Full system repair and maintenance
./repair.sh

# Only diagnose problems
./repair.sh --diagnose

# Only repair found issues
./repair.sh --repair

# Only clean system
./repair.sh --clean

# Only update system and dotfiles
./repair.sh --update

# Show system information
./repair.sh --info

# Show help
./repair.sh --help
```

The unified repair script includes:
- ✅ **Diagnosis** - Detects missing packages, configs, and permissions
- ✅ **Package Repair** - Fixes broken packages and AUR
- ✅ **Config Repair** - Restores missing configurations
- ✅ **Font Repair** - Reinstalls custom fonts
- ✅ **Permission Repair** - Fixes file permissions
- ✅ **System Cleaning** - Cleans cache and temporary files
- ✅ **Neovim Cleaning** - Cleans and reinstalls Neovim plugins
- ✅ **System Updates** - Updates system and dotfiles
- ✅ **Verification** - Verifies all repairs were successful

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
```

## 🎮 Gaming Features

### Gaming Tools

- **Steam** - Game distribution platform
- **Lutris** - Game manager and launcher
- **Wine** - Windows compatibility layer
- **GameMode** - Performance optimization
- **MangoHud** - Performance overlay
- **Heroic Games Launcher** - Epic Games launcher

### Gaming Configuration

```bash
# Enable GameMode for a game
gamemoderun ./game

# Check GameMode status
gamemoded -t

# Configure MangoHud
nano ~/.config/MangoHud/MangoHud.conf
```

## 🎵 Multimedia Tools

### Included Tools

- **LMMS** - Professional music production software
- **Pixelorama** - Advanced pixel art editor
- **Upscayl** - AI-powered image upscaler
- **OBS Studio** - Video recording and streaming
- **Krita** - Digital painting and illustration
- **GIMP** - Image manipulation
- **Inkscape** - Vector graphics editor

### Multimedia Commands

```bash
# Start LMMS
lmms

# Start Pixelorama
pixelorama

# Start Upscayl
upscayl

# Start OBS Studio
obs
```

## 🖼️ Image & SVG Support

### Neovim Image Support

- **Image display** - View images directly in Neovim
- **SVG support** - View SVG files with syntax highlighting
- **Markdown preview** - Images in markdown files
- **Image paste** - Paste images from clipboard

### Kitty Image Support

- **Image protocols** - Display images in terminal
- **Image caching** - Fast image loading
- **SVG rendering** - Vector graphics support

### Image Commands

```bash
# View image in Neovim
nvim image.png

# View SVG in Neovim
nvim file.svg

# View image in Kitty
kitty +kitten icat image.png

# Paste image in Neovim
SUPER + SHIFT + P
```

## 🛡️ Security Tools

### Included Security Tools

- **UFW** - Uncomplicated Firewall (simple and effective)
- **WireGuard** - Modern and fast VPN
- **Fail2ban** - Protection against brute force attacks
- **ClamAV** - Antivirus scanner
- **RKHunter** - Rootkit detection
- **Network monitoring tools** - nmap, tcpdump, netcat

### Security Configuration

```bash
# Check firewall status
sudo ufw status

# Allow specific port
sudo ufw allow 8080

# Start WireGuard VPN
sudo wg-quick up wg0

# Stop WireGuard VPN
sudo wg-quick down wg0

# Check Fail2ban status
sudo fail2ban-client status

# Update ClamAV database
sudo freshclam

# Run RKHunter scan
sudo rkhunter --check

# Network monitoring
sudo /usr/local/bin/network-monitor.sh

# Security manager (easier interface)
./security-manager.sh firewall status
./security-manager.sh vpn start wg0
./security-manager.sh clamav scan /home
```

### Security Features

- **Automatic firewall configuration** - UFW with sensible defaults
- **VPN setup** - WireGuard with key generation
- **Intrusion detection** - Fail2ban with SSH protection
- **Malware scanning** - ClamAV with automatic updates
- **Rootkit detection** - RKHunter with daily scans
- **Network monitoring** - Tools for network analysis
- **Security Manager** - Easy-to-use interface for all security tools

## 🛡️ Security Manager

### Easy Security Management

The `security-manager.sh` script provides an easy interface to manage all security tools:

```bash
# Firewall management
./security-manager.sh firewall status
./security-manager.sh firewall allow 8080
./security-manager.sh firewall deny 22

# VPN management
./security-manager.sh vpn status
./security-manager.sh vpn start wg0
./security-manager.sh vpn stop wg0
./security-manager.sh vpn keys

# Security scanning
./security-manager.sh clamav scan /home
./security-manager.sh clamav update
./security-manager.sh rkhunter scan
./security-manager.sh rkhunter update

# Network monitoring
./security-manager.sh network monitor
./security-manager.sh port scan 192.168.1.1
./security-manager.sh traffic monitor

# Show help
./security-manager.sh help
```

### Security Manager Features

- **Firewall control** - Easy UFW management
- **VPN management** - WireGuard interface control
- **Security scanning** - ClamAV and RKHunter integration
- **Network monitoring** - Built-in network analysis tools
- **Unified interface** - All security tools in one place

## 🖥️ Screenshot Tools

### Included Tools

- **Flameshot** - Advanced screenshot tool
- **Grim** - Wayland screenshot utility
- **Slurp** - Wayland region selector
- **Spectacle** - KDE screenshot tool
- **Maim** - X11 screenshot tool
- **Xclip** - Clipboard utility

### Screenshot Commands

```bash
# Take screenshot with Flameshot
flameshot gui

# Take screenshot with Grim
grim screenshot.png

# Select region and screenshot
grim -g "$(slurp)" screenshot.png

# Screenshot to clipboard
maim -s | xclip -selection clipboard -t image/png
```

## 🔧 Development Tools

### Included Tools

- **Node.js & npm** - JavaScript runtime
- **Python & pip** - Python programming
- **Rust** - Systems programming
- **Go** - Programming language
- **Java (OpenJDK)** - Java development
- **Docker** - Containerization
- **Git** - Version control

### Development Configuration

```bash
# Check Node.js version
node --version

# Check Python version
python --version

# Check Rust version
rustc --version

# Check Go version
go version

# Check Java version
java --version
```

## 📁 File Structure

```
arch-dots/
├── install.sh          # Unified installer
├── uninstall.sh        # Unified uninstaller
├── repair.sh           # Unified repair tool
├── utils.sh            # Utility scripts
├── README.md           # This file
├── INTEGRATION_README.md
├── LICENSE
└── dotfiles/
    ├── hypr/           # Hyprland configuration
    ├── kitty/          # Terminal configuration
    ├── nvim/           # Neovim configuration
    ├── fish/           # Fish shell configuration
    ├── eww/            # Desktop widgets
    ├── waybar/         # Status bar
    ├── wofi/           # Application launcher
    ├── mako/           # Notifications
    ├── swww/           # Wallpaper daemon
    ├── hyprlock/       # Screen locker
    ├── fonts/          # Custom fonts
    ├── wallpapers/     # Wallpaper collection
    ├── scripts/        # Utility scripts
    └── ...
```

## 🚀 Quick Start

1. **Install everything:**
   ```bash
   ./install.sh
   ```

2. **Reboot your system**

3. **Login with Hyprland**

4. **Use the system:**
   - `SUPER + RETURN` - Open terminal
   - `SUPER + D` - Application launcher
   - `SUPER + N` - Open Neovim
   - `SUPER + Q` - Close window
   - `SUPER + SHIFT + W` - Random wallpaper

## 🛠️ Troubleshooting

### Common Issues

1. **Hyprland not starting:**
   ```bash
   ./repair.sh --diagnose
   ./repair.sh --repair
   ```

2. **Neovim not working:**
   ```bash
   ./repair.sh --clean
   ```

3. **Missing packages:**
   ```bash
   ./repair.sh --repair
   ```

4. **Permission issues:**
   ```bash
   ./repair.sh --repair
   ```

### System Information

```bash
# Show system info
./repair.sh --info

# Check installation
./repair.sh --diagnose
```

## 📝 Logs

All operations are logged for debugging:

- **Installation log:** `~/.archriced-install.log`
- **Uninstall log:** `~/.archriced-uninstall.log`
- **Repair log:** `~/.archriced-repair.log`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Hyprland** - The amazing Wayland compositor
- **Catppuccin** - Beautiful color scheme
- **Nerd Fonts** - Icon fonts
- **Arch Linux** - The best Linux distribution

---

**Made with ❤️ by maurux01** 