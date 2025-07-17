#!/bin/bash
# Lista todas las tabletas detectadas por el sistema

echo "Detectando tabletas conectadas..."
lsusb | grep -i -E 'tablet|wacom|huion|xp-pen|xppen|gaomon|veikk|ugee'

echo
# Mostrar dispositivos input relacionados
echo "Dispositivos input relacionados:"
for dev in /dev/input/event*; do
  udevadm info --query=all --name=$dev | grep -iE 'tablet|wacom|huion|xp-pen|xppen|gaomon|veikk|ugee' && echo "  $dev"
done 