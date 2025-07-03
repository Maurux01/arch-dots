#!/bin/bash
# Instalar fuentes Nerd Fonts si no están
if ! fc-list | grep -qi 'FiraCode'; then
  echo "Instalando FiraCode Nerd Font..."
  sudo pacman -S --noconfirm ttf-firacode-nerd
fi
if ! fc-list | grep -qi 'JetBrainsMono'; then
  echo "Instalando JetBrainsMono Nerd Font..."
  sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd
fi

echo "Fuentes instaladas. ¡Listo para usar tu entorno!" 