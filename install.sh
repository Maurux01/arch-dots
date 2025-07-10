#!/bin/bash

# Script de instalación simplificado para Hyprland
# Solo instala lo mínimo necesario

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variables globales
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

# Función para logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    Archriced - Simple                       ║${NC}"
    echo -e "${BLUE}║                  by maurux01                                ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo -e "${CYAN}▸ $1${NC}"
    log "SECCIÓN: $1"
}

print_step() {
    echo -e "${YELLOW}  → $1${NC}"
    log "PASO: $1"
}

print_success() {
    echo -e "${GREEN}  ✓ $1${NC}"
    log "ÉXITO: $1"
}

print_error() {
    echo -e "${RED}  ✗ $1${NC}"
    log "ERROR: $1"
}

<<<<<<< HEAD
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
        if [[ "$pkg" == "heroic-games-launcher" || "$pkg" == "hyperlock" ]]; then
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

=======
>>>>>>> c9651f0c7a71909e175e0a6e8d32e13436871899
# Función para verificar sistema
check_system() {
    print_section "Verificando sistema..."
    
    if [ ! -f "/etc/arch-release" ]; then
        print_error "Este script está diseñado para Arch Linux"
        exit 1
    fi
    
    if [ "$EUID" -eq 0 ]; then
        print_error "No ejecutes este script como root"
        exit 1
    fi
    
    print_success "Sistema verificado"
}

# Función para actualizar sistema
update_system() {
    print_section "Actualizando sistema..."
    # Solo actualizar base de datos, no todo el sistema
    sudo pacman -Sy --noconfirm
    print_success "Base de datos actualizada"
}

# Función para instalar Hyprland mínimo
install_hyprland_minimal() {
    print_section "Instalando Hyprland mínimo..."
    
    # Solo lo esencial para Hyprland/Wayland
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
    
    print_step "Instalando paquetes esenciales..."
    # Instalar en paralelo para mayor velocidad
    sudo pacman -S "${essential_packages[@]}" --noconfirm --needed --overwrite="*"
    
    print_success "Hyprland mínimo instalado"
}

# Función para instalar AUR helper básico
install_aur_helper() {
    print_section "Instalando AUR helper..."
    
    if command -v yay >/dev/null 2>&1; then
        print_success "yay ya está instalado"
        return
    fi
    
    print_step "Instalando yay..."
    cd /tmp
    git clone --depth 1 https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --skippgpcheck
    cd "$SCRIPT_DIR"
    rm -rf /tmp/yay
    
    print_success "AUR helper instalado"
}

<<<<<<< HEAD
# Función para instalar Hyprland y componentes
install_hyprland() {
    print_section "Instalando Hyprland y componentes..."
    
    local hyprland_packages=(
        "hyprland" "waybar" "eww" "swww" "wofi" "mako" "swaylock"
        "swayidle" "grim" "slurp" "wl-clipboard" "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk" "kitty" "neovim" "fish" "starship"
    )
    
    install_packages "${hyprland_packages[@]}"
    print_success "Hyprland y componentes instalados"
}

# Función para instalar utilidades del sistema
install_system_utils() {
    print_section "Instalando utilidades del sistema..."
    
    local util_packages=(
        "bat" "fd" "ripgrep" "fzf" "lazygit" "yazi" "btop" "htop"
        "neofetch" "fastfetch" "cava" "pavucontrol" "blueman"
        "networkmanager" "network-manager-applet" "mpv" "vlc"
        "steam" "lutris" "wine" "gamemode" "mangohud"
        "cliphist" "copyq" "heroic-games-launcher"
    )
    
    install_packages "${util_packages[@]}"
    print_success "Utilidades del sistema instaladas"
}

# Función para instalar desarrollo
install_development() {
    print_section "Instalando herramientas de desarrollo..."
    
    local dev_packages=(
        "nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk"
        "gcc" "cmake" "ninja" "meson" "valgrind" "gdb"
    )
    
    install_packages "${dev_packages[@]}"
    print_success "Herramientas de desarrollo instaladas"
}

# Función para instalar fuentes y temas
install_fonts_themes() {
    print_section "Instalando fuentes y temas..."
    
    local font_packages=(
        "nerd-fonts-jetbrains-mono" "nerd-fonts-fira-code" "noto-fonts"
        "noto-fonts-emoji" "ttf-dejavu" "ttf-liberation"
    )
    
    local theme_packages=(
        "catppuccin-gtk-theme" "papirus-icon-theme" "bibata-cursor-theme"
        "adwaita-icon-theme" "gnome-themes-extra"
    )
    
    install_packages "${font_packages[@]}" "${theme_packages[@]}"
    print_success "Fuentes y temas instalados"
}

