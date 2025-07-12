#!/bin/bash

# Fish Config Installer
# This script installs the Fish configuration to the correct location

echo "🐟 Installing Fish configuration..."

# Check if Fish is installed
if ! command -v fish &> /dev/null; then
    echo "❌ Fish is not installed. Please install Fish first:"
    echo "   Arch: sudo pacman -S fish"
    echo "   Ubuntu/Debian: sudo apt install fish"
    echo "   macOS: brew install fish"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.fish"

# Check if config.fish exists in the script directory
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ config.fish not found in: $CONFIG_FILE"
    echo "   Please make sure config.fish is in the same directory as this script."
    exit 1
fi

# Create Fish config directory if it doesn't exist
FISH_CONFIG_DIR="$HOME/.config/fish"
mkdir -p "$FISH_CONFIG_DIR"

# Backup existing config if it exists
if [ -f "$FISH_CONFIG_DIR/config.fish" ]; then
    echo "📦 Backing up existing config.fish..."
    cp "$FISH_CONFIG_DIR/config.fish" "$FISH_CONFIG_DIR/config.fish.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Copy the config file
echo "📋 Copying config.fish..."
cp "$CONFIG_FILE" "$FISH_CONFIG_DIR/config.fish"

# Check if copy was successful
if [ $? -eq 0 ]; then
    echo "✅ Fish configuration installed successfully!"
    echo "📍 Location: $FISH_CONFIG_DIR/config.fish"
    echo ""
    echo "🔄 To apply changes:"
    echo "   - Restart your terminal"
    echo "   - Or run: source $FISH_CONFIG_DIR/config.fish"
    echo ""
    echo "🎨 Make sure you have Gruvbox theme installed in your terminal!"
else
    echo "❌ Failed to install Fish configuration"
    exit 1
fi 