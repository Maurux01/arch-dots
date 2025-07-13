#!/bin/bash

# Script to install and configure Monokai Pro theme for Neovim

echo "🎨 Installing Monokai Pro theme for Neovim..."

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo "❌ Neovim is not installed. Please install Neovim first."
    exit 1
fi

# Create config directory if it doesn't exist
CONFIG_DIR="$HOME/.config/nvim"
if [ ! -d "$CONFIG_DIR" ]; then
    echo "📁 Creating Neovim config directory..."
    mkdir -p "$CONFIG_DIR"
fi

# Copy dotfiles to config directory
echo "📋 Copying Neovim configuration..."
cp -r dotfiles/nvim/* "$CONFIG_DIR/"

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x "$CONFIG_DIR/install.sh"
chmod +x "$CONFIG_DIR/curl-install.sh"

# Install Neovim configuration
echo "⚙️ Installing Neovim configuration..."
cd "$CONFIG_DIR"
./install.sh

echo "✅ Monokai Pro theme installation complete!"
echo ""
echo "🎯 To use Monokai Pro theme:"
echo "   1. Open Neovim: nvim"
echo "   2. Switch to Monokai Pro: :colorscheme monokai-pro"
echo "   3. Or use the theme switcher: <leader> + t"
echo ""
echo "🔄 Available themes:"
echo "   - tokyonight (default)"
echo "   - catppuccin"
echo "   - gruvbox"
echo "   - dracula"
echo "   - habamax"
echo "   - monokai-pro (NEW!)"
echo ""
echo "💡 Tip: Use the theme switcher to cycle through themes quickly!" 