#!/bin/bash

# =============================================================================
# 🎨 RANDOM WALLPAPER SCRIPT
# =============================================================================
# Script para cambiar wallpapers aleatoriamente usando swww
# =============================================================================

# Directorio de wallpapers (ubicación estándar del sistema)
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Verificar si el directorio existe
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "❌ Directorio de wallpapers no encontrado: $WALLPAPER_DIR"
    echo "📁 Creando directorio..."
    mkdir -p "$WALLPAPER_DIR"
    echo "✅ Directorio creado. Agrega tus wallpapers ahí."
    exit 1
fi

# Buscar archivos de imagen
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.gif" -o -iname "*.webp" \)))

# Verificar si hay wallpapers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "❌ No se encontraron wallpapers en: $WALLPAPER_DIR"
    echo "📁 Agrega archivos de imagen (.jpg, .png, .webp, etc.) al directorio."
    exit 1
fi

# Seleccionar wallpaper aleatorio
RANDOM_WALLPAPER="${WALLPAPERS[$((RANDOM % ${#WALLPAPERS[@]}))]}"

# Cambiar wallpaper con swww (transiciones súper rápidas)
echo "🎨 Cambiando wallpaper a: $(basename "$RANDOM_WALLPAPER")"
swww img "$RANDOM_WALLPAPER" \
    --transition-type wipe \
    --transition-duration 0.2 \
    --transition-fps 120 \
    --transition-angle 30 \
    --transition-step 90

echo "✅ Wallpaper cambiado exitosamente!" 