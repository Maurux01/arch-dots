#!/usr/bin/env bash

ICON_DIR="$HOME/Pictures/icons"
FETCH_CMD="${1:-neofetch}"

# Selecciona una imagen aleatoria
ICON=$(find "$ICON_DIR" -type f | shuf -n 1)

# Detecta terminal y visor de imágenes
show_icon() {
    if [ -n "$KITTY_WINDOW_ID" ] && command -v kitty &>/dev/null; then
        kitty +kitten icat "$ICON"
    elif command -v viu &>/dev/null; then
        viu -w 40 -h 20 "$ICON"
    elif command -v chafa &>/dev/null; then
        chafa --size=40x20 "$ICON"
    elif command -v tycat &>/dev/null; then
        tycat "$ICON"
    else
        echo "No image viewer found for terminal."
    fi
}

# Muestra el ícono
show_icon

# Ejecuta el fetch con la imagen como logo
if [ "$FETCH_CMD" = "neofetch" ]; then
    neofetch --image "$ICON" --image_size 40
elif [ "$FETCH_CMD" = "fastfetch" ]; then
    fastfetch --logo-type image --logo "$ICON" --logo-width 40
else
    echo "Unknown fetch command: $FETCH_CMD"
fi 