#!/bin/bash

# =============================================================================
#                           🎨 KITTY THEME SWITCHER 🎨
# =============================================================================
# Author: Mauro Infante (maurux01)
# Description: Easy theme switching for Kitty terminal
# =============================================================================

KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"
BACKUP_CONFIG="$HOME/.config/kitty/kitty.conf.backup"

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
    echo -e "${CYAN}================================${NC}"
    echo -e "${CYAN}    🎨 KITTY THEME SWITCHER 🎨${NC}"
    echo -e "${CYAN}================================${NC}"
}

# Function to backup current config
backup_config() {
    if [[ -f "$KITTY_CONFIG" ]]; then
        cp "$KITTY_CONFIG" "$BACKUP_CONFIG"
        print_status "Configuración respaldada en $BACKUP_CONFIG"
    fi
}

# Function to restore backup
restore_backup() {
    if [[ -f "$BACKUP_CONFIG" ]]; then
        cp "$BACKUP_CONFIG" "$KITTY_CONFIG"
        print_status "Configuración restaurada desde el respaldo"
    else
        print_error "No se encontró archivo de respaldo"
        exit 1
    fi
}

# Function to apply theme
apply_theme() {
    local theme_name="$1"
    
    case "$theme_name" in
        "main")
            apply_main_theme
            ;;
        "moon")
            apply_moon_theme
            ;;
        "tokyo")
            apply_tokyo_theme
            ;;
        "catppuccin")
            apply_catppuccin_theme
            ;;
        "dracula")
            apply_dracula_theme
            ;;
        "gruvbox")
            apply_gruvbox_theme
            ;;
        "nord")
            apply_nord_theme
            ;;
        *)
            print_error "Tema '$theme_name' no reconocido"
            show_help
            exit 1
            ;;
    esac
    
    print_status "Tema '$theme_name' aplicado exitosamente"
    print_status "Reinicia Kitty para ver los cambios"
}

# Theme definitions
apply_main_theme() {
    cat > "$KITTY_CONFIG" << 'EOF'
# =============================================================================
#                           🐱 KITTY CONFIGURATION 🐱
# =============================================================================
# Author: Mauro Infante (maurux01)
# Theme: Beautiful dark themes with custom enhancements
# Description: Beautiful and functional Kitty terminal configuration
# =============================================================================

# =============================================================================
#                           🎨 COLOR SCHEME
# =============================================================================
# Beautiful dark color palette with custom enhancements
# Main theme (default)
background #191724
foreground #e0def4
selection_background #31748f
selection_foreground #e0def4
url_color #c4a7e7
cursor #e0def4
cursor_text_color #191724

# Terminal colors (16 colors) - Main Theme
color0 #26233a
color1 #eb6f92
color2 #9ccfd8
color3 #f6c177
color4 #31748f
color5 #c4a7e7
color6 #ebbcba
color7 #e0def4
color8 #6e6a86
color9 #eb6f92
color10 #9ccfd8
color11 #f6c177
color12 #31748f
color13 #c4a7e7
color14 #ebbcba
color15 #e0def4

# =============================================================================
#                           📝 FONT CONFIGURATION
# =============================================================================
# Font settings for crisp, beautiful text rendering
font_family JetBrains Mono Nerd Font
font_size 12.0
bold_font auto
italic_font auto
bold_italic_font auto

# Font features for better rendering
font_features JetBrainsMonoNerdFont-Regular +liga +calt
font_features JetBrainsMonoNerdFont-Bold +liga +calt
font_features JetBrainsMonoNerdFont-Italic +liga +calt
font_features JetBrainsMonoNerdFont-BoldItalic +liga +calt

# Symbol mapping for powerline and other symbols
symbol_map U+E5FA-U+E62B,U+E700-U+E7C5,U+E200-U+E2A9,U+E300-U+E3EB,U+F000-U+F2E0,U+E000-U+E00A,U+F500-U+FD46,U+E0020-U+E007F,U+F0000-U+FFFFD,U+100000-U+10FFFD JetBrainsMonoNerdFont-Regular

# =============================================================================
#                           🖥️ WINDOW & LAYOUT
# =============================================================================
# Window appearance
window_padding_width 15
window_border_width 2
window_margin_width 0
window_border_color #31748f
active_border_color #c4a7e7
inactive_border_color #26233a

# Window behavior
window_resize_step_cells 2
window_resize_step_lines 2
window_placement_strategy center
hide_window_decorations titlebar-only
confirm_os_window_close 0

# Tab bar appearance
tab_bar_edge bottom
tab_bar_style powerline
tab_bar_min_tabs 2
tab_powerline_style slanted
tab_title_template "{index}: {title}"
active_tab_title_template "{index}: {title}"
tab_bar_background #191724
active_tab_background #31748f
active_tab_foreground #e0def4
inactive_tab_background #26233a
inactive_tab_foreground #6e6a86

# =============================================================================
#                           ⚡ PERFORMANCE & BEHAVIOR
# =============================================================================
# Performance settings
sync_to_monitor yes
repaint_delay 10
input_delay 3
visual_bell_duration 0.0
enable_audio_bell no

# Mouse behavior
mouse_hide_wait 3.0
focus_follows_mouse yes
pointer_shape_when_grabbed hand
default_pointer_shape arrow

# =============================================================================
#                           🎯 ADVANCED FEATURES
# =============================================================================
# Clipboard integration
clipboard_control write-clipboard write-primary read-clipboard read-primary

# Shell integration
shell_integration enabled
allow_hyperlinks yes

# Keyboard shortcuts
map ctrl+shift+equal change_font_size all +1.0
map ctrl+shift+minus change_font_size all -1.0
map ctrl+shift+0 change_font_size all 0

# Tab management
map ctrl+shift+t new_tab_with_cwd
map ctrl+shift+w close_tab
map ctrl+shift+right next_tab
map ctrl+shift+left previous_tab
map ctrl+shift+1 goto_tab 1
map ctrl+shift+2 goto_tab 2
map ctrl+shift+3 goto_tab 3
map ctrl+shift+4 goto_tab 4
map ctrl+shift+5 goto_tab 5
map ctrl+shift+6 goto_tab 6
map ctrl+shift+7 goto_tab 7
map ctrl+shift+8 goto_tab 8
map ctrl+shift+9 goto_tab 9

# Window management
map ctrl+shift+enter new_window_with_cwd
map ctrl+shift+n new_os_window_with_cwd
map ctrl+shift+o toggle_layout stack

# Copy and paste
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+v paste_from_clipboard

# =============================================================================
#                           🌟 CUSTOM FEATURES
# =============================================================================
# Background image (optional - uncomment if you want)
# background_image /path/to/your/background.png
# background_image_layout scaled
# background_tint 0.9

# Custom environment variables
env TERM=xterm-256color
env COLORTERM=truecolor

# =============================================================================
EOF
}

apply_moon_theme() {
    cat > "$KITTY_CONFIG" << 'EOF'
# =============================================================================
#                           🐱 KITTY CONFIGURATION 🐱
# =============================================================================
# Author: Mauro Infante (maurux01)
# Theme: Moon Theme (Darker variant)
# =============================================================================

# =============================================================================
#                           🎨 COLOR SCHEME - MOON THEME
# =============================================================================
background #232136
foreground #e0def4
selection_background #3e8fb0
selection_foreground #e0def4
url_color #c4a7e7
cursor #e0def4
cursor_text_color #232136

# Terminal colors (16 colors) - Moon Theme
color0 #393552
color1 #eb6f92
color2 #3e8fb0
color3 #f6c177
color4 #9ccfd8
color5 #c4a7e7
color6 #ea9a97
color7 #e0def4
color8 #6e6a86
color9 #eb6f92
color10 #3e8fb0
color11 #f6c177
color12 #9ccfd8
color13 #c4a7e7
color14 #ea9a97
color15 #e0def4

# =============================================================================
#                           📝 FONT CONFIGURATION
# =============================================================================
font_family JetBrains Mono Nerd Font
font_size 12.0
bold_font auto
italic_font auto
bold_italic_font auto

# Font features for better rendering
font_features JetBrainsMonoNerdFont-Regular +liga +calt
font_features JetBrainsMonoNerdFont-Bold +liga +calt
font_features JetBrainsMonoNerdFont-Italic +liga +calt
font_features JetBrainsMonoNerdFont-BoldItalic +liga +calt

# Symbol mapping for powerline and other symbols
symbol_map U+E5FA-U+E62B,U+E700-U+E7C5,U+E200-U+E2A9,U+E300-U+E3EB,U+F000-U+F2E0,U+E000-U+E00A,U+F500-U+FD46,U+E0020-U+E007F,U+F0000-U+FFFFD,U+100000-U+10FFFD JetBrainsMonoNerdFont-Regular

# =============================================================================
#                           🖥️ WINDOW & LAYOUT
# =============================================================================
window_padding_width 15
window_border_width 2
window_margin_width 0
window_border_color #3e8fb0
active_border_color #c4a7e7
inactive_border_color #393552

window_resize_step_cells 2
window_resize_step_lines 2
window_placement_strategy center
hide_window_decorations titlebar-only
confirm_os_window_close 0

# Tab bar appearance
tab_bar_edge bottom
tab_bar_style powerline
tab_bar_min_tabs 2
tab_powerline_style slanted
tab_title_template "{index}: {title}"
active_tab_title_template "{index}: {title}"
tab_bar_background #232136
active_tab_background #3e8fb0
active_tab_foreground #e0def4
inactive_tab_background #393552
inactive_tab_foreground #6e6a86

# =============================================================================
#                           ⚡ PERFORMANCE & BEHAVIOR
# =============================================================================
sync_to_monitor yes
repaint_delay 10
input_delay 3
visual_bell_duration 0.0
enable_audio_bell no

mouse_hide_wait 3.0
focus_follows_mouse yes
pointer_shape_when_grabbed hand
default_pointer_shape arrow

# =============================================================================
#                           🎯 ADVANCED FEATURES
# =============================================================================
clipboard_control write-clipboard write-primary read-clipboard read-primary
shell_integration enabled
allow_hyperlinks yes

# Keyboard shortcuts
map ctrl+shift+equal change_font_size all +1.0
map ctrl+shift+minus change_font_size all -1.0
map ctrl+shift+0 change_font_size all 0

# Tab management
map ctrl+shift+t new_tab_with_cwd
map ctrl+shift+w close_tab
map ctrl+shift+right next_tab
map ctrl+shift+left previous_tab
map ctrl+shift+1 goto_tab 1
map ctrl+shift+2 goto_tab 2
map ctrl+shift+3 goto_tab 3
map ctrl+shift+4 goto_tab 4
map ctrl+shift+5 goto_tab 5
map ctrl+shift+6 goto_tab 6
map ctrl+shift+7 goto_tab 7
map ctrl+shift+8 goto_tab 8
map ctrl+shift+9 goto_tab 9

# Window management
map ctrl+shift+enter new_window_with_cwd
map ctrl+shift+n new_os_window_with_cwd
map ctrl+shift+o toggle_layout stack

# Copy and paste
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+v paste_from_clipboard

# =============================================================================
#                           🌟 CUSTOM FEATURES
# =============================================================================
env TERM=xterm-256color
env COLORTERM=truecolor

# =============================================================================
EOF
}

