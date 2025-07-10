#!/bin/bash

# Script de desinstalación completa para Arch Dots
# Desinstala todo automáticamente

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variables globales
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.arch-dots-backup-$(date +%Y%m%d-%H%M%S)"
UNINSTALL_LOG="$HOME/.arch-dots-uninstall.log"

# Función para logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$UNINSTALL_LOG"
}

print_header() {
    echo -e "${RED}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                  DESINSTALADOR ARCH DOTS                     ║${NC}"
    echo -e "${RED}║                  Desinstalación completa automática          ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════╝${NC}"
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

print_info() {
    echo -e "${BLUE}  ℹ $1${NC}"
    log "INFO: $1"
}

# Función para confirmar desinstalación
confirm_uninstall() {
    echo -e "${RED}⚠️  ADVERTENCIA: Esta acción desinstalará completamente Arch Dots${NC}"
    echo -e "${RED}Esto incluye:${NC}"
    echo "• Eliminar todos los paquetes instalados"
    echo "• Restaurar configuraciones originales"
    echo "• Eliminar dotfiles personalizados"
    echo "• Limpiar configuraciones del sistema"
    echo ""
    echo -e "${YELLOW}Se creará un backup en: $BACKUP_DIR${NC}"
    echo ""
    
    read -p "¿Estás seguro de que quieres continuar? (escribe 'SI' para confirmar): " confirm
    
    if [ "$confirm" != "SI" ]; then
        echo "Desinstalación cancelada"
        exit 0
    fi
    
    echo ""
}

# Función para crear backup
create_backup() {
    print_section "Creando backup de configuraciones..."
    
    print_step "Creando directorio de backup..."
    mkdir -p "$BACKUP_DIR"
    
    print_step "Backup de dotfiles..."
    if [ -d "$HOME/.config" ]; then
        cp -r "$HOME/.config" "$BACKUP_DIR/"
    fi
    
    print_step "Backup de archivos de configuración..."
    local config_files=(
        "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile"
        "$HOME/.zshrc" "$HOME/.zshenv" "$HOME/.config/fish"
        "$HOME/.local/share/applications" "$HOME/.local/bin"
    )
    
    for file in "${config_files[@]}"; do
        if [ -e "$file" ]; then
            cp -r "$file" "$BACKUP_DIR/"
        fi
    done
    
    print_step "Backup de configuración del sistema..."
    sudo cp -r /etc/hypr "$BACKUP_DIR/etc-hypr" 2>/dev/null || true
    sudo cp /etc/mkinitcpio.conf "$BACKUP_DIR/" 2>/dev/null || true
    sudo cp /etc/modprobe.d/nvidia.conf "$BACKUP_DIR/" 2>/dev/null || true
    
    print_success "Backup creado en $BACKUP_DIR"
}

# Función para desinstalar paquetes
uninstall_packages() {
    print_section "Desinstalando paquetes..."
    
    print_step "Desinstalando paquetes de Hyprland..."
    local hyprland_packages=(
        "hyprland" "waybar" "eww" "swww" "wofi" "mako" "swaylock"
        "swayidle" "grim" "slurp" "wl-clipboard" "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk" "kitty" "neovim" "fish" "starship"
    )
    
    for pkg in "${hyprland_packages[@]}"; do
        if pacman -Q "$pkg" >/dev/null 2>&1; then
            print_step "Desinstalando $pkg..."
            sudo pacman -R "$pkg" --noconfirm
        fi
    done
    
    print_step "Desinstalando utilidades del sistema..."
    local util_packages=(
        "bat" "fd" "ripgrep" "fzf" "lazygit" "yazi" "btop" "htop"
        "neofetch" "fastfetch" "cava" "pavucontrol" "blueman"
        "mpv" "vlc" "steam" "lutris" "wine" "gamemode" "mangohud"
    )
    
    for pkg in "${util_packages[@]}"; do
        if pacman -Q "$pkg" >/dev/null 2>&1; then
            print_step "Desinstalando $pkg..."
            sudo pacman -R "$pkg" --noconfirm
        fi
    done
    
    print_step "Desinstalando herramientas de desarrollo..."
    local dev_packages=(
        "nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk"
        "gcc" "cmake" "ninja" "meson" "valgrind" "gdb"
    )
    
    for pkg in "${dev_packages[@]}"; do
        if pacman -Q "$pkg" >/dev/null 2>&1; then
            print_step "Desinstalando $pkg..."
            sudo pacman -R "$pkg" --noconfirm
        fi
    done
    
    print_step "Desinstalando fuentes y temas..."
    local theme_packages=(
        "catppuccin-gtk-theme" "papirus-icon-theme" "bibata-cursor-theme"
        "adwaita-icon-theme" "gnome-themes-extra"
    )
    
    for pkg in "${theme_packages[@]}"; do
        if pacman -Q "$pkg" >/dev/null 2>&1; then
            print_step "Desinstalando $pkg..."
            sudo pacman -R "$pkg" --noconfirm
        fi
    done
    
    print_step "Desinstalando paquetes AUR..."
    local aur_packages=("heroic-games-launcher")
    for pkg in "${aur_packages[@]}"; do
        if yay -Q "$pkg" >/dev/null 2>&1; then
            print_step "Desinstalando $pkg..."
            yay -R "$pkg" --noconfirm
        fi
    done
    
    print_success "Paquetes desinstalados"
}

# Función para desinstalar Hyperlock
uninstall_hyperlock() {
    print_section "Desinstalando Hyperlock..."
    
    print_step "Desinstalando Hyperlock..."
    yay -R hyperlock --noconfirm 2>/dev/null || true
    
    print_step "Eliminando configuración de Hyperlock..."
    rm -rf "$HOME/.config/hyperlock"
    
    print_success "Hyperlock desinstalado"
}

# Función para limpiar dotfiles
clean_dotfiles() {
    print_section "Limpiando dotfiles..."
    
    print_step "Eliminando configuraciones de Hyprland..."
    rm -rf "$HOME/.config/hypr"
    rm -rf "$HOME/.config/waybar"
    rm -rf "$HOME/.config/eww"
    rm -rf "$HOME/.config/wofi"
    rm -rf "$HOME/.config/mako"
    rm -rf "$HOME/.config/kitty"
    rm -rf "$HOME/.config/nvim"
    rm -rf "$HOME/.config/fish"
    rm -rf "$HOME/.config/swww"
    rm -rf "$HOME/.config/tmux"
    rm -rf "$HOME/.config/neofetch"
    rm -rf "$HOME/.config/fastfetch"
    
    print_step "Eliminando scripts..."
    rm -rf "$HOME/.config/scripts"
    
    print_step "Eliminando otros dotfiles..."
    rm -rf "$HOME/.config/dotfiles"
    rm -f "$HOME/.config/gtk-3.0/settings.ini"
    rm -f "$HOME/.config/gtk-4.0/settings.ini"
    
    print_success "Dotfiles eliminados"
}

# Función para restaurar configuraciones por defecto
restore_defaults() {
    print_section "Restaurando configuraciones por defecto..."
    
    print_step "Restaurando shell por defecto..."
    sudo chsh -s /bin/bash "$USER"
    
    print_step "Restaurando configuración del sistema..."
    if [ -f "$BACKUP_DIR/etc-hypr" ]; then
        sudo cp -r "$BACKUP_DIR/etc-hypr" /etc/hypr
    else
        sudo rm -rf /etc/hypr 2>/dev/null || true
    fi
    
    print_step "Deshabilitando servicios..."
    sudo systemctl disable NetworkManager bluetooth 2>/dev/null || true
    
    print_success "Configuraciones restauradas"
}

# Función para limpiar sistema
clean_system() {
    print_section "Limpiando sistema..."
    
    print_step "Limpiando caché de paquetes..."
    sudo pacman -Sc --noconfirm
    
    print_step "Limpiando caché de AUR..."
    yay -Sc --noconfirm 2>/dev/null || true
    
    print_step "Limpiando archivos temporales..."
    sudo rm -rf /tmp/*
    rm -rf "$HOME/.cache"
    
    print_step "Limpiando logs..."
    sudo journalctl --vacuum-time=1d
    
    print_success "Sistema limpiado"
}

# Función para mostrar información final
show_final_info() {
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                  DESINSTALACIÓN COMPLETADA                  ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    print_info "Desinstalación completada:"
    echo "• Todos los paquetes han sido desinstalados"
    echo "• Las configuraciones han sido restauradas"
    echo "• El sistema ha sido limpiado"
    echo ""
    
    print_info "Backup disponible en:"
    echo "$BACKUP_DIR"
    echo ""
    
    print_warning "Próximos pasos:"
    echo "1. Reinicia tu sistema"
    echo "2. Instala un nuevo entorno de escritorio si es necesario"
    echo "3. Restaura configuraciones desde el backup si lo necesitas"
    echo ""
    
    print_info "Para restaurar desde backup:"
    echo "cp -r $BACKUP_DIR/.config/* ~/.config/"
    echo ""
}

# Función principal
main() {
    print_header
    confirm_uninstall
    create_backup
    uninstall_packages
    uninstall_hyperlock
    clean_dotfiles
    restore_defaults
    clean_system
    show_final_info
}

# Ejecutar función principal
main "$@" 