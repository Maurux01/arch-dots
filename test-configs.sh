#!/bin/bash

# Test script to verify configuration copying
echo "🧪 Testing configuration copying..."

# Test Tmux config
echo "📋 Testing Tmux configuration..."
if [ -f "dotfiles/tmux/.tmux.conf" ]; then
    cp "dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
    echo "✅ Tmux config copied to $HOME/.tmux.conf"
else
    echo "❌ Tmux config not found"
fi

# Test Kitty config
echo "📋 Testing Kitty configuration..."
if [ -f "dotfiles/kitty/kitty.conf" ]; then
    mkdir -p "$HOME/.config/kitty"
    cp "dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    echo "✅ Kitty config copied to $HOME/.config/kitty/kitty.conf"
else
    echo "❌ Kitty config not found"
fi

# Test theme switcher
echo "📋 Testing Kitty theme switcher..."
if [ -f "dotfiles/kitty/theme-switcher.sh" ]; then
    cp "dotfiles/kitty/theme-switcher.sh" "$HOME/.config/kitty/"
    chmod +x "$HOME/.config/kitty/theme-switcher.sh"
    echo "✅ Theme switcher copied to $HOME/.config/kitty/theme-switcher.sh"
else
    echo "❌ Theme switcher not found"
fi

echo "�� Test completed!" 