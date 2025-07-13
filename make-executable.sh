#!/bin/bash

# Script para hacer ejecutables los scripts principales
# Ejecutar en sistemas Linux

echo "Haciendo scripts ejecutables..."

chmod +x install.sh
chmod +x uninstall.sh
chmod +x repair.sh
chmod +x utils.sh

echo "Scripts principales hechos ejecutables:"
echo "✓ install.sh"
echo "✓ uninstall.sh"
echo "✓ repair.sh"
echo "✓ utils.sh"

echo ""
echo "Ahora puedes ejecutar:"
echo "  ./install.sh    # Para instalar todo"
echo "  ./uninstall.sh  # Para desinstalar todo"
echo "  ./repair.sh     # Para reparar el sistema"
echo "  ./utils.sh      # Para utilidades" 