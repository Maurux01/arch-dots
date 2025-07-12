#!/bin/bash

# =============================================================================
# 🎨 FONT CHANGER SCRIPT
# =============================================================================
# Script para cambiar fuentes en todas las aplicaciones
# =============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration files
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"
NVIM_CONFIG="$HOME/.config/nvim/lua/config/options.lua"
TMUX_CONFIG="$HOME/.config/tmux/tmux-themes.conf"

# Available fonts
declare -A FONTS=(
    ["1"]="JetBrains Mono Nerd Font"
    ["2"]="FiraCode Nerd Font"
    ["3"]="Cascadia Code Nerd Font"
    ["4"]="Hack Nerd Font"
    ["5"]="Source Code Pro Nerd Font"
    ["6"]="Ubuntu Mono Nerd Font"
    ["7"]="Monaco Nerd Font"
    ["8"]="Menlo Nerd Font"
    ["9"]="Consolas Nerd Font"
    ["10"]="Inconsolata Nerd Font"
)

# Font sizes
declare -A SIZES=(
    ["1"]="10"
    ["2"]="11"
    ["3"]="12"
    ["4"]="13"
    ["5"]="14"
    ["6"]="16"
    ["7"]="18"
    ["8"]="20"
)

print_header() {
    echo -e "${BLUE}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                        🎨 FONT CHANGER SCRIPT                           ║${NC}"
    echo -e "${BLUE}║                           by maurux01                                    ║${NC}"
    echo -e "${BLUE}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ $1${NC}"
}

# Function to show available fonts
show_fonts() {
    echo -e "${BLUE}Available fonts:${NC}"
    for key in "${!FONTS[@]}"; do
        echo -e "  ${YELLOW}$key${NC}: ${FONTS[$key]}"
    done
    echo ""
}

# Function to show available sizes
show_sizes() {
    echo -e "${BLUE}Available sizes:${NC}"
    for key in "${!SIZES[@]}"; do
        echo -e "  ${YELLOW}$key${NC}: ${SIZES[$key]}"
    done
    echo ""
}

# Function to change Kitty font
change_kitty_font() {
    local font="$1"
    local size="$2"
    
    if [ -f "$KITTY_CONFIG" ]; then
        # Backup original config
        cp "$KITTY_CONFIG" "$KITTY_CONFIG.backup"
        
        # Update font configuration
        sed -i "s/font_family .*/font_family $font/" "$KITTY_CONFIG"
        sed -i "s/font_size .*/font_size $size/" "$KITTY_CONFIG"
        
        # Update font features
        sed -i "s/font_features .*NerdFont-Regular +liga +calt/font_features ${font// /}NerdFont-Regular +liga +calt/" "$KITTY_CONFIG"
        sed -i "s/font_features .*NerdFont-Bold +liga +calt/font_features ${font// /}NerdFont-Bold +liga +calt/" "$KITTY_CONFIG"
        sed -i "s/font_features .*NerdFont-Italic +liga +calt/font_features ${font// /}NerdFont-Italic +liga +calt/" "$KITTY_CONFIG"
        sed -i "s/font_features .*NerdFont-BoldItalic +liga +calt/font_features ${font// /}NerdFont-BoldItalic +liga +calt/" "$KITTY_CONFIG"
        
        # Update symbol mapping
        sed -i "s/symbol_map .* ${font// /}NerdFont-Regular/symbol_map U+E5FA-U+E62B,U+E700-U+E7C5,U+E200-U+E2A9,U+E300-U+E3EB,U+F000-U+F2E0,U+E000-U+E00A,U+F500-U+FD46,U+E0020-U+E007F,U+F0000-U+FFFFD,U+100000-U+10FFFD ${font// /}NerdFont-Regular/" "$KITTY_CONFIG"
        
        print_success "Kitty font changed to $font (size: $size)"
    else
        print_error "Kitty config not found at $KITTY_CONFIG"
    fi
}

# Function to change Neovim font
change_nvim_font() {
    local font="$1"
    local size="$2"
    
    if [ -f "$NVIM_CONFIG" ]; then
        # Backup original config
        cp "$NVIM_CONFIG" "$NVIM_CONFIG.backup"
        
        # Update font configuration
        sed -i "s/vim.opt.guifont = \".*\"/vim.opt.guifont = \"$font:h$size\"/" "$NVIM_CONFIG"
        
        print_success "Neovim font changed to $font (size: $size)"
    else
        print_error "Neovim config not found at $NVIM_CONFIG"
    fi
}

# Function to update font cache
update_font_cache() {
    print_info "Updating font cache..."
    fc-cache -fv
    print_success "Font cache updated"
}

# Function to reload applications
reload_applications() {
    print_info "Reloading applications..."
    
    # Reload Hyprland
    if command -v hyprctl >/dev/null 2>&1; then
        hyprctl reload
        print_success "Hyprland reloaded"
    fi
    
    # Restart Kitty if running
    if pgrep -x "kitty" >/dev/null; then
        print_info "Restarting Kitty..."
        pkill kitty
        sleep 1
        kitty &
        print_success "Kitty restarted"
    fi
    
    print_success "Applications reloaded"
}

# Main function
main() {
    print_header
    
    # Check if running in interactive mode
    if [ "$1" = "--list" ]; then
        show_fonts
        show_sizes
        exit 0
    fi
    
    # Interactive mode
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo -e "${CYAN}Font Changer - Interactive Mode${NC}"
        echo ""
        show_fonts
        show_sizes
        echo ""
        
        read -p "Enter font number (1-10): " font_choice
        read -p "Enter size number (1-8): " size_choice
        
        if [ -z "$font_choice" ] || [ -z "$size_choice" ]; then
            print_error "Invalid input"
            exit 1
        fi
        
        font="${FONTS[$font_choice]}"
        size="${SIZES[$size_choice]}"
        
        if [ -z "$font" ] || [ -z "$size" ]; then
            print_error "Invalid font or size selection"
            exit 1
        fi
    else
        # Command line mode
        font_choice="$1"
        size_choice="$2"
        
        font="${FONTS[$font_choice]}"
        size="${SIZES[$size_choice]}"
        
        if [ -z "$font" ] || [ -z "$size" ]; then
            print_error "Invalid font or size selection"
            echo "Usage: $0 [font_number] [size_number]"
            echo "Use: $0 --list to see available options"
            exit 1
        fi
    fi
    
    echo ""
    print_info "Changing font to: $font (size: $size)"
    echo ""
    
    # Change fonts
    change_kitty_font "$font" "$size"
    change_nvim_font "$font" "$size"
    
    # Update font cache
    update_font_cache
    
    # Reload applications
    reload_applications
    
    echo ""
    print_success "Font change completed!"
    print_info "You may need to restart your applications to see the changes"
    echo ""
}

# Show help
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Font Changer Script"
    echo ""
    echo "Usage:"
    echo "  $0                    # Interactive mode"
    echo "  $0 [font] [size]      # Command line mode"
    echo "  $0 --list             # Show available fonts and sizes"
    echo "  $0 --help             # Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 1 3               # JetBrains Mono Nerd Font, size 12"
    echo "  $0 2 4               # FiraCode Nerd Font, size 13"
    echo ""
    exit 0
fi

# Execute main function
main "$@" 