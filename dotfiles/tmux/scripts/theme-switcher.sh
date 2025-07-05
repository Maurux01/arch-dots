#!/bin/bash

# =============================================================================
# TMUX THEME SWITCHER - TmuXpert
# =============================================================================

THEMES_FILE="$HOME/.tmux/tmux-themes.conf"
TMUX_CONF="$HOME/.tmux.conf"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Function to show available themes
show_themes() {
    print_header "Available Themes"
    echo -e "${CYAN}1.${NC}  Tokyo Night     ${PURPLE}- Elegant dark theme with blue accents${NC}"
    echo -e "${CYAN}2.${NC}  Catppuccin      ${PURPLE}- Smooth mocha-flavored theme${NC}"
    echo -e "${CYAN}3.${NC}  Dracula         ${PURPLE}- Vibrant purple and pink theme${NC}"
    echo -e "${CYAN}4.${NC}  Gruvbox         ${PURPLE}- Classic high-contrast theme${NC}"
    echo -e "${CYAN}5.${NC}  Nord            ${PURPLE}- Clean Arctic-inspired theme${NC}"
    echo -e "${CYAN}6.${NC}  Material        ${PURPLE}- Google Material Design inspired${NC}"
    echo -e "${CYAN}7.${NC}  One Dark        ${PURPLE}- Atom-inspired dark theme${NC}"
    echo -e "${CYAN}8.${NC}  Solarized       ${PURPLE}- Eye-friendly dark theme${NC}"
    echo -e "${CYAN}9.${NC}  Monokai         ${PURPLE}- Vibrant and colorful theme${NC}"
    echo -e "${CYAN}10.${NC} Rose Pine       ${PURPLE}- Natural pine and lilac theme${NC}"
    echo -e "${CYAN}11.${NC} Kanagawa        ${PURPLE}- Traditional Japanese-inspired${NC}"
    echo -e "${CYAN}12.${NC} Everforest      ${PURPLE}- Warm, nature-inspired theme${NC}"
    echo -e "${CYAN}13.${NC} Doom One        ${PURPLE}- Doom Emacs inspired${NC}"
    echo -e "${CYAN}14.${NC} Carbonfox       ${PURPLE}- Carbon-inspired dark theme${NC}"
    echo -e "${CYAN}15.${NC} Oxocarbon       ${PURPLE}- IBM Carbon design system${NC}"
    echo -e "${CYAN}16.${NC} Melange         ${PURPLE}- Warm and cozy dark theme${NC}"
    echo -e "${CYAN}17.${NC} Modus Vivendi   ${PURPLE}- Accessible high-contrast theme${NC}"
    echo -e "${CYAN}18.${NC} Vim One         ${PURPLE}- Enhanced One Dark theme${NC}"
    echo -e "${CYAN}19.${NC} Papercolor      ${PURPLE}- Material Design inspired light theme${NC}"
    echo ""
}

