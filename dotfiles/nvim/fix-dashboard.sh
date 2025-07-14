#!/bin/bash

# Script para arreglar el dashboard de Neovim
echo "🔧 Arreglando el dashboard de Neovim..."

# Verificar si Neovim está instalado
if ! command -v nvim &> /dev/null; then
    echo "❌ Error: Neovim no está instalado"
    exit 1
fi

echo "✅ Neovim encontrado"

# Verificar configuración
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "❌ Error: Configuración de Neovim no encontrada"
    echo "   Ejecuta: cp -r dotfiles/nvim ~/.config/"
    exit 1
fi

echo "✅ Configuración de Neovim encontrada"

# Limpiar caché de plugins
echo "🧹 Limpiando caché de plugins..."
rm -rf "$HOME/.local/share/nvim/lazy"
rm -rf "$HOME/.local/share/nvim/site"
rm -rf "$HOME/.cache/nvim"

# Reinstalar plugins
echo "📦 Reinstalando plugins..."
nvim --headless -c "Lazy! sync" -c "quit" 2>/dev/null

# Verificar dashboard
echo "🔍 Verificando dashboard..."
nvim --headless -c "lua print('Dashboard plugin:', require('lazy').plugins()['nvimdev/dashboard-nvim'] and 'OK' or 'MISSING')" -c "quit" 2>/dev/null

echo "✅ Proceso completado"
echo ""
echo "🎯 Para probar el dashboard:"
echo "   1. Abre Neovim sin argumentos: nvim"
echo "   2. El dashboard debería aparecer automáticamente"
echo "   3. Si no aparece, ejecuta: :Dashboard"
echo "   4. Para forzar la recarga: :Lazy sync"
echo ""
echo "🔧 Si el problema persiste:"
echo "   - Ejecuta: nvim --headless -l test-dashboard.lua"
echo "   - Verifica: :checkhealth"
echo "   - Reinstala: :Lazy clean && :Lazy sync" 