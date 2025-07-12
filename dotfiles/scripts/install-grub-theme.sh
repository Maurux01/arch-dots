#!/bin/bash

# Script para instalar tema GRUB Catppuccin
# Basado en: https://github.com/catppuccin/grub

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE} ═════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                Catppuccin GRUB Theme Installer              ║${NC}"
    echo -e "${BLUE} ════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_section() {
    echo -e "${CYAN}› $1${NC}"
}

print_step() {
    echo -e "${YELLOW}  → $1${NC}"
}

print_success() {
    echo -e "${GREEN}  ✓ $1${NC}"
}

print_error() {
    echo -e "${RED}  ✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}  ⚠ $1${NC}"
}

# Función para verificar sistema
check_system() {
    print_section "Verificando sistema..."
    
    if [ ! -f "/etc/arch-release" ]; then
        print_error "Este script está diseñado para Arch Linux."
        exit 1
    fi
    
    if [ "$EUID" -eq 0 ]; then
        print_error "No ejecutes este script como root."
        exit 1
    fi
    
    print_success "Sistema verificado."
}

# Función para instalar tema GRUB
install_grub_theme() {
    print_section "Instalando tema GRUB Catppuccin..."
    
    print_step "Verificando dependencias..."
    if ! command -v git >/dev/null 2>&1; then
        print_error "Git no está instalado. Instalando..."
        sudo pacman -S git --noconfirm
    fi
    
    if ! command -v grub-mkconfig >/dev/null 2>&1; then
        print_error "GRUB no está instalado. Instalando..."
        sudo pacman -S grub --noconfirm
    fi
    
    print_step "Clonando repositorio Catppuccin GRUB..."
    cd /tmp
    if [ -d "catppuccin-grub" ]; then
        rm -rf catppuccin-grub
    fi
    git clone https://github.com/catppuccin/grub.git catppuccin-grub
    cd catppuccin-grub
    
    print_step "Verificando estructura del repositorio..."
    if [ ! -d "src/catppuccin-grub-theme" ]; then
        print_error "Estructura del repositorio no encontrada."
        exit 1
    fi
    
    print_step "Instalando tema GRUB..."
    sudo mkdir -p /usr/share/grub/themes/
    sudo cp -r src/catppuccin-grub-theme /usr/share/grub/themes/
    
    print_step "Creando backup del archivo GRUB actual..."
    if [ -f "/etc/default/grub" ]; then
        sudo cp /etc/default/grub /etc/default/grub.backup.$(date +%Y%m%d_%H%M%S)
        print_success "Backup creado: /etc/default/grub.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    print_step "Configurando GRUB..."
    # Verificar si GRUB_THEME ya existe en el archivo
    if grep -q "GRUB_THEME" /etc/default/grub; then
        # Actualizar la línea existente
        sudo sed -i 's|GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/catppuccin-grub-theme/theme.txt"|' /etc/default/grub
    else
        # Agregar la línea al final del archivo
        echo 'GRUB_THEME="/usr/share/grub/themes/catppuccin-grub-theme/theme.txt"' | sudo tee -a /etc/default/grub
    fi
    
    print_step "Actualizando configuración de GRUB..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    print_step "Limpiando archivos temporales..."
    cd "$(dirname "$0")"
    rm -rf /tmp/catppuccin-grub
    
    print_success "Tema GRUB Catppuccin instalado correctamente"
}

# Función para mostrar información final
show_final_info() {
    echo ""
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                                   ║${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo "🎨 Tema GRUB Catppuccin instalado:"
    echo "  • Ubicación: /usr/share/grub/themes/catppuccin-grub-theme/"
    echo "  • Configuración: /etc/default/grub"
    echo "  • Backup: /etc/default/grub.backup.*"
    echo ""
    
    echo "📋 Próximos pasos:"
    echo "  1. Reinicia tu sistema para ver el nuevo tema"
    echo "  2. El tema se aplicará automáticamente en el bootloader"
    echo ""
    
    echo "🔧 Comandos útiles:"
    echo "  • sudo grub-mkconfig -o /boot/grub/grub.cfg  # Regenerar configuración"
    echo "  • sudo nano /etc/default/grub                 # Editar configuración"
    echo "  • sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi  # Reinstalar GRUB"
    echo ""
    
    echo "🎯 Características del tema:"
    echo "  • Colores Catppuccin (Mocha, Macchiato, Frappé, Latte)"
    echo "  • Iconos modernos y minimalistas"
    echo "  • Soporte para múltiples resoluciones"
    echo "  • Compatible con UEFI y BIOS"
    echo ""
    
    print_warning "Reinicia el sistema para ver el nuevo tema GRUB"
}

# Función principal
main() {
    print_header
    check_system
    install_grub_theme
    show_final_info
}

# Ejecutar función principal
main "$@" 