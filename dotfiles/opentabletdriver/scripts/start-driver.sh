#!/bin/bash
# Inicia OpenTabletDriver en modo background y detecta tabletas automáticamente

CONFIG_DIR="$HOME/.config/OpenTabletDriver"
CONFIG_FILE="$CONFIG_DIR/config.json"

# Usa la configuración predeterminada si no existe config.json
if [ ! -f "$CONFIG_FILE" ]; then
  mkdir -p "$CONFIG_DIR"
  cp "$(dirname "$0")/../config/default.json" "$CONFIG_FILE"
fi

# Ejecuta el driver (modo background, auto-detect)
/usr/bin/OpenTabletDriver --background --auto-detect --config "$CONFIG_FILE" & 