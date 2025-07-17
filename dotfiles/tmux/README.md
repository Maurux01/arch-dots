# Modern Tmux Configuration

## 🎨 Overview

A modern, visually appealing Tmux configuration with enhanced functionality, beautiful status bar, and seamless integration with development tools.

## ✨ Features

- **Modern Status Bar**: Elegant status bar with icons, colors, and Nerd Fonts support
- **System Information**: Real-time display of time, date, battery, network, CPU, disk usage
- **Git Integration**: Shows current branch and repository status
- **Enhanced Navigation**: Improved window and pane navigation shortcuts
- **Copy/Paste**: Easy clipboard integration with `xclip` or `wl-clipboard`
- **Plugin Management**: TPM (Tmux Plugin Manager) for easy plugin management
- **Theme Support**: Dark themes (Catppuccin, Gruvbox) with true color support
- **Development Integration**: FZF, LazyGit, and Neovim integration
- **Hot Reload**: Configuration reload with a single shortcut

## 🚀 Quick Installation

### 1. Install Dependencies

```bash
# Install Tmux and dependencies
sudo pacman -S tmux tpm fzf git lazygit

# Install clipboard tools (choose one)
sudo pacman -S xclip        # For X11# OR
sudo pacman -S wl-clipboard # For Wayland

# Install Nerd Fonts (if not already installed)
sudo pacman -S nerd-fonts-jetbrains-mono
```

### 2. Install Configuration

```bash
# Copy configuration files
cp -r dotfiles/tmux ~/.config/

# Create symlink for tmux config
ln -sf ~/.config/tmux/tmux.conf ~/.tmux.conf

# Install plugins
tmux source-file ~/.tmux.conf
```

## 📁 File Structure

```
~/.config/tmux/
├── tmux.conf                 # Main configuration file
├── plugins/                  # Plugin configurations
│   ├── status-bar.conf      # Status bar configuration
│   ├── navigation.conf      # Navigation shortcuts
│   ├── copy-paste.conf      # Copy/paste settings
│   ├── themes.conf          # Theme configurations
│   └── integrations.conf    # Development tool integrations
├── scripts/                 # Custom scripts
│   ├── battery.sh           # Battery status script
│   ├── cpu.sh              # CPU usage script
│   ├── disk.sh             # Disk usage script
│   ├── network.sh          # Network status script
│   └── git.sh              # Git status script
└── themes/                  # Theme files
    ├── catppuccin.conf     # Catppuccin theme
    └── gruvbox.conf        # Gruvbox theme
```

## 🎮 Keybindings

### Navigation
- `<prefix> h/j/k/l` - Navigate panes (vim-style)
- `<prefix> H/J/K/L` - Resize panes
- `<prefix> <C-h/j/k/l>` - Navigate windows
- `<prefix> <C-H/J/K/L>` - Move windows
- `<prefix> <Space>` - Next window
- `<prefix> <Backspace>` - Previous window

### Copy/Paste
- `<prefix> y` - Copy selection
- `<prefix> p` - Paste
- `<prefix> Y` - Copy current pane
- `<prefix> P` - Paste in current pane

### Development
- `<prefix> f` - FZF session switcher
- `<prefix> g` - LazyGit in new pane
- `<prefix> n` - Neovim in new pane
- `<prefix> t` - New terminal pane

### Configuration
- `<prefix> r` - Reload configuration
- `<prefix> R` - Reload configuration (force)
- `<prefix> ?` - Show keybindings

## 🎨 Themes

### Catppuccin (Default)
- Modern dark theme with excellent contrast
- Beautiful colors and smooth transitions
- Great for long coding sessions

### Gruvbox
- Classic warm theme
- Excellent readability
- Popular among developers

## 🔧 Configuration

### Status Bar Components

**Left Side:**
- Session name
- Window list with current window highlighted
- Git branch and status

**Right Side:**
- CPU usage
- Memory usage
- Disk usage
- Network status
- Battery level
- Date and time

### Customization

Edit theme files in `~/.config/tmux/themes/`:

```bash
# Switch to Gruvbox theme
echo 'source-file ~/.config/tmux/themes/gruvbox.conf' >> ~/.config/tmux/tmux.conf

# Reload configuration
tmux source-file ~/.tmux.conf
```

## 🛠️ Troubleshooting

### Common Issues

1. **Icons not showing**:
   ```bash
   # Ensure Nerd Fonts are installed
   fc-list | grep -i nerd
   
   # Set font in terminal
   echo 'set -g default-terminal screen-256lor' >> ~/.config/tmux/tmux.conf
   ```

2. **Copy/paste not working**:
   ```bash
   # Check clipboard tool
   which xclip || which wl-copy
   
   # Test clipboard
   echo "test" | xclip -selection clipboard
   ```

3. **True color not working**:
   ```bash
   # Add to tmux.conf
   set -g default-terminal tmux-256  set -ag terminal-overrides,xterm-256color:RGB"
   ```

### Performance Tips

1*Reduce status bar update frequency**:
   ```bash
   set -g status-interval 5 ```

2. **Disable unused plugins**:
   ```bash
   # Comment out unused plugins in tmux.conf
   ```

## 📚 Additional Resources

- [Tmux Manual](https://man.openbsd.org/tmux.1)
- [TPM Documentation](https://github.com/tmux-plugins/tpm)
-Catppuccin Theme](https://github.com/catppuccin/catppuccin)
- [Nerd Fonts](https://www.nerdfonts.com/)

## 🤝 Contributing

Feel free to submit issues and enhancement requests for the configuration.

---

**Enjoy your modern Tmux experience! 🚀** 