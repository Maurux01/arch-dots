#!/bin/bash

# =============================================================================
#                           🔄 CONFIG UPDATER
# =============================================================================
# Author: Mauro Infante (maurux01)
# Description: Update Tmux and Kitty configurations from dotfiles
# =============================================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_section() {
    echo -e "${PURPLE}=============================================================================${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}=============================================================================${NC}"
}

print_step() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to backup existing config
backup_config() {
    local config_path="$1"
    local backup_path="$2"
    
    if [ -e "$config_path" ]; then
        print_step "Haciendo backup de $config_path..."
        cp -r "$config_path" "$backup_path"
        print_success "Backup creado en $backup_path"
    fi
}

# Function to update Tmux config
update_tmux() {
    print_section "🖥️  ACTUALIZANDO CONFIGURACIÓN DE TMUX"
    
    # Get the script directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Backup existing tmux config
    backup_config "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Copy tmux config
    print_step "Copiando configuración de Tmux..."
    if [ -f "$SCRIPT_DIR/dotfiles/tmux/.tmux.conf" ]; then
        cp "$SCRIPT_DIR/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
        print_success "Configuración de Tmux actualizada"
        
        # Create tmux directory and plugins directory if they don't exist
        mkdir -p "$HOME/.tmux/plugins"
        
        # Copy tmux scripts if they exist
        if [ -d "$SCRIPT_DIR/dotfiles/tmux/scripts" ]; then
            mkdir -p "$HOME/.tmux/scripts"
            cp -r "$SCRIPT_DIR/dotfiles/tmux/scripts"/* "$HOME/.tmux/scripts/"
            print_success "Tmux scripts copied to $HOME/.tmux/scripts/"
        fi
        
        print_warning "Para instalar plugins de Tmux, ejecuta en una sesión de tmux:"
        echo -e "${CYAN}  Ctrl+Space + I${NC} (mayúscula i)"
        
    else
        print_error "No se encontró $SCRIPT_DIR/dotfiles/tmux/.tmux.conf"
        return 1
    fi
}

# Function to update Kitty config
update_kitty() {
    print_section "🐱 ACTUALIZANDO CONFIGURACIÓN DE KITTY"
    
    # Get the script directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Create kitty config directory if it doesn't exist
    mkdir -p "$HOME/.config/kitty"
    
    # Backup existing kitty config
    backup_config "$HOME/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Copy kitty config
    print_step "Copiando configuración de Kitty..."
    if [ -f "$SCRIPT_DIR/dotfiles/kitty/kitty.conf" ]; then
        cp "$SCRIPT_DIR/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
        print_success "Configuración de Kitty actualizada"
        
        # Copy theme switcher if it exists
        if [ -f "$SCRIPT_DIR/dotfiles/kitty/theme-switcher.sh" ]; then
            cp "$SCRIPT_DIR/dotfiles/kitty/theme-switcher.sh" "$HOME/.config/kitty/"
            chmod +x "$HOME/.config/kitty/theme-switcher.sh"
            print_success "Theme switcher copiado"
        fi
        
    else
        print_error "No se encontró $SCRIPT_DIR/dotfiles/kitty/kitty.conf"
        return 1
    fi
}

# Function to update both configs
update_all() {
    print_section "🔄 ACTUALIZADOR DE CONFIGURACIONES"
    echo -e "${CYAN}Actualizando Tmux y Kitty desde dotfiles...${NC}"
    echo ""
    
    # Update Tmux
    if update_tmux; then
        echo ""
    else
        print_error "Error actualizando Tmux"
        return 1
    fi
    
    # Update Kitty
    if update_kitty; then
        echo ""
    else
        print_error "Error actualizando Kitty"
        return 1
    fi
    
    print_section "✅ ACTUALIZACIÓN COMPLETADA"
    echo -e "${GREEN}¡Todas las configuraciones han sido actualizadas exitosamente!${NC}"
    echo ""
    echo -e "${YELLOW}📝 Próximos pasos:${NC}"
    echo -e "${CYAN}  • Para Tmux: Abre una sesión de tmux y presiona Ctrl+Space + I${NC}"
    echo -e "${CYAN}  • Para Kitty: Reinicia Kitty o abre una nueva terminal${NC}"
    echo ""
}

# Function to show help
show_help() {
    echo -e "${PURPLE}🔄 ACTUALIZADOR DE CONFIGURACIONES${NC}"
    echo ""
    echo -e "${CYAN}Uso:${NC}"
    echo -e "  $0 [opción]"
    echo ""
    echo -e "${CYAN}Opciones:${NC}"
    echo -e "  ${GREEN}tmux${NC}     - Actualizar solo configuración de Tmux"
    echo -e "  ${GREEN}kitty${NC}    - Actualizar solo configuración de Kitty"
    echo -e "  ${GREEN}all${NC}      - Actualizar ambas configuraciones (por defecto)"
    echo -e "  ${GREEN}help${NC}     - Mostrar esta ayuda"
    echo ""
    echo -e "${CYAN}Ejemplos:${NC}"
    echo -e "  $0 tmux    # Solo actualizar Tmux"
    echo -e "  $0 kitty   # Solo actualizar Kitty"
    echo -e "  $0         # Actualizar ambas"
    echo ""
}

# Main script logic
case "${1:-all}" in
    "tmux")
        update_tmux
        ;;
    "kitty")
        update_kitty
        ;;
    "all")
        update_all
        ;;
    "help"|"-h"|"--help")
        show_help
        ;;
    *)
        print_error "Opción inválida: $1"
        echo ""
        show_help
        exit 1
        ;;
esac 