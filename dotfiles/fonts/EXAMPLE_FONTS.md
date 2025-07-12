# 📝 Custom Fonts Example

This folder is for your custom fonts. You can place font files in `.ttf`, `.otf`, `.woff`, or `.woff2` format.

## 🎯 How to Add Fonts

1. **Download your fonts** in TTF/OTF format
2. **Place them in this folder** (`dotfiles/fonts/`)
3. **Run the installation script** to install them automatically

## 📋 Recommended Fonts

### Nerd Fonts (with icons)
- **JetBrains Mono Nerd Font** - Excellent for development
- **FiraCode Nerd Font** - With ligatures
- **Cascadia Code Nerd Font** - From Microsoft
- **Hack Nerd Font** - Very readable
- **Source Code Pro Nerd Font** - From Adobe

### Interface Fonts
- **Inter** - For modern UI
- **SF Pro Display** - For elegant UI
- **Roboto** - For clear UI

## 📁 File Structure

```
dotfiles/fonts/
├── JetBrainsMonoNerdFont-Regular.ttf
├── JetBrainsMonoNerdFont-Bold.ttf
├── JetBrainsMonoNerdFont-Italic.ttf
├── JetBrainsMonoNerdFont-BoldItalic.ttf
├── FiraCodeNerdFont-Regular.ttf
├── FiraCodeNerdFont-Bold.ttf
├── CascadiaCodeNerdFont-Regular.ttf
├── CascadiaCodeNerdFont-Bold.ttf
└── ... (your other fonts)
```

## 🔧 Automatic Configuration

The installation script automatically:
- Copies fonts to `~/.local/share/fonts/`
- Updates the system font cache
- Configures applications to use the fonts

## 🎨 Change Fonts

After adding fonts, you can change them easily:

```bash
# See available fonts
~/.config/scripts/change-font.sh --list

# Change font interactively
~/.config/scripts/change-font.sh

# Change specific font
~/.config/scripts/change-font.sh 1 3  # JetBrains Mono, size 12
```

## 📝 Important Notes

- **Format**: Use `.ttf` or `.otf` files for better compatibility
- **Names**: Keep original file names
- **Nerd Fonts**: Include icons for development (recommended)
- **Size**: Fonts scale automatically

## 🔄 Update Fonts

If you add new fonts after installation:

```bash
# Update font cache
fc-cache -fv

# Restart applications
hyprctl reload
```

## 🎯 Configured Applications

- **Kitty (Terminal)**: `~/.config/kitty/kitty.conf`
- **Neovim**: `~/.config/nvim/lua/config/options.lua`
- **Tmux**: `~/.config/tmux/tmux-themes.conf`

All these applications will automatically use the fonts you place here. 