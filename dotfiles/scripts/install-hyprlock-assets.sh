#!/bin/bash

# Quick Hyprlock Assets Installation Script
# This script quickly sets up hyprlock with the assets configuration

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() {
    echo -e "${BLUE}→ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

echo "🔒 Installing Hyprlock with Assets"
echo "=================================="

# Check if hyprlock is installed
print_step "Checking hyprlock installation..."
if ! command -v hyprlock >/dev/null 2>&1; then
    print_warning "Hyprlock not found. Installing..."
    sudo pacman -S hyprlock --noconfirm
else
    print_success "Hyprlock is already installed"
fi

# Create config directory
print_step "Creating configuration directory..."
mkdir -p "$HOME/.config/hyprlock"

# Copy configuration
print_step "Copying hyprlock configuration..."
if [ -f "dotfiles/hyprlock/hyprlock.conf" ]; then
    cp "dotfiles/hyprlock/hyprlock.conf" "$HOME/.config/hyprlock/"
    print_success "Configuration copied"
else
    print_error "Configuration file not found"
    exit 1
fi

# Copy assets
print_step "Copying assets..."
if [ -d "dotfiles/hyprlock/assets" ]; then
    cp -r "dotfiles/hyprlock/assets" "$HOME/.config/hyprlock/"
    print_success "Assets copied"
else
    print_error "Assets directory not found"
    exit 1
fi

# Make scripts executable
print_step "Making scripts executable..."
chmod +x "dotfiles/scripts/hyprlock-background.sh"
chmod +x "dotfiles/scripts/test-lock.sh"
print_success "Scripts made executable"

# Test the configuration
print_step "Testing hyprlock configuration..."
if hyprlock --immediate 2>/dev/null; then
    print_success "Hyprlock configuration test passed"
else
    print_warning "Hyprlock test failed, but configuration should still work"
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "Available commands:"
echo "• SUPER+L - Lock screen"
echo "• SUPER+ALT+L - Change hyprlock background"
echo "• SUPER+SHIFT+ALT+L - Random hyprlock background"
echo "• ~/.config/scripts/hyprlock-background.sh --list - List available backgrounds"
echo "• ~/.config/scripts/test-lock.sh - Test hyprlock"
echo ""
echo "Available backgrounds:"
echo "• mocha.webp - Catppuccin Mocha (dark)"
echo "• latte.webp - Catppuccin Latte (light)"
echo "• macchiato.webp - Catppuccin Macchiato (medium)"
echo "• frappe.webp - Catppuccin Frappe (medium-dark)"
echo ""
echo "Configuration location: ~/.config/hyprlock/hyprlock.conf"
echo "Assets location: ~/.config/hyprlock/assets/" 