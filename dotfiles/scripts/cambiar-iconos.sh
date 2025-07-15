#!/bin/bash
# Script para cambiar el tema de iconos fácilmente

set -e

ICON_THEME="$1"

if [ -z "$ICON_THEME" ]; then
    echo "Uso: $0 <nombre_del_tema_de_iconos>"
    echo "Temas de iconos disponibles en ~/.local/share/icons y /usr/share/icons:"
    find ~/.local/share/icons /usr/share/icons -maxdepth 1 -type d -printf '%f\n' 2>/dev/null | grep -vE '^\.|icons$|hicolor$|default$|cursors$'
    exit 1
fi

# Cambiar en configuración GTK
CONFIG_FILE="$HOME/.config/gtk-3.0/settings.ini"
if [ -f "$CONFIG_FILE" ]; then
    sed -i "s/^gtk-icon-theme-name = .*/gtk-icon-theme-name = $ICON_THEME/" "$CONFIG_FILE"
else
    mkdir -p "$HOME/.config/gtk-3.0"
    echo "gtk-icon-theme-name = $ICON_THEME" > "$CONFIG_FILE"
fi

echo "Tema de iconos cambiado a: $ICON_THEME (puede requerir cerrar sesión o reiniciar)"

# Cambiar con gsettings si está disponible
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME" 2>/dev/null || true 