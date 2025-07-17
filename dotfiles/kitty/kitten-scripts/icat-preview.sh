#!/bin/bash
# Previsualización de imágenes en terminal con kitten icat
# Uso: icat-preview.sh <ruta-imagen>

if [ -z "$1" ]; then
  echo "Uso: $0 <ruta-imagen>"
  exit 1
fi

kitty +kitten icat --clear --transfer-mode=memory --stdin=no "$1" 