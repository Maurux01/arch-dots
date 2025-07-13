#!/bin/bash

# Script para instalar soporte de imágenes y SVG en Neovim y Kitty
# Incluye plugins para visualizar imágenes, SVG y markdown con imágenes

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
    echo -e "${BLUE}║                    Soporte de Imágenes                      ║${NC}"
    echo -e "${BLUE}║                         by maurux01                          ║${NC}"
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

# Función para verificar sistema
check_system() {
    print_section "Verificando sistema..."
    
    if [ ! -f "/etc/arch-release" ]; then
        print_error "Este script está diseñado solo para Arch Linux."
        exit 1
    fi
    
    if [ "$EUID" -eq 0 ]; then
        print_error "No ejecutes este script como root."
        exit 1
    fi
    
    print_success "Sistema verificado."
}

# Función para actualizar sistema
update_system() {
    print_section "Actualizando sistema..."
    sudo pacman -Sy --noconfirm
    print_success "Base de datos actualizada."
}

# Función para instalar dependencias de imágenes
install_image_dependencies() {
    print_section "Instalando dependencias de imágenes..."
    
    print_step "Instalando ImageMagick..."
    sudo pacman -S imagemagick --noconfirm --needed
    
    print_step "Instalando FFmpeg..."
    sudo pacman -S ffmpeg --noconfirm --needed
    
    print_step "Instalando librerías de imágenes..."
    sudo pacman -S libpng libjpeg-turbo libwebp librsvg giflib --noconfirm --needed
    
    print_step "Instalando herramientas de video..."
    sudo pacman -S v4l-utils pulseaudio-alsa --noconfirm --needed
    
    print_success "Dependencias de imágenes instaladas"
}

# Función para configurar Kitty para soporte de imágenes
configure_kitty_images() {
    print_section "Configurando Kitty para soporte de imágenes..."
    
    local kitty_config="$HOME/.config/kitty/kitty.conf"
    
    if [ -f "$kitty_config" ]; then
        print_step "Agregando configuración de imágenes a Kitty..."
        
        # Agregar configuración de imágenes si no existe
        if ! grep -q "image_protocols" "$kitty_config"; then
            cat >> "$kitty_config" << 'EOF'

# =============================================================================
#                           🖼️ IMAGE SUPPORT
# =============================================================================
# Image support for Neovim and other applications
# Enable image protocol support
image_protocols file

# Image display settings
image_display_scale_factor 1.0
image_display_scale_factor_x 1.0
image_display_scale_factor_y 1.0

# Image cache settings
image_cache_size 100
image_cache_cleanup_interval 300

# Image format support
image_format png,jpg,jpeg,gif,webp,svg
EOF
            print_success "Configuración de imágenes agregada a Kitty"
        else
            print_info "Configuración de imágenes ya existe en Kitty"
        fi
    else
        print_warning "Configuración de Kitty no encontrada"
    fi
}

# Función para crear directorios de imágenes
create_image_directories() {
    print_section "Creando directorios para imágenes..."
    
    local image_dirs=(
        "$HOME/.local/share/nvim/images"
        "$HOME/.local/share/nvim/images/resized"
        "$HOME/.local/share/nvim/images/backup"
        "$HOME/.local/share/nvim/images/backup/resized"
    )
    
    for dir in "${image_dirs[@]}"; do
        print_step "Creando directorio: $dir"
        mkdir -p "$dir"
    done
    
    print_success "Directorios de imágenes creados"
}

# Función para mostrar información final
show_final_info() {
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                                   ║${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo "Soporte de imágenes instalado:"
    echo ""
    echo "🖼️ Neovim Image Support:"
    echo "   • Visualización de imágenes en Neovim"
    echo "   • Soporte para PNG, JPG, GIF, WebP, SVG"
    echo "   • Integración con Markdown"
    echo "   • Pegado de imágenes desde clipboard"
    echo ""
    
    echo "📝 Markdown Preview:"
    echo "   • Vista previa de Markdown con imágenes"
    echo "   • Soporte para diagramas y matemáticas"
    echo "   • Tema oscuro por defecto"
    echo ""
    
    echo "🎨 Kitty Terminal:"
    echo "   • Soporte nativo para imágenes"
    echo "   • Caché de imágenes optimizado"
    echo "   • Múltiples formatos soportados"
    echo ""
    
    echo "⌨️ Comandos disponibles:"
    echo "   • <leader>ii - Mostrar información de imagen"
    echo "   • <leader>ir - Recargar imagen"
    echo "   • <leader>ic - Limpiar imagen"
    echo "   • <leader>ip - Pegar imagen"
    echo "   • <leader>id - Descargar imagen"
    echo "   • <leader>is - Guardar imagen"
    echo "   • <leader>mp - Vista previa de Markdown"
    echo "   • <leader>ms - Detener vista previa"
    echo "   • <leader>mt - Alternar vista previa"
    echo ""
    
    echo "📁 Ubicaciones de archivos:"
    echo "   • Imágenes: ~/.local/share/nvim/images/"
    echo "   • Configuración: ~/.config/nvim/lua/plugins/image-support.lua"
    echo "   • Kitty config: ~/.config/kitty/kitty.conf"
    echo ""
    
    echo "💡 Consejos de uso:"
    echo "   • Abre archivos de imagen directamente en Neovim"
    echo "   • Usa Markdown con imágenes para documentación"
    echo "   • Pega imágenes desde el clipboard con <leader>ip"
    echo "   • Las imágenes se guardan automáticamente"
    echo ""
    
    echo "🔄 Para reiniciar:"
    echo "   • Reinicia Neovim: nvim"
    echo "   • Reinicia Kitty: pkill kitty"
    echo ""
}

# Función principal
main() {
    print_header
    check_system
    update_system
    install_image_dependencies
    configure_kitty_images
    create_image_directories
    show_final_info
}

# Ejecutar función principal
main "$@" 