#!/bin/bash

# =============================================================================
#                           🔧 ARCH DOTS REPAIR
# =============================================================================
# Script de reparación y mantenimiento unificado para Arch Dots
# Repara problemas comunes y optimiza el sistema
# =============================================================================

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
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
REPAIR_LOG="$HOME/.archriced-repair.log"

# Función para logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$REPAIR_LOG"
}

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    🔧 ARCH DOTS REPAIR                       ║${NC}"
    echo -e "${BLUE}║                    Reparación y mantenimiento                ║${NC}"
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

print_info() {
    echo -e "${BLUE}  ℹ $1${NC}"
    log "INFO: $1"
}

# =============================================================================
#                           🔍 FUNCIONES DE DIAGNÓSTICO
# =============================================================================

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

diagnose_problems() {
    print_section "Diagnosticando problemas..."
    
    local problems=()
    
    # Verificar paquetes faltantes
    print_step "Verificando paquetes esenciales..."
    local essential_packages=(
        "hyprland" "waybar" "kitty" "fish" "neovim"
    )
    
    for pkg in "${essential_packages[@]}"; do
        if ! pacman -Q "$pkg" >/dev/null 2>&1; then
            problems+=("Paquete faltante: $pkg")
        fi
    done
    
    # Verificar configuraciones faltantes
    print_step "Verificando configuraciones..."
    local essential_configs=(
        "$HOME/.config/hypr/hyprland.conf"
        "$HOME/.config/kitty/kitty.conf"
        "$HOME/.config/fish/config.fish"
    )
    
    for config in "${essential_configs[@]}"; do
        if [ ! -f "$config" ]; then
            problems+=("Configuración faltante: $config")
        fi
    done
    
    # Verificar permisos
    print_step "Verificando permisos..."
    if [ ! -w "$HOME/.config" ]; then
        problems+=("Problema de permisos en ~/.config")
    fi
    
    # Verificar servicios
    print_step "Verificando servicios..."
    if ! systemctl is-active --quiet NetworkManager; then
        problems+=("NetworkManager no está activo")
    fi
    
    if [ ${#problems[@]} -eq 0 ]; then
        print_success "No se encontraron problemas críticos"
    else
        print_warning "Se encontraron ${#problems[@]} problema(s):"
        for problem in "${problems[@]}"; do
            echo "  • $problem"
        done
    fi
    
    return ${#problems[@]}
}

# =============================================================================
#                           🔧 FUNCIONES DE REPARACIÓN
# =============================================================================

repair_packages() {
    print_section "Reparando paquetes..."
    
    print_step "Actualizando base de datos de paquetes..."
    sudo pacman -Sy --noconfirm
    
    print_step "Reparando paquetes rotos..."
    sudo pacman -S --overwrite="*" --noconfirm
    
    print_step "Limpiando caché de paquetes..."
    sudo pacman -Sc --noconfirm
    
    print_step "Verificando integridad de paquetes..."
    sudo pacman -Qkk --noconfirm || true
    
    print_success "Paquetes reparados"
}

repair_aur() {
    print_section "Reparando AUR..."
    
    if command -v yay >/dev/null 2>&1; then
        print_step "Actualizando caché de AUR..."
        yay -Sc --noconfirm
        
        print_step "Verificando paquetes AUR..."
        yay -Qkk --noconfirm || true
        
        print_success "AUR reparado"
    else
        print_warning "yay no está instalado, saltando reparación de AUR"
    fi
}

repair_configs() {
    print_section "Reparando configuraciones..."
    
    print_step "Verificando configuraciones de Hyprland..."
    if [ ! -d "$HOME/.config/hypr" ]; then
        print_step "Recreando configuración de Hyprland..."
        mkdir -p "$HOME/.config/hypr"
        if [ -f "$DOTFILES_DIR/hypr/hyprland.conf" ]; then
            cp "$DOTFILES_DIR/hypr/hyprland.conf" "$HOME/.config/hypr/"
            print_success "Configuración de Hyprland restaurada"
        else
            print_warning "No se encontró configuración de Hyprland en dotfiles"
        fi
    fi
    
    print_step "Verificando configuración de Kitty..."
    if [ ! -d "$HOME/.config/kitty" ]; then
        print_step "Recreando configuración de Kitty..."
        mkdir -p "$HOME/.config/kitty"
        if [ -f "$DOTFILES_DIR/kitty/kitty.conf" ]; then
            cp "$DOTFILES_DIR/kitty/kitty.conf" "$HOME/.config/kitty/"
            print_success "Configuración de Kitty restaurada"
        else
            print_warning "No se encontró configuración de Kitty en dotfiles"
        fi
    fi
    
    print_step "Verificando configuración de Fish..."
    if [ ! -d "$HOME/.config/fish" ]; then
        print_step "Recreando configuración de Fish..."
        mkdir -p "$HOME/.config/fish"
        if [ -f "$DOTFILES_DIR/fish/config.fish" ]; then
            cp "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/"
            print_success "Configuración de Fish restaurada"
        else
            print_warning "No se encontró configuración de Fish en dotfiles"
        fi
    fi
    
    print_step "Verificando configuración de Neovim..."
    if [ ! -d "$HOME/.config/nvim" ]; then
        print_step "Recreando configuración de Neovim..."
        if git clone https://github.com/Maurux01/NVimX.git "$HOME/.config/nvim" 2>/dev/null; then
            rm -rf "$HOME/.config/nvim/.git"
            print_success "Configuración de Neovim restaurada"
        else
            print_warning "No se pudo restaurar configuración de Neovim"
        fi
    fi
    
    print_success "Configuraciones reparadas"
}

repair_fonts() {
    print_section "Reparando fuentes..."
    
    print_step "Verificando fuentes del sistema..."
    if [ ! -d "$HOME/.local/share/fonts" ]; then
        mkdir -p "$HOME/.local/share/fonts"
    fi
    
    if [ -d "$DOTFILES_DIR/fonts" ]; then
        print_step "Reinstalando fuentes personalizadas..."
        local font_files=($(find "$DOTFILES_DIR/fonts" -type f \( -iname "*.ttf" -o -iname "*.otf" -o -iname "*.woff" -o -iname "*.woff2" \) 2>/dev/null))
        
        if [ ${#font_files[@]} -gt 0 ]; then
            cp "${font_files[@]}" "$HOME/.local/share/fonts/"
            print_success "Fuentes personalizadas reinstaladas"
        fi
    fi
    
    print_step "Actualizando caché de fuentes..."
    fc-cache -fv
    sudo fc-cache -fv
    
    print_success "Fuentes reparadas"
}

repair_permissions() {
    print_section "Reparando permisos..."
    
    print_step "Corrigiendo permisos de usuario..."
    sudo chown -R "$USER:$USER" "$HOME/.config" 2>/dev/null || true
    sudo chown -R "$USER:$USER" "$HOME/.local" 2>/dev/null || true
    
    print_step "Estableciendo permisos correctos..."
    find "$HOME/.config" -type d -exec chmod 755 {} \; 2>/dev/null || true
    find "$HOME/.config" -type f -exec chmod 644 {} \; 2>/dev/null || true
    find "$HOME/.config" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
    
    print_step "Corrigiendo permisos de scripts..."
    if [ -d "$HOME/.config/scripts" ]; then
        chmod +x "$HOME/.config/scripts"/*.sh 2>/dev/null || true
    fi
    
    print_success "Permisos reparados"
}

# =============================================================================
#                           🧹 FUNCIONES DE LIMPIEZA
# =============================================================================

clean_system() {
    print_section "Limpiando sistema..."
    
    print_step "Limpiando caché de paquetes..."
    sudo pacman -Sc --noconfirm
    
    print_step "Limpiando caché de AUR..."
    if command -v yay >/dev/null 2>&1; then
        yay -Sc --noconfirm
    fi
    
    print_step "Limpiando archivos temporales..."
    sudo rm -rf /tmp/* 2>/dev/null || true
    rm -rf "$HOME/.cache"/* 2>/dev/null || true
    
    print_step "Limpiando logs del sistema..."
    sudo journalctl --vacuum-time=1d
    
    print_step "Limpiando caché de aplicaciones..."
    rm -rf "$HOME/.cache/thumbnails" 2>/dev/null || true
    rm -rf "$HOME/.cache/mozilla" 2>/dev/null || true
    rm -rf "$HOME/.cache/google-chrome" 2>/dev/null || true
    
    print_success "Sistema limpiado"
}

clean_neovim() {
    print_section "Limpiando Neovim..."
    
    print_step "Limpiando caché de Neovim..."
    rm -rf "$HOME/.cache/nvim" 2>/dev/null || true
    rm -rf "$HOME/.local/share/nvim" 2>/dev/null || true
    
    print_step "Reinstalando plugins de Neovim..."
    if command -v nvim >/dev/null 2>&1; then
        nvim --headless -c "Lazy! clean" -c "Lazy! sync" -c "quit" 2>/dev/null || true
        print_success "Plugins de Neovim reinstalados"
    else
        print_warning "Neovim no está instalado"
    fi
    
    print_success "Neovim limpiado"
}

# =============================================================================
#                           🔄 FUNCIONES DE ACTUALIZACIÓN
# =============================================================================

update_system() {
    print_section "Actualizando sistema..."
    
    print_step "Actualizando base de datos..."
    sudo pacman -Sy --noconfirm
    
    print_step "Actualizando paquetes del sistema..."
    sudo pacman -Syu --noconfirm
    
    print_step "Actualizando paquetes AUR..."
    if command -v yay >/dev/null 2>&1; then
        yay -Sua --noconfirm
    fi
    
    print_success "Sistema actualizado"
}

update_dotfiles() {
    print_section "Actualizando dotfiles..."
    
    if [ -d "$SCRIPT_DIR/.git" ]; then
        print_step "Actualizando repositorio de dotfiles..."
        cd "$SCRIPT_DIR"
        git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || true
        
        print_step "Replicando configuraciones actualizadas..."
        if [ -f "$SCRIPT_DIR/install.sh" ]; then
            bash "$SCRIPT_DIR/install.sh" --update-only 2>/dev/null || true
        fi
        
        print_success "Dotfiles actualizados"
    else
        print_warning "No se encontró repositorio git, saltando actualización"
    fi
}

# =============================================================================
#                           🔍 FUNCIONES DE VERIFICACIÓN
# =============================================================================

verify_repair() {
    print_section "Verificando reparación..."
    
    local errors=0
    
    # Verificar paquetes esenciales
    print_step "Verificando paquetes esenciales..."
    local essential_packages=(
        "hyprland" "waybar" "kitty" "fish" "neovim"
    )
    
    for pkg in "${essential_packages[@]}"; do
        if pacman -Q "$pkg" >/dev/null 2>&1; then
            print_success "✓ $pkg instalado"
        else
            print_error "✗ $pkg no está instalado"
            ((errors++))
        fi
    done
    
    # Verificar configuraciones
    print_step "Verificando configuraciones..."
    local essential_configs=(
        "$HOME/.config/hypr/hyprland.conf"
        "$HOME/.config/kitty/kitty.conf"
        "$HOME/.config/fish/config.fish"
    )
    
    for config in "${essential_configs[@]}"; do
        if [ -f "$config" ]; then
            print_success "✓ $config existe"
        else
            print_error "✗ $config falta"
            ((errors++))
        fi
    done
    
    # Verificar permisos
    print_step "Verificando permisos..."
    if [ -w "$HOME/.config" ]; then
        print_success "✓ Permisos de ~/.config correctos"
    else
        print_error "✗ Problema con permisos de ~/.config"
        ((errors++))
    fi
    
    if [ $errors -eq 0 ]; then
        print_success "Reparación verificada exitosamente"
    else
        print_error "Se encontraron $errors error(es) después de la reparación"
    fi
}

# =============================================================================
#                           📋 FUNCIONES DE INFORMACIÓN
# =============================================================================

show_system_info() {
    print_section "Información del sistema..."
    
    echo "Sistema operativo: $(uname -s)"
    echo "Arquitectura: $(uname -m)"
    echo "Kernel: $(uname -r)"
    echo "Usuario: $USER"
    echo "Shell actual: $SHELL"
    echo "Directorio home: $HOME"
    echo ""
    
    echo "Paquetes instalados:"
    echo "• Hyprland: $(pacman -Q hyprland 2>/dev/null | cut -d' ' -f2 || echo 'No instalado')"
    echo "• Neovim: $(pacman -Q neovim 2>/dev/null | cut -d' ' -f2 || echo 'No instalado')"
    echo "• Fish: $(pacman -Q fish 2>/dev/null | cut -d' ' -f2 || echo 'No instalado')"
    echo "• Kitty: $(pacman -Q kitty 2>/dev/null | cut -d' ' -f2 || echo 'No instalado')"
    echo ""
    
    echo "Espacio en disco:"
    df -h "$HOME" | tail -1
    echo ""
    
    echo "Memoria disponible:"
    free -h
    echo ""
}

# =============================================================================
#                           🎯 FUNCIÓN PRINCIPAL
# =============================================================================

show_help() {
    echo "Uso: $0 [OPCIÓN]"
    echo ""
    echo "Opciones:"
    echo "  --diagnose     Solo diagnosticar problemas"
    echo "  --repair       Reparar problemas encontrados"
    echo "  --clean        Limpiar sistema"
    echo "  --update       Actualizar sistema y dotfiles"
    echo "  --info         Mostrar información del sistema"
    echo "  --all          Ejecutar todas las operaciones"
    echo "  --help         Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 --diagnose    # Solo diagnosticar"
    echo "  $0 --repair      # Solo reparar"
    echo "  $0 --all         # Diagnóstico, reparación y limpieza completa"
}

main() {
    local action="all"
    
    if [ $# -gt 0 ]; then
        case "$1" in
            --diagnose) action="diagnose" ;;
            --repair) action="repair" ;;
            --clean) action="clean" ;;
            --update) action="update" ;;
            --info) action="info" ;;
            --all) action="all" ;;
            --help) show_help; exit 0 ;;
            *) echo "Opción desconocida: $1"; show_help; exit 1 ;;
        esac
    fi
    
    print_header
    check_system
    
    case "$action" in
        "diagnose")
            diagnose_problems
            ;;
        "repair")
            repair_packages
            repair_aur
            repair_configs
            repair_fonts
            repair_permissions
            verify_repair
            ;;
        "clean")
            clean_system
            clean_neovim
            ;;
        "update")
            update_system
            update_dotfiles
            ;;
        "info")
            show_system_info
            ;;
        "all")
            diagnose_problems
            repair_packages
            repair_aur
            repair_configs
            repair_fonts
            repair_permissions
            clean_system
            clean_neovim
            update_system
            verify_repair
            show_system_info
            ;;
    esac
    
    echo ""
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}║                    REPARACIÓN COMPLETADA                                   ║${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "Log de reparación guardado en: $REPAIR_LOG"
    echo ""
}

# Ejecutar función principal
main "$@" 