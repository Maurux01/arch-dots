# Script: save_wallpaper.sh

Este script guarda la ruta del wallpaper actual en `~/.cache/wallpaper` para que Hyprland (usando swww) pueda restaurarlo automáticamente al iniciar la sesión.

## Uso

```sh
bash save_wallpaper.sh /ruta/al/wallpaper
```

Puedes llamar este script cada vez que cambies el wallpaper (por ejemplo, desde tu gestor de wallpapers o script personalizado).

## Integración con Hyprland

Asegúrate de que tu archivo `hyprland.conf` tenga la siguiente línea para restaurar el wallpaper al iniciar:

```
exec-once = swww init && swww img $(cat ~/.cache/wallpaper)
```

Así, el último wallpaper usado se cargará automáticamente al iniciar Hyprland. 