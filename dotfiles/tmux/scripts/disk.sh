#!/bin/bash
# Obtener uso de disco del directorio actual
disk_usage=$(df -h . | tail -1 | awk '{print $5}')
# Obtener espacio libre en GB
free_space=$(df -h . | tail -1 | awk '{print $4}')
# Obtener el sistema de archivos
fs_type=$(df -T . | tail -1 | awk '{print $2}')

echo "  󰋊 $disk_usage  󰆼 $free_space  󰒋 $fs_type" 