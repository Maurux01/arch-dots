#!/bin/bash
# Lanza la interfaz gráfica de OpenTabletDriver

if command -v OpenTabletDriver.Gui &> /dev/null; then
  OpenTabletDriver.Gui &
elif command -v opentabletdriver-gui &> /dev/null; then
  opentabletdriver-gui &
else
  echo "No se encontró la GUI de OpenTabletDriver. ¿Está instalada?"
  exit 1
fi 