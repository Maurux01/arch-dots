#!/bin/bash

# One-liner installation script for NVimX-1
# Usage: curl -fsSL https://raw.githubusercontent.com/yourusername/NVimX-1/main/curl-install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

# Configuration
REPO_URL="https://github.com/yourusername/NVimX-1.git"
TEMP_DIR="/tmp/nvimx1-install"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

print_status "🚀 Starting NVimX-1 installation..."

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    print_error "Neovim is not installed. Please install Neovim first."
    print_status "You can install it with: sudo pacman -S neovim"
    exit 1
fi

print_success "Neovim is installed"

# Create backup of existing config if it exists
if [ -d "$NVIM_CONFIG_DIR" ]; then
    BACKUP_DIR="$NVIM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
    print_warning "Existing Neovim configuration found at $NVIM_CONFIG_DIR"
    print_status "Creating backup at $BACKUP_DIR"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    print_success "Backup created successfully"
fi

# Clone repository to temp directory
print_status "Cloning NVimX-1 repository..."
rm -rf "$TEMP_DIR"
git clone "$REPO_URL" "$TEMP_DIR"

# Create the nvim config directory
print_status "Creating Neovim configuration directory..."
mkdir -p "$NVIM_CONFIG_DIR"

# Copy all files from the repository to the nvim config directory
print_status "Copying configuration files..."
cp -r "$TEMP_DIR"/* "$NVIM_CONFIG_DIR/"

# Remove the curl install script from the destination
rm -f "$NVIM_CONFIG_DIR/curl-install.sh"

# Set proper permissions
print_status "Setting proper permissions..."
chmod -R 755 "$NVIM_CONFIG_DIR"

# Clean up temp directory
rm -rf "$TEMP_DIR"

print_success "Configuration files copied successfully!"

# Install dependencies
print_status "Checking for dependencies..."

# Check for ripgrep
if ! command -v rg &> /dev/null; then
    print_warning "ripgrep not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S ripgrep --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install ripgrep -y
    elif command -v yum &> /dev/null; then
        sudo yum install ripgrep -y
    else
        print_error "Could not install ripgrep automatically. Please install it manually."
    fi
fi

# Check for fd
if ! command -v fd &> /dev/null; then
    print_warning "fd not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S fd --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install fd-find -y
    elif command -v yum &> /dev/null; then
        sudo yum install fd-find -y
    else
        print_error "Could not install fd automatically. Please install it manually."
    fi
fi

# Check for Node.js
if ! command -v node &> /dev/null; then
    print_warning "Node.js not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S nodejs npm --noconfirm
    elif command -v apt &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        sudo apt-get install -y nodejs
    elif command -v yum &> /dev/null; then
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
        sudo yum install nodejs -y
    else
        print_error "Could not install Node.js automatically. Please install it manually."
    fi
fi

# Install global npm packages for web development
print_status "Installing global npm packages..."
if command -v npm &> /dev/null; then
    npm install -g live-server typescript-language-server @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier
    print_success "Global npm packages installed"
else
    print_warning "npm not available. Please install Node.js and npm manually."
fi

print_success "Installation completed successfully!"

echo ""
echo -e "${GREEN}🎉 NVimX-1 has been installed successfully!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Start Neovim: ${YELLOW}nvim${NC}"
echo "2. Wait for plugins to install automatically"
echo "3. Enjoy your new Neovim configuration!"
echo ""
echo -e "${BLUE}Key features:${NC}"
echo "• Theme switching: ${YELLOW}<leader>ut${NC}"
echo "• File finder: ${YELLOW}<leader>ff${NC}"
echo "• Live grep: ${YELLOW}<leader>fg${NC}"
echo "• File explorer: ${YELLOW}<leader>e${NC}"
echo "• Terminal: ${YELLOW}<leader>t${NC}"
echo ""
echo -e "${BLUE}If you had a previous configuration, it was backed up to:${NC}"
if [ -n "$BACKUP_DIR" ]; then
    echo "${YELLOW}$BACKUP_DIR${NC}"
fi
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}" 