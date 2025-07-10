# GRUB Themes

Coloca aquí tu tema de GRUB personalizado. Puedes descargar temas populares como Vimix desde:
https://github.com/vinceliuice/grub2-themes

Para instalar, el script install.sh copiará el tema a /boot/grub/themes.

# GRUB2 Catppuccin/Vinceliuice Theme

Este directorio está preparado para instalar temas modernos de GRUB2, como los de [vinceliuice/grub2-themes](https://github.com/vinceliuice/grub2-themes).

## Instalación rápida

1. Clona el repositorio de temas:
   ```bash
   git clone https://github.com/vinceliuice/grub2-themes.git /tmp/grub2-themes
   ```
2. Copia el tema que prefieras (por ejemplo, "catppuccin", "tela", "vimix", etc.) a tu sistema:
   ```bash
   sudo cp -r /tmp/grub2-themes/themes/catppuccin /boot/grub/themes/
   ```
3. Edita `/etc/default/grub` y añade o modifica la línea:
   ```
   GRUB_THEME="/boot/grub/themes/catppuccin/theme.txt"
   ```
4. Actualiza GRUB:
   ```bash
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```

## Más información
Consulta el repositorio oficial para ver capturas y más opciones: https://github.com/vinceliuice/grub2-themes