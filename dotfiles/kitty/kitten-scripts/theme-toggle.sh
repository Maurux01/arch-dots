#!/bin/bash
# Alterna entre Catppuccin Mocha y Tokyo Night en kitty.conf
KITTY_CONF="$HOME/.config/kitty/kitty.conf"

if grep -q '# === TOKYO NIGHT ===' "$KITTY_CONF"; then
  # Si Tokyo Night está comentado, lo activamos y desactivamos Catppuccin
  sed -i '/# === CATPPUCCIN MOCHA ===/,/# ===/s/^/#/' "$KITTY_CONF"
  sed -i '/# === TOKYO NIGHT ===/,/# ===/s/^#//' "$KITTY_CONF"
  notify-send "Kitty" "Tema Tokyo Night activado"
else
  # Si Catppuccin está comentado, lo activamos y desactivamos Tokyo Night
  sed -i '/# === TOKYO NIGHT ===/,/# ===/s/^/#/' "$KITTY_CONF"
  sed -i '/# === CATPPUCCIN MOCHA ===/,/# ===/s/^#//' "$KITTY_CONF"
  notify-send "Kitty" "Tema Catppuccin Mocha activado"
fi 