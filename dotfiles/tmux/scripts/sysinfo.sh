#!/bin/bash
# RAM: used/total (GB) con icono cool
ram=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
# CPU: % usage (promedio 1s) con icono cool
cpu=$(top -bn2 | grep "Cpu(s)" | tail -n1 | awk '{print $2+$4"%"}')
# Temp (si tienes sensors) con icono cool
temp=$(sensors 2>/dev/null | grep 'Tctl:' | awk '{print $2}' | head -1)
[ -z "$temp" ] && temp="N/A"

# Iconos cool con colores
echo "  󰍛 $ram  󰘚 $cpu  󰈐 $temp" 