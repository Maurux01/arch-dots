#!/bin/bash

# =============================================================================
# FIX NVIM PLUGINS - Remove problematic plugins
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}Fix Neovim Plugins${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_step() {
    echo -e "${YELLOW}→ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_header

print_step "Removing problematic plugins..."
rm -rf ~/.local/share/nvim/lazy/lazydocker.nvim
rm -rf ~/.local/share/nvim/lazy/telescope-command-palette.nvim
rm -rf ~/.local/share/nvim/lazy/telescope-docker.nvim
print_success "Problematic plugins removed"

print_step "Cleaning Neovim cache..."
rm -rf ~/.cache/nvim
print_success "Cache cleaned"

print_step "Starting Neovim to reinstall plugins..."
echo "Starting Neovim... Please wait for plugins to install."
echo "You can close Neovim once plugins are installed (Ctrl+C to cancel)"
read -p "Press Enter to continue..."

nvim --headless -c "Lazy! sync" -c "quit"

print_success "Neovim plugins fixed!"
echo ""
echo "You can now use Neovim normally. The problematic plugins have been removed."
echo "If you need Docker functionality, consider using:"
echo "  - LazyGit for Git operations"
echo "  - Terminal commands for Docker"
echo "  - Telescope for file navigation" 