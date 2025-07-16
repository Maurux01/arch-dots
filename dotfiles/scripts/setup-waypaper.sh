#!/bin/bash

# Script para configurar Waypaper correctamente
# Este script crea la configuración de Waypaper y asegura que guarde el wallpaper seleccionado

set -e

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() {
    echo -e "${BLUE}→ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Crear directorio de configuración
print_step "Creando directorio de configuración de Waypaper..."
mkdir -p ~/.config/waypaper

# Crear archivo de configuración de Waypaper
print_step "Creando configuración de Waypaper..."
cat > ~/.config/waypaper/waypaper.json << 'EOF'
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
        "path": "$HOME/Pictures/wallpapers",
        "sort": "name"
    },
    "hyprland": {
        "enabled": true,
        "method": "hyprctl"
    }
}
EOF

# Crear directorio de wallpapers si no existe
print_step "Creando directorio de wallpapers..."
mkdir -p ~/Pictures/wallpapers

# Crear archivo de autostart para Waypaper
print_step "Configurando inicio automático de Waypaper..."
mkdir -p ~/.config/autostart

cat > ~/.config/autostart/waypaper.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Waypaper
Comment=Waypaper wallpaper daemon
Exec=waypaper --daemon
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

chmod +x ~/.config/autostart/waypaper.desktop

# Verificar si hay wallpapers en el directorio
if [ -z "$(ls -A ~/Pictures/wallpapers 2>/dev/null)" ]; then
    print_warning "El directorio ~/Pictures/wallpapers está vacío"
    print_step "Copiando wallpapers de dotfiles si existen..."
    
    if [ -d "dotfiles/wallpapers" ]; then
        cp -r dotfiles/wallpapers/* ~/Pictures/wallpapers/ 2>/dev/null || true
        print_success "Wallpapers copiados desde dotfiles"
    else
        print_warning "No se encontraron wallpapers en dotfiles/wallpapers"
        print_step "Puedes agregar wallpapers manualmente en ~/Pictures/wallpapers"
    fi
else
    print_success "Wallpapers encontrados en ~/Pictures/wallpapers"
fi

# Verificar que Waypaper esté instalado
if ! command -v waypaper >/dev/null 2>&1; then
    print_warning "Waypaper no está instalado"
    print_step "Instalando Waypaper..."
    yay -S waypaper --noconfirm --needed
    print_success "Waypaper instalado"
else
    print_success "Waypaper ya está instalado"
fi

# Iniciar Waypaper daemon
print_step "Iniciando Waypaper daemon..."
pkill -f waypaper || true
sleep 1
waypaper --daemon &
print_success "Waypaper daemon iniciado"

print_success "Configuración de Waypaper completada"
print_step "Para usar Waypaper:"
echo "  - Ejecuta 'waypaper' para abrir la interfaz"
echo "  - Selecciona un wallpaper y se guardará automáticamente"
echo "  - El wallpaper se mantendrá tras reiniciar"
echo "  - El daemon se ejecutará automáticamente al iniciar sesión" 