#!/bin/bash

# Neofetch Configuration Installer
# This script installs neofetch and copies the configuration files

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_status "Starting Neofetch configuration installation..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if neofetch is installed
if ! command -v neofetch &> /dev/null; then
    print_warning "Neofetch not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S neofetch --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install neofetch -y
    elif command -v yum &> /dev/null; then
        sudo yum install neofetch -y
    else
        print_error "Could not install neofetch automatically. Please install it manually."
        exit 1
    fi
fi

print_success "Neofetch is installed"

# Check if fastfetch is installed (optional)
if ! command -v fastfetch &> /dev/null; then
    print_warning "Fastfetch not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S fastfetch --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install fastfetch -y
    elif command -v yum &> /dev/null; then
        sudo yum install fastfetch -y
    else
        print_warning "Could not install fastfetch automatically. You can install it manually later."
    fi
fi

# Create backup of existing neofetch config if it exists
if [ -f "$HOME/.config/neofetch/config.conf" ]; then
    BACKUP_FILE="$HOME/.config/neofetch/config.conf.backup.$(date +%Y%m%d_%H%M%S)"
    print_warning "Existing neofetch configuration found"
    print_status "Creating backup at $BACKUP_FILE"
    cp "$HOME/.config/neofetch/config.conf" "$BACKUP_FILE"
    print_success "Backup created successfully"
fi

# Create neofetch config directory
print_status "Creating neofetch configuration directory..."
mkdir -p "$HOME/.config/neofetch"

# Copy neofetch configuration
print_status "Copying neofetch configuration..."
cp "$SCRIPT_DIR/neofetch.conf" "$HOME/.config/neofetch/config.conf"

# Copy fastfetch configuration if it exists
if [ -f "$SCRIPT_DIR/fastfetch.jsonc" ]; then
    print_status "Copying fastfetch configuration..."
    cp "$SCRIPT_DIR/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"
fi

# Set proper permissions
print_status "Setting proper permissions..."
chmod 644 "$HOME/.config/neofetch/config.conf"
if [ -f "$HOME/.config/fastfetch/config.jsonc" ]; then
    chmod 644 "$HOME/.config/fastfetch/config.jsonc"
fi

print_success "Neofetch configuration installed successfully!"

echo ""
echo -e "${GREEN}🎉 Neofetch configuration has been installed successfully!${NC}"
echo ""
echo -e "${BLUE}Configuration files:${NC}"
echo "• Neofetch: ${YELLOW}~/.config/neofetch/config.conf${NC}"
if [ -f "$HOME/.config/fastfetch/config.jsonc" ]; then
    echo "• Fastfetch: ${YELLOW}~/.config/fastfetch/config.jsonc${NC}"
fi
echo ""
echo -e "${BLUE}Usage:${NC}"
echo "• Run neofetch: ${YELLOW}neofetch${NC}"
echo "• Run fastfetch: ${YELLOW}fastfetch${NC}"
echo ""
echo -e "${BLUE}Features:${NC}"
echo "• Colorful Arch Linux ASCII art"
echo "• System information display"
echo "• Hardware information"
echo "• Package count"
echo "• Theme and icon information"
echo ""
if [ -n "$BACKUP_FILE" ]; then
    echo -e "${BLUE}Previous configuration backed up to:${NC}"
    echo "${YELLOW}$BACKUP_FILE${NC}"
fi
echo ""
echo -e "${GREEN}Happy system info displaying! 🖥️${NC}" 