#!/bin/bash

# Script interactivo para cambiar el fondo de SDDM de forma amigable
# Usa zenity, yad o fzf si están disponibles
# Copia la imagen seleccionada a ~/Pictures/wallpapers/sddm-background.jpg
# Muestra notificación al finalizar

set -e

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
TARGET="$WALLPAPER_DIR/sddm-background.jpg"

# Función para mostrar notificación
notify() {
    local msg="$1"
    if command -v notify-send >/dev/null; then
        notify-send "SDDM" "$msg"
    else
        echo "$msg"
    fi
}

# Selección de archivo
select_image() {
    # Opción gráfica con zenity
    if command -v zenity >/dev/null; then
        zenity --file-selection --title="Selecciona el fondo para SDDM" --filename="$WALLPAPER_DIR/" --file-filter='*.jpg *.jpeg *.png *.webp' 2>/dev/null
        return
    fi
    # Opción gráfica con yad
    if command -v yad >/dev/null; then
        yad --file-selection --title="Selecciona el fondo para SDDM" --filename="$WALLPAPER_DIR/" --file-filter='*.jpg *.jpeg *.png *.webp' 2>/dev/null
        return
    fi
    # Opción terminal con fzf
    if command -v fzf >/dev/null; then
        find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | fzf --prompt="Selecciona el fondo para SDDM: "
        return
    fi
    # Fallback: pedir ruta manual
    echo "Introduce la ruta de la imagen que quieres usar como fondo de SDDM:"
    read -r img
    echo "$img"
}

main() {
    mkdir -p "$WALLPAPER_DIR"
    img="$(select_image)"
    if [ -z "$img" ] || [ ! -f "$img" ]; then
        notify "No se seleccionó una imagen válida."
        exit 1
    fi
    cp "$img" "$TARGET"
    notify "¡Fondo de SDDM actualizado!"
    echo "Fondo de SDDM cambiado a: $TARGET"
}

main "$@" 