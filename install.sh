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
    sudo pacman -Syu --noconfirm
    print_success "Sistema actualizado"
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
        "grim"
        "slurp"
        "wl-clipboard"
        "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk"
        "kitty"
        "fish"
        "neovim"
    )
    
    print_step "Instalando paquetes esenciales..."
    sudo pacman -S "${essential_packages[@]}" --noconfirm --needed
    
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
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$SCRIPT_DIR"
    
    print_success "AUR helper instalado"
}

# Función para copiar dotfiles
copy_dotfiles() {
    print_section "Copiando dotfiles..."
    
    print_step "Creando directorios..."
    mkdir -p "$HOME/.config"
    
    print_step "Copiando configuraciones..."
    cp -r "$DOTFILES_DIR"/* "$HOME/.config/"
    
    print_success "Dotfiles copiados"
}

# Función para configurar sistema básico
configure_system() {
    print_section "Configurando sistema..."
    
    print_step "Configurando permisos..."
    sudo usermod -aG wheel "$USER"
    
    print_step "Habilitando servicios..."
    sudo systemctl enable NetworkManager bluetooth
    
    print_step "Configurando shell por defecto..."
    sudo chsh -s /usr/bin/fish "$USER"
    
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