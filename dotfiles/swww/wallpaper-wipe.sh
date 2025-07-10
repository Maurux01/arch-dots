#!/bin/bash
# Cambia el wallpaper con animación tipo wipe usando swww

WALLPAPER="$1"
if [ -z "$WALLPAPER" ]; then
  echo "Uso: $0 /ruta/al/wallpaper.jpg"
  exit 1
fi

swww img "$WALLPAPER" \
  --transition-type wipe \
  --transition-fps 60 \
  --transition-duration 1.2 \
  --transition-angle 90
