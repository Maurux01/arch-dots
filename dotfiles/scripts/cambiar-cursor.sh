#!/bin/bash
# Script para cambiar el cursor (mouse) fácilmente

set -e

CURSOR_NAME="$1"

if [ -z "$CURSOR_NAME" ]; then
    echo "Uso: $0 <nombre_del_cursor>"
    echo "Cursores disponibles en ~/.local/share/icons y /usr/share/icons:"
    find ~/.local/share/icons /usr/share/icons -maxdepth 1 -type d -printf '%f\n' 2>/dev/null | grep -vE '^\.|icons$|hicolor$|default$'
    exit 1
fi

# Cambiar en configuración GTK
CONFIG_FILE="$HOME/.config/gtk-3.0/settings.ini"
if [ -f "$CONFIG_FILE" ]; then
    sed -i "s/^gtk-cursor-theme-name = .*/gtk-cursor-theme-name = $CURSOR_NAME/" "$CONFIG_FILE"
else
    mkdir -p "$HOME/.config/gtk-3.0"
    echo "gtk-cursor-theme-name = $CURSOR_NAME" > "$CONFIG_FILE"
fi

echo "Cursor cambiado a: $CURSOR_NAME (puede requerir cerrar sesión o reiniciar)"

# Cambiar con gsettings si está disponible
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_NAME" 2>/dev/null || true 