# Function to apply theme
apply_theme() {
    local theme_name="$1"
    local theme_lower=$(echo "$theme_name" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
    
    print_header "Applying $theme_name Theme"
    
    # Extract theme configuration from themes file
    local theme_start=$(grep -n "THEME: $theme_name" "$THEMES_FILE" | cut -d: -f1)
    if [ -z "$theme_start" ]; then
        print_error "Theme '$theme_name' not found!"
        return 1
    fi
    
    local theme_end=$(grep -n "THEME:" "$THEMES_FILE" | grep -A1 "THEME: $theme_name" | tail -1 | cut -d: -f1)
    if [ "$theme_end" = "$theme_start" ]; then
        theme_end=$(wc -l < "$THEMES_FILE")
    else
        theme_end=$((theme_end - 1))
    fi
    
    # Extract theme lines
    local theme_lines=$(sed -n "${theme_start},${theme_end}p" "$THEMES_FILE" | grep "^set -g @theme-")
    
    # Backup current config
    cp "$TMUX_CONF" "$TMUX_CONF.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Remove existing theme configurations
    sed -i '/^set -g @theme-/d' "$TMUX_CONF"
    
    # Add new theme configuration
    echo "" >> "$TMUX_CONF"
    echo "# =============================================================================" >> "$TMUX_CONF"
    echo "# ACTIVE THEME: $theme_name" >> "$TMUX_CONF"
    echo "# =============================================================================" >> "$TMUX_CONF"
    echo "$theme_lines" >> "$TMUX_CONF"
    
    # Apply theme settings
    echo "$theme_lines" | while read line; do
        if [[ $line =~ @theme-([^-]+)-status-style ]]; then
            local style="${BASH_REMATCH[1]}"
            local status_style=$(echo "$line" | sed 's/set -g @theme-[^-]*-status-style "//' | sed 's/"//')
            tmux set -g status-style "$status_style" 2>/dev/null || true
        elif [[ $line =~ @theme-([^-]+)-window-status-current-style ]]; then
            local style="${BASH_REMATCH[1]}"
            local window_style=$(echo "$line" | sed 's/set -g @theme-[^-]*-window-status-current-style "//' | sed 's/"//')
            tmux set -g window-status-current-style "$window_style" 2>/dev/null || true
        elif [[ $line =~ @theme-([^-]+)-status-left ]]; then
            local style="${BASH_REMATCH[1]}"
            local status_left=$(echo "$line" | sed 's/set -g @theme-[^-]*-status-left "//' | sed 's/"//')
            tmux set -g status-left "$status_left" 2>/dev/null || true
        elif [[ $line =~ @theme-([^-]+)-status-right ]]; then
            local style="${BASH_REMATCH[1]}"
            local status_right=$(echo "$line" | sed 's/set -g @theme-[^-]*-status-right "//' | sed 's/"//')
            tmux set -g status-right "$status_right" 2>/dev/null || true
        fi
    done
    
    print_status "Theme '$theme_name' applied successfully!"
    print_status "Configuration saved to ~/.tmux.conf"
    
    # Reload tmux config if inside tmux
    if [ -n "$TMUX" ]; then
        tmux source-file ~/.tmux.conf 2>/dev/null || true
        print_status "Tmux configuration reloaded!"
    fi
}

# Function to show current theme
show_current_theme() {
    print_header "Current Theme"
    
    local current_theme=$(grep "ACTIVE THEME:" "$TMUX_CONF" 2>/dev/null | head -1 | sed 's/.*ACTIVE THEME: //')
    
    if [ -n "$current_theme" ]; then
        echo -e "${GREEN}Current theme:${NC} $current_theme"
    else
        echo -e "${YELLOW}No theme is currently active (using default)${NC}"
    fi
}

# Function to apply random theme
apply_random_theme() {
    local themes=(
        "Tokyo Night"
        "Catppuccin"
        "Dracula"
        "Gruvbox"
        "Nord"
        "Material"
        "One Dark"
        "Solarized"
        "Monokai"
        "Rose Pine"
        "Kanagawa"
        "Everforest"
        "Doom One"
        "Carbonfox"
        "Oxocarbon"
        "Melange"
        "Modus Vivendi"
        "Vim One"
        "Papercolor"
    )
    
    local random_theme="${themes[$((RANDOM % ${#themes[@]}))]}"
    print_status "Randomly selected theme: $random_theme"
    apply_theme "$random_theme"
}

# Main script logic
case "$1" in
    "list"|"show"|"themes")
        show_themes
        ;;
    "current"|"show-current")
        show_current_theme
        ;;
    "random")
        apply_random_theme
        ;;
    "tokyo-night"|"tokyo")
        apply_theme "Tokyo Night"
        ;;
    "catppuccin"|"cat")
        apply_theme "Catppuccin"
        ;;
    "dracula"|"dra")
        apply_theme "Dracula"
        ;;
    "gruvbox"|"gruv")
        apply_theme "Gruvbox"
        ;;
    "nord")
        apply_theme "Nord"
        ;;
    "material"|"mat")
        apply_theme "Material"
        ;;
    "one-dark"|"onedark")
        apply_theme "One Dark"
        ;;
    "solarized"|"sol")
        apply_theme "Solarized"
        ;;
    "monokai"|"mono")
        apply_theme "Monokai"
        ;;
    "rose-pine"|"rose")
        apply_theme "Rose Pine"
        ;;
    "kanagawa"|"kana")
        apply_theme "Kanagawa"
        ;;
    "everforest"|"ever")
        apply_theme "Everforest"
        ;;
    "doom-one"|"doom")
        apply_theme "Doom One"
        ;;
    "carbonfox"|"carbon")
        apply_theme "Carbonfox"
        ;;
    "oxocarbon"|"oxo")
        apply_theme "Oxocarbon"
        ;;
    "melange"|"mel")
        apply_theme "Melange"
        ;;
    "modus-vivendi"|"modus")
        apply_theme "Modus Vivendi"
        ;;
    "vim-one"|"vim")
        apply_theme "Vim One"
        ;;
    "papercolor"|"paper")
        apply_theme "Papercolor"
        ;;
    "help"|"-h"|"--help"|"")
        print_header "Tmux Theme Switcher"
        echo "Usage: $0 [theme_name|command]"
        echo ""
        echo "Commands:"
        echo "  list, show, themes     - Show all available themes"
        echo "  current, show-current  - Show current active theme"
        echo "  random                 - Apply a random theme"
        echo "  help                   - Show this help message"
        echo ""
        echo "Theme names:"
        echo "  tokyo-night, catppuccin, dracula, gruvbox, nord"
        echo "  material, one-dark, solarized, monokai, rose-pine"
        echo "  kanagawa, everforest, doom-one, carbonfox, oxocarbon"
        echo "  melange, modus-vivendi, vim-one, papercolor"
        echo ""
        echo "Examples:"
        echo "  $0 tokyo-night"
        echo "  $0 random"
        echo "  $0 list"
        ;;
    *)
        print_error "Unknown theme or command: $1"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac 