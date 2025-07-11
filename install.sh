#!/bin/bash

# Script de instalación optimizado para Hyprland
# Versión simplificada y eficiente

set -e

# Output colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Global variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    Archriced - Optimized                     ║${NC}"
    echo -e "${BLUE}║                  by maurux01                                ║${NC}"
    echo -e "${BLUE}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_section() {
    echo -e "${CYAN}› $1${NC}"
    log "SECTION: $1"
}

print_step() {
    echo -e "${YELLOW}  → $1${NC}"
    log "STEP: $1"
}

print_success() {
    echo -e "${GREEN}  ✓ $1${NC}"
    log "SUCCESS: $1"
}

print_error() {
    echo -e "${RED}  ✗ $1${NC}"
    log "ERROR: $1"
}

print_warning() {
    echo -e "${YELLOW}  ⚠ $1${NC}"
    log "ADVERTENCIA: $1"
}

# Función para instalar paquetes de forma eficiente
install_packages() {
    local packages=("$@")
    local aur_packages=()
    local pacman_packages=()
    
    # Separar paquetes AUR de paquetes oficiales
    for pkg in "${packages[@]}"; do
        if [[ "$pkg" == "hyperlock" || "$pkg" == "oss" || "$pkg" == "nerd-fonts-complete" ]]; then
            aur_packages+=("$pkg")
        else
            pacman_packages+=("$pkg")
        fi
    done
    
    # Instalar paquetes oficiales
    if [ ${#pacman_packages[@]} -gt 0 ]; then
        print_step "Instalando paquetes oficiales..."
        sudo pacman -S "${pacman_packages[@]}" --noconfirm --needed
    fi
    
    # Instalar paquetes AUR
    if [ ${#aur_packages[@]} -gt 0 ]; then
        print_step "Instalando paquetes AUR..."
        for pkg in "${aur_packages[@]}"; do
            yay -S "$pkg" --noconfirm --needed
        done
    fi
}

# Función para verificar sistema
check_system() {
    print_section "Checking system..."
    
    if [ ! -f "/etc/arch-release" ]; then
        print_error "This script is designed for Arch Linux only."
        exit 1
    fi
    
    if [ "$EUID" -eq 0 ]; then
        print_error "Do not run this script as root."
        exit 1
    fi
    
    print_success "System verified."
}

# System update function
update_system() {
    print_section "Actualizando sistema..."
    sudo pacman -Sy --noconfirm
    print_success "Database updated."
}

# Minimal Hyprland installation function
install_hyprland_minimal() {
    print_section "Installing minimal Hyprland setup..."
    
    # Only the essentials for Hyprland/Wayland
    local essential_packages=(
        "hyprland"
        "waybar"
        "wofi"
        "mako"
        "swaylock"
        "swayidle"
        "flameshot"
        "wl-clipboard"
        "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk"
        "kitty"
        "fish"
        "neovim"
        "neofetch"
        "fastfetch"
        "bat"
        "fd"
        "ripgrep"
        "fzf"
        "btop"
        "htop"
        "pavucontrol"
        "blueman"
        "networkmanager"
        "network-manager-applet"
        "gdm"
        "exa"
        "starship"
        "zoxide"
        "nerd-fonts-jetbrains-mono"
        "jq"
        "curl"
    )
    
    print_step "Installing essential packages..."
    # Install in parallel for speed
    sudo pacman -S "${essential_packages[@]}" --noconfirm --needed --overwrite="*"
    
    print_success "Minimal Hyprland installed."
}

# Basic AUR helper installation function
install_aur_helper() {
    print_section "Installing AUR helper..."
    
    if command -v yay >/dev/null 2>&1; then
        print_success "yay is already installed."
        return
    fi
    
    print_step "Installing yay..."
    cd /tmp
    git clone --depth 1 https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --skippgpcheck
    cd "$SCRIPT_DIR"
    rm -rf /tmp/yay
    
    print_success "AUR helper installed."
}

# Función para instalar paquetes esenciales
install_essential_packages() {
    print_section "Instalando paquetes esenciales..."
    
    local essential_packages=(
        # Hyprland y componentes
        "hyprland" "waybar" "eww" "swww" "wofi" "mako" "swaylock"
        "swayidle" "grim" "slurp" "wl-clipboard" "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk"
        
        # Terminal y shell
        "kitty" "fish" "starship" "zoxide"
        
        # Editores
        "nvim"
        
        # Utilidades del sistema
        "bat" "fd" "ripgrep" "fzf" "btop" "exa"
        "pavucontrol" "blueman" "networkmanager" "network-manager-applet"
        
        # Herramientas de desarrollo
        "nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk"
        "gcc" "cmake" "ninja" "meson" "valgrind" "gdb"
        
        # Herramientas adicionales
        "lazygit" "yazi"
        
        # Reproductores multimedia
        "mpv" "vlc" "cava" "oss"
        
        # Portapapeles e historial
        "cliphist" "copyq"
        
        # Fuentes y temas
        "nerd-fonts-complete" "noto-fonts" "noto-fonts-emoji" 
        "ttf-dejavu" "ttf-liberation" "ttf-jetbrains-mono"
        "papirus-icon-theme" "bibata-cursor-theme"
        
        # Otros
        "jq" "curl" "gdm"
    )
    
    install_packages "${essential_packages[@]}"
    
    print_success "Paquetes esenciales instalados"
}

# Función para configurar Hyperlock
configure_hyperlock() {
    print_section "Configurando Hyperlock..."
    
    print_step "Instalando Hyperlock..."
    yay -S "hyperlock" --noconfirm --needed
    
    print_step "Configurando Hyperlock..."
    mkdir -p "$HOME/.config/hyperlock"
    
    # Crear configuración básica de Hyperlock
    cat > "$HOME/.config/hyperlock/config.toml" << 'EOF'
# Configuración de Hyperlock
[general]
idle_timeout = 300
show_indicator = true
indicator_position = "top"
indicator_color = "#89b4fa"
indicator_size = 2
show_datetime = true
datetime_format = "%H:%M"
datetime_position = "center"
datetime_color = "#cdd6f4"
datetime_font_size = 24
show_background = true
background_blur = 10
background_opacity = 0.8
show_lock_message = true
lock_message = "Pantalla bloqueada"
lock_message_color = "#cdd6f4"
lock_message_font_size = 16
lock_message_position = "bottom"
play_sound = false
show_battery = true
show_network = true
show_volume = true

[colors]
background = "#1e1e2e"
surface = "#313244"
primary = "#89b4fa"
secondary = "#f5c2e7"
accent = "#f38ba8"
text = "#cdd6f4"
text_secondary = "#a6adc8"
error = "#f38ba8"
success = "#a6e3a1"
warning = "#f9e2af"
EOF
    
    print_success "Hyperlock configurado"
}

# Función para configurar portapapeles e historial
configure_clipboard() {
    print_section "Configurando portapapeles e historial..."
    
    print_step "Configurando cliphist..."
    mkdir -p "$HOME/.config/cliphist"
    
    # Crear configuración de cliphist
    cat > "$HOME/.config/cliphist/config" << 'EOF'
# Configuración de cliphist
max-entries = 1000
max-size = 1000000
date-format = "%Y-%m-%d %H:%M:%S"
show-date = true
show-size = true
filter-duplicates = true
save-images = true
save-files = true
EOF
    
    print_step "Configurando copyq..."
    mkdir -p "$HOME/.config/copyq"
    
    # Crear configuración básica de copyq
    cat > "$HOME/.config/copyq/copyq.conf" << 'EOF'
[General]
autostart=true
closeOnUnfocus=true
closeOnMouseDown=true
showTrayIcon=true
trayIconCommands=show
maxItems=100
saveImages=true
saveUrls=true
saveFormats=text/plain,text/html,image/png,image/jpeg,image/gif
move=true
viMode=false
checkClipboard=true
monitoring=true
notificationPosition=top-right
notificationMaximumWidth=300
notificationMaximumHeight=200
notificationTimeout=3000
notificationOpacity=0.8
notificationIconSize=24
notificationFontSize=10
notificationFontFamily=AdawitaMono Nerd Font
notificationBackgroundColor=#1e1e2e
notificationTextColor=#cdd6f4
notificationBorderColor=#89b4fa
notificationBorderWidth=1
notificationBorderRadius=8
notificationShadow=true
notificationShadowColor=#000000
notificationShadowBlurRadius=10
notificationShadowOffsetX=0
notificationShadowOffsetY=2
EOF
    
    print_success "Portapapeles e historial configurado"
}

# Función para copiar wallpapers
copy_wallpapers() {
    print_section "Copiando wallpapers..."
    local user_pictures="$HOME/Pictures"
    [ -d "$user_pictures" ] || user_pictures="$HOME/Imágenes"
    mkdir -p "$user_pictures"
    if [ -d "$DOTFILES_DIR/wallpapers" ]; then
        cp -r "$DOTFILES_DIR/wallpapers"/* "$user_pictures/"
        print_success "Wallpapers copiados a $user_pictures"
    else
        print_warning "No se encontró la carpeta de wallpapers en dotfiles."
    fi
}

# Dotfiles copy function
copy_dotfiles() {
    print_section "Copying dotfiles..."
    
    print_step "Creating directories..."
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/share"
    mkdir -p "$HOME/.local/bin"
    
    print_step "Copying configurations..."
    
    # Map folders to their correct paths
    declare -A config_paths=(
        ["hypr"]="$HOME/.config/hypr"
        ["waybar"]="$HOME/.config/waybar"
        ["kitty"]="$HOME/.config/kitty"
        ["nvim"]="$HOME/.config/nvim"
        ["eww"]="$HOME/.config/eww"
        ["wofi"]="$HOME/.config/wofi"
        ["mako"]="$HOME/.config/mako"
        ["swww"]="$HOME/.config/swww"
        ["fish"]="$HOME/.config/fish"
        ["tmux"]="$HOME/.config/tmux"
        ["neofetch"]="$HOME/.config/neofetch"
        ["wallpapers"]="$HOME/.local/share/wallpapers"
    )
    
    # Copy each folder to its correct location
    for item in "$DOTFILES_DIR"/*; do
        if [ -d "$item" ]; then
            local dirname=$(basename "$item")
            local target_path="${config_paths[$dirname]}"
            
            if [ -n "$target_path" ]; then
                print_step "Copying $dirname to $target_path..."
                mkdir -p "$(dirname "$target_path")"
                cp -r "$item"/* "$target_path/" 2>/dev/null || cp -r "$item" "$(dirname "$target_path")/"
            else
                print_step "Copying $dirname to ~/.config/$dirname..."
                cp -r "$item" "$HOME/.config/"
            fi
        fi
    done
    
    # Make scripts executable
    print_step "Making scripts executable..."
    chmod +x "$HOME/.config/waybar/scripts"/*.sh 2>/dev/null || true
    chmod +x "$HOME/.config/scripts"/*.sh 2>/dev/null || true
    
    # Copy random wallpaper script
    if [ -f "$DOTFILES_DIR/scripts/random-wallpaper.sh" ]; then
        print_step "Copying random wallpaper script..."
        mkdir -p "$HOME/.config/dotfiles/scripts"
        cp "$DOTFILES_DIR/scripts/random-wallpaper.sh" "$HOME/.config/dotfiles/scripts/"
        chmod +x "$HOME/.config/dotfiles/scripts/random-wallpaper.sh"
    fi
    
    # Copy specific configuration files
    if [ -f "$DOTFILES_DIR/fish/config.fish" ]; then
        print_step "Copying Fish configuration..."
        mkdir -p "$HOME/.config/fish"
        cp "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/"
    fi
    
    if [ -f "$DOTFILES_DIR/neofetch/neofetch.conf" ]; then
        print_step "Copying Neofetch configuration..."
        mkdir -p "$HOME/.config/neofetch"
        cp "$DOTFILES_DIR/neofetch/neofetch.conf" "$HOME/.config/neofetch/"
    fi
    
    if [ -f "$DOTFILES_DIR/neofetch/fastfetch.jsonc" ]; then
        print_step "Copying Fastfetch configuration..."
        cp "$DOTFILES_DIR/neofetch/fastfetch.jsonc" "$HOME/.config/"
    fi
    
    print_success "Dotfiles copied."
}

# Basic system configuration function
configure_system() {
    print_section "Configuring system..."
    
    print_step "Configuring permissions and services..."
    # Do everything in parallel for speed
    sudo usermod -aG wheel "$USER" &
    sudo systemctl enable NetworkManager bluetooth gdm &
    sudo chsh -s /usr/bin/fish "$USER" &
    wait
    
    print_step "Configuring GDM for Hyprland..."
    # Create Hyprland configuration file for GDM
    sudo mkdir -p /usr/share/wayland-sessions
    sudo tee /usr/share/wayland-sessions/hyprland.desktop > /dev/null << 'EOF'
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
    
    print_success "System configured."
}

# Final information display function
show_final_info() {
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}║                    INSTALLATION COMPLETED                   ║${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo "Next steps:"
    echo "1. Reboot your system"
    echo "2. Log in with Hyprland"
    echo ""
    
    echo "Basic commands:"
    echo "• SUPER+N - Neovim (Default editor)"
    echo "• SUPER+B - Browser (Firefox)"
    echo "• SUPER+D - Application launcher"
    echo "• SUPER+RETURN - Terminal"
    echo "• SUPER+Q - Close window"
    echo "• SUPER+SHIFT+W - Random wallpaper"
    echo ""
    
    echo "To install more applications:"
    echo "• sudo pacman -S [package]"
    echo "• yay -S [aur-package]"
    echo ""
}

# Main function
main() {
    print_header
    check_system
    update_system
    install_aur_helper
    install_essential_packages
    copy_wallpapers
    configure_hyperlock
    configure_clipboard
    copy_dotfiles
    configure_system
    show_final_info
}

# Execute main function
main "$@" 
