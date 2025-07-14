#!/bin/bash

# =============================================================================
#                           🎨 GRUB THEME INSTALLER
# =============================================================================
# Script para instalar temas GRUB personalizados desde dotfiles
# =============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
GRUB_THEMES_DIR="$DOTFILES_DIR/grub-themes"
GRUB_SYSTEM_DIR="/boot/grub/themes"

print_header() {
    echo -e "${BLUE} ═════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                    🎨 GRUB THEME INSTALLER                   ║${NC}"
    echo -e "${BLUE}║                    Instalador de temas GRUB                  ║${NC}"
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

print_info() {
    echo -e "${BLUE}  ℹ $1${NC}"
}

# Verificar permisos de root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_error "Este script debe ejecutarse como root (sudo)"
        echo "Uso: sudo $0 [tema]"
        exit 1
    fi
}

# Listar temas disponibles
list_themes() {
    print_section "Temas GRUB disponibles:"
    
    if [ ! -d "$GRUB_THEMES_DIR" ]; then
        print_error "Directorio de temas GRUB no encontrado: $GRUB_THEMES_DIR"
        return 1
    fi
    
    local themes_found=()
    for theme_dir in "$GRUB_THEMES_DIR"/*; do
        if [ -d "$theme_dir" ] && [ -f "$theme_dir/theme.txt" ]; then
            local theme_name=$(basename "$theme_dir")
            themes_found+=("$theme_name")
            echo "  • $theme_name"
            
            # Mostrar información del tema si existe README
            if [ -f "$theme_dir/README.md" ]; then
                echo "    $(head -1 "$theme_dir/README.md" | sed 's/^# //')"
            fi
        fi
    done
    
    if [ ${#themes_found[@]} -eq 0 ]; then
        print_warning "No se encontraron temas GRUB válidos"
        return 1
    fi
    
    echo ""
    echo "Uso: sudo $0 [nombre_del_tema]"
    echo "Ejemplo: sudo $0 arch-silence-master"
}

# Instalar tema específico
install_theme() {
    local theme_name="$1"
    local theme_path="$GRUB_THEMES_DIR/$theme_name"
    
    if [ ! -d "$theme_path" ]; then
        print_error "Tema '$theme_name' no encontrado"
        list_themes
        exit 1
    fi
    
    if [ ! -f "$theme_path/theme.txt" ]; then
        print_error "Tema '$theme_name' no es válido (falta theme.txt)"
        exit 1
    fi
    
    print_section "Instalando tema GRUB: $theme_name"
    
    # Crear directorio de temas GRUB si no existe
    print_step "Creando directorio de temas GRUB..."
    mkdir -p "$GRUB_SYSTEM_DIR"
    
    # Hacer backup del tema anterior si existe
    if [ -d "$GRUB_SYSTEM_DIR/$theme_name" ]; then
        print_step "Haciendo backup del tema anterior..."
        mv "$GRUB_SYSTEM_DIR/$theme_name" "$GRUB_SYSTEM_DIR/${theme_name}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Copiar el tema
    print_step "Copiando tema a $GRUB_SYSTEM_DIR/$theme_name..."
    cp -r "$theme_path" "$GRUB_SYSTEM_DIR/$theme_name"
    
    # Hacer backup de la configuración GRUB
    print_step "Haciendo backup de la configuración GRUB..."
    cp /etc/default/grub /etc/default/grub.backup.$(date +%Y%m%d_%H%M%S)
    
    # Configurar el tema en GRUB
    print_step "Configurando tema en GRUB..."
    
    # Verificar si ya existe una configuración de tema
    if grep -q "GRUB_THEME=" /etc/default/grub; then
        # Actualizar tema existente
        sed -i "s|GRUB_THEME=.*|GRUB_THEME=\"$GRUB_SYSTEM_DIR/$theme_name/theme.txt\"|" /etc/default/grub
    else
        # Agregar configuración de tema
        echo "GRUB_THEME=\"$GRUB_SYSTEM_DIR/$theme_name/theme.txt\"" >> /etc/default/grub
    fi
    
    # Configurar resolución si no está configurada
    if ! grep -q "GRUB_GFXMODE=" /etc/default/grub; then
        print_step "Configurando resolución GRUB..."
        echo "GRUB_GFXMODE=1920x1080,1600x900,1366x768,1024x768" >> /etc/default/grub
    fi
    
    # Configurar timeout si no está configurado
    if ! grep -q "GRUB_TIMEOUT=" /etc/default/grub; then
        print_step "Configurando timeout GRUB..."
        echo "GRUB_TIMEOUT=5" >> /etc/default/grub
    fi
    
    # Actualizar configuración GRUB
    print_step "Actualizando configuración GRUB..."
    grub-mkconfig -o /boot/grub/grub.cfg
    
    print_success "Tema GRUB '$theme_name' instalado correctamente"
    print_info "Tema ubicado en: $GRUB_SYSTEM_DIR/$theme_name"
    print_warning "Reinicia el sistema para ver el nuevo tema GRUB"
    
    # Mostrar información adicional
    if [ -f "$theme_path/README.md" ]; then
        print_info "Información del tema:"
        cat "$theme_path/README.md" | head -10
    fi
}

# Función principal
main() {
    print_header
    
    # Verificar permisos de root
    check_root
    
    # Si no se proporciona argumento, listar temas
    if [ $# -eq 0 ]; then
        list_themes
        exit 0
    fi
    
    # Instalar tema especificado
    install_theme "$1"
}

# Ejecutar función principal
main "$@" 