#!/bin/bash
# Obtener interfaz de red activa
interface=$(ip route | grep default | awk '{print $5}' | head -1)
# Obtener IP local
ip=$(ip addr show $interface 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | head -1)
# Obtener velocidad de red (bytes/s)
rx_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes 2>/dev/null || echo "0")
tx_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes 2>/dev/null || echo "0")

# Convertir a KB/s (aproximado)
rx_kb=$((rx_bytes / 1024))
tx_kb=$((tx_bytes / 1024))

echo "  󰖩 $ip  󰕒 ${rx_kb}K  󰕓 ${tx_kb}K" 