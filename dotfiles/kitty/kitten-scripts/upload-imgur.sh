#!/bin/bash
# Sube una imagen a imgur y copia el enlace al portapapeles
# Uso: upload-imgur.sh <ruta-imagen>

if [ -z "$1" ]; then
  echo "Uso: $0 <ruta-imagen>"
  exit 1
fi

response=$(curl -s -H "Authorization: Client-ID 546b2c6e3e1b1b1" -F "image=@$1" https://api.imgur.com/3/image)
url=$(echo "$response" | grep -o 'https://i.imgur.com/[a-zA-Z0-9]*.\(jpg\|png\|gif\)')

if [ -n "$url" ]; then
  if command -v wl-copy &>/dev/null; then
    echo -n "$url" | wl-copy
  elif command -v xclip &>/dev/null; then
    echo -n "$url" | xclip -selection clipboard
  fi
  echo "Imagen subida: $url (copiado al portapapeles)"
else
  echo "Error al subir la imagen."
fi 