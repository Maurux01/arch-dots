#!/bin/bash

# Script de instalación optimizado para Hyprland
# Versión simplificada y eficiente

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
    echo -e "${BLUE}║                    Archriced - Optimized                     ║${NC}"
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
        if [[ "$pkg" == "hyperlock" ]]; then
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
    sudo pacman -Sy --noconfirm
    print_success "Base de datos actualizada"
}

# Función para instalar AUR helper
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
        "neovim"
        
        # Utilidades del sistema
        "bat" "fd" "ripgrep" "fzf" "btop" "exa"
        "pavucontrol" "blueman" "networkmanager" "network-manager-applet"
        
        # Herramientas de desarrollo
        "nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk"
        "gcc" "cmake" "ninja" "meson" "valgrind" "gdb" "code-oss"
        
        # Herramientas adicionales
        "lazygit" "yazi"
        
        # Reproductores multimedia
        "mpv" "vlc" "cava"
        
        # Portapapeles e historial
        "cliphist" "copyq"
        
        # Fuentes y temas
        "nerd-fonts-adawita-mono" "noto-fonts" "noto-fonts-emoji" 
        "ttf-dejavu" "ttf-liberation" "ttf-jetbrains-mono"
        "catppuccin-gtk-theme" "papirus-icon-theme" "bibata-cursor-theme"
        
        # Otros
        "jq" "curl" "gdm"
    )
    
    install_packages "${essential_packages[@]}"
    
    # Instalar Code OSS desde repositorios oficiales
    print_step "Instalando Code OSS..."
    if sudo pacman -S "code-oss" --noconfirm --needed 2>/dev/null; then
        print_success "Code OSS instalado"
    else
        print_warning "Code OSS no disponible, intentando con code..."
        if sudo pacman -S "code" --noconfirm --needed 2>/dev/null; then
            print_success "Visual Studio Code instalado como alternativa"
        else
            print_warning "Ningún editor de código instalado, usando Neovim como editor principal"
        fi
    fi
    
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

# Función para instalar tema Catppuccin de GRUB2
install_grub_theme() {
    print_section "Instalando tema Catppuccin para GRUB2..."
    local grub_theme_repo="https://github.com/vinceliuice/grub2-themes.git"
    local tmp_dir="/tmp/grub2-themes"
    local theme_name="catppuccin"
    
    print_step "Clonando repositorio de temas..."
    git clone --depth=1 "$grub_theme_repo" "$tmp_dir"
    
    print_step "Copiando tema Catppuccin a /boot/grub/themes..."
    sudo mkdir -p /boot/grub/themes
    sudo cp -r "$tmp_dir/themes/$theme_name" /boot/grub/themes/
    
    print_step "Configurando GRUB para usar el tema..."
    if grep -q '^GRUB_THEME=' /etc/default/grub; then
        sudo sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/catppuccin/theme.txt"|' /etc/default/grub
    else
        echo 'GRUB_THEME="/boot/grub/themes/catppuccin/theme.txt"' | sudo tee -a /etc/default/grub
    fi
    
    print_step "Actualizando configuración de GRUB..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    print_success "Tema Catppuccin para GRUB2 instalado"
}

# Función para copiar dotfiles
copy_dotfiles() {
    print_section "Copiando dotfiles..."
    
    print_step "Creando directorios..."
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/share"
    mkdir -p "$HOME/.local/bin"
    
    print_step "Copiando configuraciones..."
    
    # Mapeo de carpetas
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
    
    # Copiar cada carpeta
    for item in "$DOTFILES_DIR"/*; do
        if [ -d "$item" ]; then
            local dirname=$(basename "$item")
            local target_path="${config_paths[$dirname]}"
            
            if [ -n "$target_path" ]; then
                print_step "Copiando $dirname..."
                rm -rf "$target_path"
                cp -r "$item" "$target_path"
            fi
        fi
    done
    
    # Configurar permisos de scripts
    print_step "Configurando permisos de scripts..."
    find "$HOME/.config" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
    find "$HOME/.local/bin" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
    
    print_success "Dotfiles copiados"
}

# Función para configurar sistema
configure_system() {
    print_section "Configurando sistema..."
    
    print_step "Configurando servicios..."
    sudo systemctl enable NetworkManager bluetooth gdm
    
    print_step "Configurando Fish como shell por defecto..."
    sudo chsh -s /usr/bin/fish "$USER"
    
    print_step "Configurando GDM para Hyprland..."
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
    
    echo "✅ Instalación completada exitosamente"
    echo ""
    echo "📁 Configuraciones instaladas en:"
    echo "  • Hyprland: ~/.config/hypr/"
    echo "  • Neovim: ~/.config/nvim/"
    echo "  • Fish: ~/.config/fish/"
    echo "  • Kitty: ~/.config/kitty/"
    echo "  • Waybar: ~/.config/waybar/"
    echo "  • EWW: ~/.config/eww/"
    echo ""
    
    echo "🚀 Próximos pasos:"
    echo "1. Reinicia tu sistema"
    echo "2. Inicia sesión con Hyprland"
    echo ""
    
    echo "⌨️  Comandos básicos:"
    echo "• SUPER+Return - Terminal"
    echo "• SUPER+D - Lanzador de aplicaciones"
    echo "• SUPER+Q - Cerrar ventana"
    echo "• SUPER+N - Neovim"
    echo "• SUPER+V - Code OSS"
    echo ""
}

# Función principal
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
    install_grub_theme
    show_final_info
}

# Ejecutar función principal
main "$@"