#!/bin/bash

# Script para instalar herramientas multimedia
# LMMS, Pixelorama y Upscayl

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
    echo -e "${BLUE}║                    Herramientas Multimedia                    ║${NC}"
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

# Función para instalar AUR helper
install_aur_helper() {
    print_section "Instalando AUR helper..."
    
    if command -v yay >/dev/null 2>&1; then
        print_success "yay ya está instalado."
        return
    fi
    
    print_step "Instalando yay..."
    cd /tmp
    git clone --depth 1 https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --skippgpcheck
    cd "$(dirname "$0")"
    rm -rf /tmp/yay
    
    print_success "AUR helper instalado."
}

# Función para instalar herramientas multimedia
install_multimedia_tools() {
    print_section "Instalando herramientas multimedia..."
    
    print_step "Instalando LMMS (Linux MultiMedia Studio)..."
    sudo pacman -S lmms --noconfirm --needed
    
    print_step "Instalando Pixelorama (Pixel Art)..."
    yay -S pixelorama --noconfirm --needed
    
    print_step "Instalando Upscayl (AI Upscaler)..."
    yay -S upscayl --noconfirm --needed
    
    print_step "Instalando dependencias adicionales para multimedia..."
    sudo pacman -S ffmpeg v4l-utils pulseaudio-alsa --noconfirm --needed
    
    print_success "Herramientas multimedia instaladas"
}

# Función para mostrar información final
show_final_info() {
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                                   ║${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo "Herramientas multimedia instaladas:"
    echo ""
    echo "🎵 LMMS (Linux MultiMedia Studio):"
    echo "   • Editor de música y audio profesional"
    echo "   • Sintetizadores, efectos y plugins"
    echo "   • Soporte para VST y LADSPA"
    echo "   • Comando: lmms"
    echo ""
    
    echo "🎨 Pixelorama:"
    echo "   • Editor de pixel art avanzado"
    echo "   • Animaciones y sprites"
    echo "   • Herramientas de dibujo especializadas"
    echo "   • Comando: pixelorama"
    echo ""
    
    echo "🔍 Upscayl:"
    echo "   • Upscaler de imágenes con IA"
    echo "   • Múltiples modelos de IA"
    echo "   • Interfaz gráfica fácil de usar"
    echo "   • Comando: upscayl"
    echo ""
    
    echo "📁 Ubicaciones de archivos:"
    echo "   • LMMS: ~/.lmms/"
    echo "   • Pixelorama: ~/.local/share/Pixelorama/"
    echo "   • Upscayl: ~/.config/upscayl/"
    echo ""
    
    echo "💡 Consejos de uso:"
    echo "   • LMMS: Usa Ctrl+N para nuevo proyecto"
    echo "   • Pixelorama: Ctrl+S para guardar"
    echo "   • Upscayl: Arrastra imágenes para upscalear"
    echo ""
    
    echo "🔄 Para actualizar:"
    echo "   • sudo pacman -Syu"
    echo "   • yay -Sua"
    echo ""
}

# Función principal
main() {
    print_header
    check_system
    update_system
    install_aur_helper
    install_multimedia_tools
    show_final_info
}

# Ejecutar función principal
main "$@" 