#!/bin/bash

# =============================================================================
# 🎨 RANDOM WALLPAPER SCRIPT
# =============================================================================
# Script to change wallpapers randomly using swww
# =============================================================================

# Wallpapers directory (standard system location)
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Check if directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "❌ Wallpapers directory not found: $WALLPAPER_DIR"
    echo "📁 Creating directory..."
    mkdir -p "$WALLPAPER_DIR"
    echo "✅ Directory created. Add your wallpapers there."
    exit 1
fi

# Find image files
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.gif" -o -iname "*.webp" \)))

# Check if there are wallpapers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "❌ No wallpapers found in: $WALLPAPER_DIR"
    echo "📁 Add image files (.jpg, .png, .webp, etc.) to the directory."
    exit 1
fi

# Select random wallpaper
RANDOM_WALLPAPER="${WALLPAPERS[$((RANDOM % ${#WALLPAPERS[@]}))]}"

# Change wallpaper with swww (super fast transitions)
echo "🎨 Changing wallpaper to: $(basename "$RANDOM_WALLPAPER")"
swww img "$RANDOM_WALLPAPER" \
    --transition-type wipe \
    --transition-duration 0.2 \
    --transition-fps 120 \
    --transition-angle 30 \
    --transition-step 90

echo "✅ Wallpaper changed successfully!" 