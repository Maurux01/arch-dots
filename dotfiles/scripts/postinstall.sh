#!/bin/bash
set -e

echo "🎨 Configurando fuentes y configuraciones post-instalación..."

# Función para instalar fuentes de forma segura
install_font() {
  local font_name="$1"
  local package_name="$2"
  
  if ! fc-list | grep -qi "$font_name"; then
    echo "📦 Instalando $font_name..."
    sudo pacman -S --noconfirm "$package_name"
    echo "✓ $font_name instalado"
  else
    echo "✓ $font_name ya está instalado"
  fi
}

# Instalar fuentes Nerd Fonts
install_font "FiraCode" "ttf-firacode-nerd"
install_font "JetBrainsMono" "ttf-jetbrains-mono-nerd"
install_font "Hack" "ttf-hack-nerd"
install_font "SourceCodePro" "ttf-sourcecodepro-nerd"

# Actualizar caché de fuentes
echo "🔄 Actualizando caché de fuentes..."
fc-cache -fv

# Verificar que eww esté funcionando
if command -v eww >/dev/null 2>&1; then
  echo "🔧 Configurando eww..."
  eww daemon &
  sleep 2
  eww open-many main-bar || echo "⚠ Eww widgets no se pudieron abrir (normal en primera ejecución)"
fi

# Configurar permisos para scripts
chmod +x ~/.config/eww/scripts/*.sh 2>/dev/null || true

# Verificar configuración de Hyprland
if [[ -f ~/.config/hypr/hyprland.conf ]]; then
  echo "✅ Hyprland configurado correctamente"
else
  echo "⚠ Hyprland no está configurado"
fi

# Verificar configuración de Neovim
if [[ -d ~/.config/nvim ]]; then
  echo "✅ Neovim configurado correctamente"
  echo "💡 Ejecuta 'nvim' y espera a que se instalen los plugins"
else
  echo "⚠ Neovim no está configurado"
fi

echo "🎉 ¡Configuración post-instalación completada!"
echo "💡 Reinicia tu sesión para aplicar todos los cambios" 