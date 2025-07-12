# 📝 Custom Fonts

This folder contains custom fonts for the system.

## 🎯 Configured Fonts

### Terminal (Kitty)
- **Main font**: JetBrains Mono Nerd Font
- **Size**: 12
- **Configuration**: `dotfiles/kitty/kitty.conf`

### Neovim
- **Main font**: JetBrains Mono Nerd Font
- **Size**: 12
- **Configuration**: `dotfiles/nvim_backup/lua/config/options.lua`

### Tmux
- **Main font**: JetBrains Mono Nerd Font
- **Size**: 12
- **Configuration**: `dotfiles/tmux/tmux-themes.conf`

## 📁 How to Add Fonts

1. **Place your font files** in this folder:
   - Supported formats: `.ttf`, `.otf`, `.woff`, `.woff2`
   - Recommended names: `CustomFont-Regular.ttf`, `CustomFont-Bold.ttf`, etc.

2. **Run the installation script** to install the fonts:
   ```bash
   ./install.sh
   ```

3. **Fonts will be automatically installed** in:
   - `~/.local/share/fonts/` (for user)
   - `/usr/share/fonts/` (for system, requires sudo)

## 🔧 Automatic Configuration

The installation script automatically:
- Copies fonts to the correct locations
- Updates the system font cache
- Configures applications to use the fonts

## 📋 Recommended Fonts

### For Terminal/Development
- **JetBrains Mono Nerd Font** (already configured)
- **FiraCode Nerd Font**
- **Cascadia Code Nerd Font**
- **Hack Nerd Font**

### For Interface
- **Inter** (for UI)
- **SF Pro Display** (for UI)
- **Roboto** (for UI)

## 🎨 Customization

To change fonts in applications:

### Kitty (Terminal)
```bash
# Edit configuration
nvim ~/.config/kitty/kitty.conf

# Change the line:
font_family JetBrains Mono Nerd Font
font_size 12
```

### Neovim
```bash
# Edit configuration
nvim ~/.config/nvim/lua/config/options.lua

# Change the line:
vim.opt.guifont = "JetBrains Mono Nerd Font:h12"
```

### Tmux
```bash
# Edit configuration
nvim ~/.config/tmux/tmux-themes.conf

# Change the line:
set -g default-terminal "tmux-256color"
set -g terminal-overrides ",xterm-256color:Tc"
```

## 🔄 Update Fonts

To update the font cache after adding new fonts:

```bash
# Update font cache
fc-cache -fv

# Restart applications
hyprctl reload
```

## 📝 Notes

- Nerd Fonts include icons for development
- Fonts should be in TTF/OTF format for better compatibility
- Some fonts may require administrator permissions for global installation 