# Function to show available themes
show_themes() {
    print_header
    echo -e "${BLUE}Temas disponibles:${NC}"
    echo -e "  ${GREEN}main${NC}       - Tema principal (Rose-pine)"
    echo -e "  ${GREEN}moon${NC}       - Tema lunar (más oscuro)"
    echo -e "  ${GREEN}tokyo${NC}      - Tokyo Night Dark"
    echo -e "  ${GREEN}catppuccin${NC} - Catppuccin Mocha"
    echo -e "  ${GREEN}dracula${NC}    - Dracula"
    echo -e "  ${GREEN}gruvbox${NC}    - Gruvbox Dark"
    echo -e "  ${GREEN}nord${NC}       - Nord"
    echo ""
    echo -e "${YELLOW}Uso:${NC} $0 <tema>"
    echo -e "${YELLOW}Ejemplo:${NC} $0 tokyo"
}

# Function to show help
show_help() {
    print_header
    echo -e "${BLUE}Uso:${NC} $0 [OPCIÓN]"
    echo ""
    echo -e "${BLUE}Opciones:${NC}"
    echo -e "  ${GREEN}<tema>${NC}     - Aplicar tema específico"
    echo -e "  ${GREEN}list${NC}       - Mostrar temas disponibles"
    echo -e "  ${GREEN}backup${NC}     - Crear respaldo de configuración actual"
    echo -e "  ${GREEN}restore${NC}    - Restaurar configuración desde respaldo"
    echo -e "  ${GREEN}help${NC}       - Mostrar esta ayuda"
    echo ""
    echo -e "${BLUE}Ejemplos:${NC}"
    echo -e "  $0 main"
    echo -e "  $0 tokyo"
    echo -e "  $0 list"
}

# Main script logic
main() {
    if [[ ! -f "$KITTY_CONFIG" ]]; then
        print_error "No se encontró la configuración de Kitty en $KITTY_CONFIG"
        exit 1
    fi

    case "$1" in
        "list")
            show_themes
            ;;
        "backup")
            backup_config
            ;;
        "restore")
            restore_backup
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        "")
            show_help
            ;;
        *)
            backup_config
            apply_theme "$1"
            ;;
    esac
}

# Run main function with all arguments
main "$@" 