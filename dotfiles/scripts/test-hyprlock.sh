#!/bin/bash

# Script de diagnóstico para Hyprlock
# Verifica que hyprlock esté configurado y funcionando correctamente

set -e

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
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

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

echo "🔒 Diagnóstico de Hyprlock"
echo "=========================="

# Verificar si hyprlock está instalado
print_step "Verificando instalación de hyprlock..."
if command -v hyprlock > /dev/null; then
    print_success "Hyprlock está instalado: $(hyprlock --version)"
else
    print_error "Hyprlock no está instalado"
    echo "Instala con: sudo pacman -S hyprlock"
    exit 1
fi

# Verificar configuración
print_step "Verificando configuración..."
if [ -f "$HOME/.config/hypr/hyprlock.conf" ]; then
    print_success "Configuración encontrada: $HOME/.config/hypr/hyprlock.conf"
else
    print_error "Configuración no encontrada"
    exit 1
fi

# Verificar tema
print_step "Verificando tema..."
if [ -f "$HOME/.config/hypr/hyprlock/theme.conf" ]; then
    print_success "Tema encontrado: $HOME/.config/hypr/hyprlock/theme.conf"
else
    print_warning "Tema no encontrado, usando configuración por defecto"
fi

# Verificar imagen de fondo
print_step "Verificando imagen de fondo..."
if [ -f "$HOME/Pictures/wallpapers/sddm-background.jpg" ]; then
    print_success "Imagen de fondo encontrada: $HOME/Pictures/wallpapers/sddm-background.jpg"
else
    print_warning "Imagen de fondo no encontrada"
    echo "Crea la imagen: $HOME/Pictures/wallpapers/sddm-background.jpg"
fi

# Verificar keybind
print_step "Verificando keybind..."
if grep -q "bind.*L.*hyprlock" "$HOME/.config/hypr/keybindings.conf" 2>/dev/null || grep -q "bindd.*L.*hyprlock" "$HOME/.config/hypr/keybindings.conf" 2>/dev/null; then
    print_success "Keybind configurado: Super + L"
else
    print_warning "Keybind no encontrado en keybindings.conf"
    echo "Agrega: bind = SUPER, L, exec, hyprlock"
fi

# Probar hyprlock
print_step "Probando hyprlock..."
echo "Ejecutando hyprlock por 3 segundos..."
timeout 3 hyprlock 2>&1 | grep -E "(LOG|ERR)" || echo "Hyprlock se ejecutó correctamente"

print_success "Diagnóstico completado"
echo ""
echo "Para probar el bloqueo de pantalla:"
echo "1. Presiona Super + L"
echo "2. O ejecuta: hyprlock"
echo ""
echo "Si hay problemas:"
echo "- Verifica que estés en una sesión de Hyprland"
echo "- Revisa los logs: journalctl --user -u hyprlock"
echo "- Prueba manualmente: hyprlock" 