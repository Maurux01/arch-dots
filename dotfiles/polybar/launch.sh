#!/bin/bash

# Detener instancias previas
killall -q polybar

# Esperar a que terminen
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Lanzar Polybar con la configuración principal
echo "Lanzando Polybar..."
polybar main -c ~/.config/polybar/config & 