# Función para configurar Hyperlock
configure_hyperlock() {
    print_section "Configurando Hyperlock..."
    
    install_packages "hyperlock"
    
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
notificationFontFamily=JetBrains Mono
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

=======
>>>>>>> c9651f0c7a71909e175e0a6e8d32e13436871899
# Función para copiar dotfiles
copy_dotfiles() {
    print_section "Copiando dotfiles..."
    
    print_step "Creando directorios..."
    mkdir -p "$HOME/.config"
    
    print_step "Copiando configuraciones..."
    
    # Mapeo de carpetas a sus rutas correctas
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
        ["scripts"]="$HOME/.config/scripts"
    )
    
    # Copiar cada carpeta a su ubicación correcta
    for item in "$DOTFILES_DIR"/*; do
        if [ -d "$item" ]; then
            local dirname=$(basename "$item")
            local target_path="${config_paths[$dirname]}"
            
            if [ -n "$target_path" ]; then
                print_step "Copiando $dirname a $target_path..."
                mkdir -p "$(dirname "$target_path")"
                cp -r "$item"/* "$target_path/" 2>/dev/null || cp -r "$item" "$(dirname "$target_path")/"
            else
                print_step "Copiando $dirname a ~/.config/$dirname..."
                cp -r "$item" "$HOME/.config/"
            fi
        fi
    done
    
    # Hacer scripts ejecutables
    print_step "Haciendo scripts ejecutables..."
    chmod +x "$HOME/.config/waybar/scripts"/*.sh 2>/dev/null || true
    chmod +x "$HOME/.config/scripts"/*.sh 2>/dev/null || true
    
    # Copiar script de wallpaper aleatorio
    if [ -f "$DOTFILES_DIR/scripts/random-wallpaper.sh" ]; then
        print_step "Copiando script de wallpaper aleatorio..."
        mkdir -p "$HOME/.config/dotfiles/scripts"
        cp "$DOTFILES_DIR/scripts/random-wallpaper.sh" "$HOME/.config/dotfiles/scripts/"
        chmod +x "$HOME/.config/dotfiles/scripts/random-wallpaper.sh"
    fi
    
    # Copiar archivos de configuración específicos
    if [ -f "$DOTFILES_DIR/fish/config.fish" ]; then
        print_step "Copiando configuración de Fish..."
        mkdir -p "$HOME/.config/fish"
        cp "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/"
    fi
    
    if [ -f "$DOTFILES_DIR/neofetch/neofetch.conf" ]; then
        print_step "Copiando configuración de Neofetch..."
        mkdir -p "$HOME/.config/neofetch"
        cp "$DOTFILES_DIR/neofetch/neofetch.conf" "$HOME/.config/neofetch/"
    fi
    
    if [ -f "$DOTFILES_DIR/neofetch/fastfetch.jsonc" ]; then
        print_step "Copiando configuración de Fastfetch..."
        cp "$DOTFILES_DIR/neofetch/fastfetch.jsonc" "$HOME/.config/"
    fi
    
    print_success "Dotfiles copiados"
}

# Función para configurar sistema básico
configure_system() {
    print_section "Configurando sistema..."
    
    print_step "Configurando permisos y servicios..."
    # Hacer todo en paralelo para mayor velocidad
    sudo usermod -aG wheel "$USER" &
    sudo systemctl enable NetworkManager bluetooth gdm &
    sudo chsh -s /usr/bin/fish "$USER" &
    wait
    
    print_step "Configurando GDM para Hyprland..."
    # Crear archivo de configuración para Hyprland en GDM
    sudo mkdir -p /usr/share/wayland-sessions
    sudo tee /usr/share/wayland-sessions/hyprland.desktop > /dev/null << 'EOF'
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
    
    print_success "Sistema configurado"
}

# Función para mostrar información final
show_final_info() {
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo "Próximos pasos:"
    echo "1. Reinicia tu sistema"
    echo "2. Inicia sesión con Hyprland"
    echo ""
    
    echo "Comandos básicos:"
    echo "• SUPER+N - Neovim (Editor por defecto)"
    echo "• SUPER+B - Browser (Firefox)"
    echo "• SUPER+D - Lanzador de aplicaciones"
    echo "• SUPER+RETURN - Terminal"
    echo "• SUPER+Q - Cerrar ventana"
    echo "• SUPER+SHIFT+W - Wallpaper aleatorio"
    echo ""
    
    echo "Para instalar más aplicaciones:"
    echo "• sudo pacman -S [paquete]"
    echo "• yay -S [paquete-aur]"
    echo ""
}

# Función principal
main() {
    print_header
    check_system
    update_system
    install_hyprland_minimal
    install_aur_helper
    copy_dotfiles
    configure_system
    show_final_info
}

# Ejecutar función principal
main "$@"