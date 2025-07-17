#!/bin/bash
# Instala y enlaza la configuración de Hyprland desde el repositorio a ~/.config/hypr

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
HYPR_DIR="$HOME/.config/hypr"
SCRIPT_DIR="$HYPR_DIR/script"
CACHE_WALLPAPER="$HOME/.cache/wallpaper"

# Crear directorios si no existen
mkdir -p "$SCRIPT_DIR"

# Enlazar hyprland.conf
ln -sf "$REPO_DIR/hyprland.conf" "$HYPR_DIR/hyprland.conf"
echo "[OK] Enlace: hyprland.conf -> $HYPR_DIR/hyprland.conf"

# Enlazar scripts
ln -sf "$REPO_DIR/script/save_wallpaper.sh" "$SCRIPT_DIR/save_wallpaper.sh"
ln -sf "$REPO_DIR/../scripts/random-wallpaper.sh" "$SCRIPT_DIR/random-wallpaper.sh"
echo "[OK] Enlaces de scripts creados en $SCRIPT_DIR"

# Dar permisos de ejecución
chmod +x "$SCRIPT_DIR/save_wallpaper.sh" "$SCRIPT_DIR/random-wallpaper.sh"
echo "[OK] Permisos de ejecución asignados"

# Comprobar si swww, waybar y nm-applet están instalados
for bin in swww waybar nm-applet; do
    if ! command -v "$bin" >/dev/null 2>&1; then
        echo "[ADVERTENCIA] El binario '$bin' no está instalado o no está en PATH."
    fi
done

# Comprobar si ~/.cache/wallpaper existe, si no, crear uno por defecto
if [ ! -f "$CACHE_WALLPAPER" ]; then
    echo "[INFO] ~/.cache/wallpaper no existe. Creando fondo por defecto."
    mkdir -p "$(dirname "$CACHE_WALLPAPER")"
    echo "$HOME/.config/wallpapers/default.jpg" > "$CACHE_WALLPAPER"
    echo "[OK] Fondo por defecto establecido en $HOME/.config/wallpapers/default.jpg"
fi

# Mensaje final
cat << EOF

¡Configuración de Hyprland instalada y enlazada correctamente!

- Edita ~/.config/hypr/hyprland.conf para personalizar tu entorno.
- Cambia tu wallpaper con el script random-wallpaper.sh o tu gestor favorito.
- Asegúrate de tener swww, waybar y nm-applet instalados para el mejor funcionamiento.
- El último wallpaper usado se restaurará automáticamente al iniciar Hyprland.

EOF 