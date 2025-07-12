#!/bin/bash

# Script para configurar Waypaper automáticamente

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_section() {
    echo -e "${BLUE}› $1${NC}"
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

# Función para configurar waypaper
configure_waypaper() {
    print_section "Configurando Waypaper..."
    
    # Verificar si waypaper está instalado
    if ! command -v waypaper >/dev/null 2>&1; then
        print_error "Waypaper no está instalado"
        print_step "Instalando waypaper..."
        yay -S waypaper --noconfirm --needed
    fi
    
    # Crear directorio de configuración
    print_step "Creando directorio de configuración..."
    mkdir -p "$HOME/.config/waypaper"
    
    # Crear configuración básica de waypaper
    print_step "Creando configuración de waypaper..."
    cat > "$HOME/.config/waypaper/waypaper.json" << 'EOF'
{
    "daemon": {
        "enabled": true,
        "interval": 300
    },
    "wallpaper": {
        "mode": "stretch",
        "output": "all"
    },
    "image": {
        "path": "~/Pictures/wallpapers",
        "sort": "name"
    },
    "hyprland": {
        "enabled": true,
        "method": "hyprctl"
    }
}
EOF
    
    # Crear directorio de wallpapers si no existe
    print_step "Configurando directorio de wallpapers..."
    mkdir -p "$HOME/Pictures/wallpapers"
    
    # Copiar wallpapers del proyecto si existen
    if [ -d "wallpapers" ]; then
        print_step "Copiando wallpapers del proyecto..."
        cp -r wallpapers/* "$HOME/Pictures/wallpapers/" 2>/dev/null || true
        print_success "Wallpapers copiados"
    fi
    
    # Crear script de inicio automático
    print_step "Configurando inicio automático..."
    mkdir -p "$HOME/.config/autostart"
    
    cat > "$HOME/.config/autostart/waypaper.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=Waypaper
Comment=Waypaper wallpaper daemon
Exec=waypaper --daemon
Terminal=false
X-GNOME-Autostart-enabled=true
EOF
    
    # Hacer el script ejecutable
    chmod +x "$HOME/.config/autostart/waypaper.desktop"
    
    print_success "Waypaper configurado correctamente"
    
    # Mostrar información de uso
    echo ""
    echo "🎨 Waypaper configurado:"
    echo "  • Configuración: ~/.config/waypaper/waypaper.json"
    echo "  • Wallpapers: ~/Pictures/wallpapers/"
    echo "  • Inicio automático: ~/.config/autostart/waypaper.desktop"
    echo ""
    echo "Comandos útiles:"
    echo "  waypaper --random     - Wallpaper aleatorio"
    echo "  waypaper --restore    - Restaurar wallpaper"
    echo "  waypaper --daemon     - Iniciar daemon"
    echo "  waypaper --gui        - Interfaz gráfica"
    echo ""
    echo "Atajos de teclado:"
    echo "  SUPER+SHIFT+W - Wallpaper aleatorio"
    echo "  SUPER+CTRL+W  - Restaurar wallpaper"
    echo "  SUPER+ALT+W   - Iniciar daemon"
}

# Función principal
main() {
    configure_waypaper
}

# Ejecutar función principal
main "$@" 