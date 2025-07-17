#!/bin/bash
# Cambia el wallpaper aleatoriamente y guarda la ruta

WALLPAPER_DIR="$HOME/.config/wallpapers"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

if [ -n "$WALLPAPER" ]; then
    swww img "$WALLPAPER"
    bash ~/.config/hypr/script/save_wallpaper.sh "$WALLPAPER"
fi 