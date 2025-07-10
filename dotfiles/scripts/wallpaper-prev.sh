#!/bin/bash
# Cambia al wallpaper anterior en la carpeta de imágenes del usuario

WALLPAPER_DIR="$HOME/Pictures"
STATE_FILE="$HOME/.config/swww/wallpaper_index.txt"

mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | sort)
COUNT=${#WALLPAPERS[@]}
[ $COUNT -eq 0 ] && echo "No wallpapers found in $WALLPAPER_DIR" && exit 1

INDEX=0
[ -f "$STATE_FILE" ] && INDEX=$(cat "$STATE_FILE")
INDEX=$(( (INDEX - 1 + COUNT) % COUNT ))
echo $INDEX > "$STATE_FILE"
swww img "${WALLPAPERS[$INDEX]}" --transition-type wipe --transition-fps 60 --transition-duration 1.2
