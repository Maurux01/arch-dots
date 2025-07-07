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
    echo "• SUPER+D - Lanzador de aplicaciones"
    echo "• SUPER+RETURN - Terminal"
    echo "• SUPER+Q - Cerrar ventana"
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