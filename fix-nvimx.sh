#!/bin/bash

# Script para arreglar la instalación de NVimX
echo "🔧 Arreglando instalación de NVimX..."

# Limpiar caché de Neovim
echo "🧹 Limpiando caché de Neovim..."
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/share/nvim/lazy-rocks
rm -rf ~/.cache/nvim

# Hacer backup de la configuración actual
if [ -d ~/.config/nvim ]; then
    echo "📦 Haciendo backup de la configuración actual..."
    mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

# Copiar la configuración de NVimX
echo "📋 Copiando configuración de NVimX..."
cp -r dotfiles/nvim ~/.config/nvim

# Instalar dependencias necesarias
echo "📦 Instalando dependencias..."
sudo pacman -S --needed --noconfirm \
    nodejs \
    npm \
    ripgrep \
    fd \
    fzf \
    tree-sitter \
    gcc \
    make \
    cmake \
    unzip \
    wget \
    curl

# Instalar LSP servers
echo "🔧 Instalando LSP servers..."
npm install -g typescript typescript-language-server @tailwindcss/language-server

# Probar Neovim
echo "🧪 Probando Neovim..."
nvim --headless -c "lua print('NVimX instalado correctamente')" -c "quit"

if [ $? -eq 0 ]; then
    echo "✅ NVimX instalado correctamente!"
    echo "🚀 Puedes abrir Neovim con: nvim"
else
    echo "❌ Hubo un problema con la instalación"
    echo "🔍 Revisa los logs anteriores para más detalles"
fi 