#!/bin/bash

# Script para arreglar la configuración de Neovim
# Elimina configuraciones problemáticas y reinstala correctamente

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() {
    echo -e "${YELLOW}→ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}                    Arreglando Neovim                          ${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Función principal
main() {
    print_header
    
    print_step "Backup de configuración actual..."
    if [ -d "$HOME/.config/nvim" ]; then
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
        print_success "Backup creado"
    fi
    
    print_step "Limpiando cache de Neovim..."
    rm -rf "$HOME/.local/share/nvim"
    rm -rf "$HOME/.local/state/nvim"
    rm -rf "$HOME/.cache/nvim"
    print_success "Cache limpiado"
    
    print_step "Copiando nueva configuración..."
    cp -r dotfiles/nvim "$HOME/.config/"
    print_success "Configuración copiada"
    
    print_step "Haciendo scripts ejecutables..."
    find "$HOME/.config/nvim" -name "*.lua" -type f -exec chmod 644 {} \;
    print_success "Permisos actualizados"
    
    print_step "Instalando dependencias de Neovim..."
    # Instalar dependencias necesarias
    sudo pacman -S --noconfirm --needed \
        ripgrep \
        fd \
        tree-sitter \
        nodejs \
        npm
    
    print_success "Dependencias instaladas"
    
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}                    ¡Neovim arreglado!                          ${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "Próximos pasos:"
    echo "1. Abre Neovim: nvim"
    echo "2. Espera a que se instalen los plugins automáticamente"
    echo "3. Si hay errores, ejecuta :Lazy sync"
    echo "4. Para verificar la instalación: :checkhealth"
    echo ""
    echo "Comandos útiles:"
    echo "• :Lazy sync - Sincronizar plugins"
    echo "• :Lazy clean - Limpiar plugins no usados"
    echo "• :checkhealth - Verificar salud del sistema"
    echo "• :Mason - Instalar LSP servers"
    echo ""
}

# Ejecutar función principal
main "$@" 