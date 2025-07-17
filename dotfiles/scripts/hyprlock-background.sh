#!/bin/bash

# Hyprlock Background Changer
# This script allows you to change the hyprlock background using available assets

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$HOME/.config/hyprlock/hyprlock.conf"
ASSETS_DIR="$HOME/.config/hyprlock/assets"

# Available backgrounds
BACKGROUNDS=(
    "mocha.webp:Catppuccin Mocha"
    "latte.webp:Catppuccin Latte"
    "macchiato.webp:Catppuccin Macchiato"
    "frappe.webp:Catppuccin Frappe"
)

show_help() {
    echo "Hyprlock Background Changer"
    echo ""
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  -l, --list     List available backgrounds"
    echo "  -s, --set      Set background interactively"
    echo "  -r, --random   Set random background"
    echo "  -h, --help     Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 --list                    # List available backgrounds"
    echo "  $0 --set                     # Interactive background selection"
    echo "  $0 --random                  # Set random background"
    echo "  $0 mocha.webp               # Set specific background"
}

list_backgrounds() {
    echo "Available backgrounds:"
    echo ""
    for bg in "${BACKGROUNDS[@]}"; do
        IFS=':' read -r filename name <<< "$bg"
        if [ -f "$ASSETS_DIR/$filename" ]; then
            echo "  ✓ $filename - $name"
        else
            echo "  ✗ $filename - $name (not found)"
        fi
    done
    echo ""
}

set_background() {
    local background_file="$1"
    
    # Check if file exists
    if [ ! -f "$ASSETS_DIR/$background_file" ]; then
        echo "Error: Background file '$background_file' not found in $ASSETS_DIR"
        return 1
    fi
    
    # Check if config file exists
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Error: Hyprlock config file not found at $CONFIG_FILE"
        return 1
    fi
    
    # Backup current config
    cp "$CONFIG_FILE" "$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Update the background path in config
    sed -i "s|path = .*|path = $ASSETS_DIR/$background_file|" "$CONFIG_FILE"
    
    echo "Background changed to: $background_file"
    echo "Config backup saved as: $CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
}

interactive_selection() {
    echo "Select a background:"
    echo ""
    
    local options=()
    local valid_files=()
    
    for bg in "${BACKGROUNDS[@]}"; do
        IFS=':' read -r filename name <<< "$bg"
        if [ -f "$ASSETS_DIR/$filename" ]; then
            options+=("$filename" "$name")
            valid_files+=("$filename")
        fi
    done
    
    if [ ${#valid_files[@]} -eq 0 ]; then
        echo "No background files found in $ASSETS_DIR"
        return 1
    fi
    
    # Use whiptail if available, otherwise use simple selection
    if command -v whiptail >/dev/null 2>&1; then
        local choice=$(whiptail --title "Hyprlock Background" \
            --menu "Choose a background:" 20 60 10 \
            "${options[@]}" 3>&1 1>&2 2>&3)
        
        if [ -n "$choice" ]; then
            set_background "$choice"
        else
            echo "Selection cancelled"
        fi
    else
        echo "Available backgrounds:"
        for i in "${!valid_files[@]}"; do
            echo "  $((i+1)). ${valid_files[$i]}"
        done
        echo ""
        read -p "Enter number (1-${#valid_files[@]}): " selection
        
        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#valid_files[@]} ]; then
            local selected_file="${valid_files[$((selection-1))]}"
            set_background "$selected_file"
        else
            echo "Invalid selection"
        fi
    fi
}

random_background() {
    local valid_files=()
    
    for bg in "${BACKGROUNDS[@]}"; do
        IFS=':' read -r filename name <<< "$bg"
        if [ -f "$ASSETS_DIR/$filename" ]; then
            valid_files+=("$filename")
        fi
    done
    
    if [ ${#valid_files[@]} -eq 0 ]; then
        echo "No background files found in $ASSETS_DIR"
        return 1
    fi
    
    local random_index=$((RANDOM % ${#valid_files[@]}))
    local selected_file="${valid_files[$random_index]}"
    
    set_background "$selected_file"
}

# Main script logic
case "${1:-}" in
    -l|--list)
        list_backgrounds
        ;;
    -s|--set)
        interactive_selection
        ;;
    -r|--random)
        random_background
        ;;
    -h|--help)
        show_help
        ;;
    "")
        show_help
        ;;
    *)
        # Assume it's a background filename
        set_background "$1"
        ;;
esac 