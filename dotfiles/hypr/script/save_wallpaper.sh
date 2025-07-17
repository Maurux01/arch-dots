#!/bin/bash
# Guarda la ruta del wallpaper actual en ~/.cache/wallpaper

# Ruta del wallpaper (ajusta según tu gestor de wallpapers)
WALLPAPER_PATH="$1"

if [ -z "$WALLPAPER_PATH" ]; then
  echo "Uso: $0 /ruta/al/wallpaper"
  exit 1
fi

echo "$WALLPAPER_PATH" > ~/.cache/wallpaper 