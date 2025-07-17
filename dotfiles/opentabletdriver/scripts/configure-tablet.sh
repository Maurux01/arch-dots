#!/bin/bash
# Aplica la configuración predeterminada o seleccionada a la tableta detectada

CONFIG_DIR="$HOME/.config/OpenTabletDriver"
CONFIG_FILE="$CONFIG_DIR/config.json"
PROFILE_FILE="$CONFIG_DIR/default.json"

if [ ! -f "$PROFILE_FILE" ]; then
  echo "No se encontró configuración predeterminada."
  exit 1
fi

cp "$PROFILE_FILE" "$CONFIG_FILE"
echo "Configuración aplicada. Reinicia el driver si es necesario." 