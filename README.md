# Arch Dots: Rice Automático y Moderno para Arch Linux + Hyprland

Este repositorio contiene una configuración moderna y automatizada para Arch Linux, incluyendo:
- Hyprland (Wayland compositor con animaciones)
- Waybar (barra de estado)
- mako (notificaciones)
- wofi (launcher)
- swww (fondos animados)
- eww (widgets)
- Kitty (terminal)
- tmux (multiplexor de terminal)
- Neovim (editor de texto)
- Fish + Oh My Fish (shell y gestor de temas)
- Wallpapers personalizados
- Tema atractivo para GRUB
- Animaciones fluidas

## Instalación

1. Clona este repositorio:
   ```bash
   git clone https://github.com/tuusuario/arch-dots.git
   cd arch-dots
   ```
2. Ejecuta el instalador automático:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
3. Cierra sesión y selecciona **Hyprland** como tu sesión gráfica en el login.

## Personalización
- Coloca tus wallpapers en `dotfiles/wallpapers/`.
- Puedes cambiar el tema de GRUB en `dotfiles/grub-themes/`.
- Modifica los archivos de configuración en `dotfiles/` según tus preferencias.
- Agrega scripts personalizados en `dotfiles/scripts/`.
- Agrega widgets de eww en `dotfiles/eww/` y scripts de swww en `dotfiles/swww/`.

## Requisitos
- Arch Linux o derivado
- Acceso a sudo
- Tarjeta gráfica compatible con Wayland

## Créditos
- Tema Catppuccin para Hyprland, Waybar, mako, wofi
- Tema Gruvbox para Kitty, tmux y Neovim
- Tema Vimix para GRUB: https://github.com/vinceliuice/grub2-themes

## Herramientas extra incluidas
- gh (GitHub CLI)
- yazi (gestor de archivos TUI)
- bat (cat con colores)
- fd (buscador rápido)
- ripgrep (búsqueda de texto)
- btop (monitor de sistema)
- zoxide (cd inteligente)
- fzf (fuzzy finder)
- lazygit (git TUI)

## Post-instalación
- Cambia el shell a fish automáticamente.
- Usa el alias `dotbackup` para subir tus cambios de dotfiles a GitHub fácilmente.

## Capturas de pantalla
_Agrega aquí tus screenshots y GIFs para mostrar tu entorno._

## Contribución
- Pull requests y sugerencias son bienvenidas.
- Licencia: MIT

## Troubleshooting
- Si algún programa no inicia, revisa los logs en ~/.local/share o ~/.cache.
- Si la shell no cambia a fish, ejecuta `chsh -s $(which fish)` manualmente.
- Si falta alguna fuente, ejecuta el script `dotfiles/scripts/postinstall.sh`.

## Changelog
- v1.0: Primera versión completa con Hyprland, Neovim IDE, herramientas extra y automatización total.

---
¡Disfruta de tu entorno Arch Linux + Hyprland totalmente personalizado y automatizado! 