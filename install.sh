#!/bin/bash
set -e

clear
cat <<'EOF'
 _              _     _      _      _      
/_\\  _ __  ___| |__ (_)_ _ (_)__ _| |__  
/ _ \\| '_ \/ -_) '_ \\| | ' \\| / _` | '_ \\ 
/_/ \\_\\ .__/\___|_.__/|_|_||_|_\\__, |_.__/
      |_|                      |___/       
   archriced by maurux01
EOF

echo "\nSelecciona qué deseas instalar (puedes elegir varias opciones separadas por coma, ej: 1,3,5):"
echo "1) Todo el entorno (recomendado)"
echo "2) Componentes visuales (Hyprland, Waybar, eww, etc.)"
echo "3) Herramientas extra (yazi, lazygit, etc.)"
echo "4) Lenguajes de programación (Python, Node, Rust, etc.)"
echo "5) Neovim IDE"
echo "6) Apps creativas, gaming y utilidades"
echo -n "Ingresa tu selección: "
read SELECTIONS

INSTALL_VISUALS=0
INSTALL_EXTRA=0
INSTALL_LANGS=0
INSTALL_NVIM=0
INSTALL_APPS=0

if [[ $SELECTIONS == *1* ]]; then
  INSTALL_VISUALS=1
  INSTALL_EXTRA=1
  INSTALL_LANGS=1
  INSTALL_NVIM=1
  INSTALL_APPS=1
else
  [[ $SELECTIONS == *2* ]] && INSTALL_VISUALS=1
  [[ $SELECTIONS == *3* ]] && INSTALL_EXTRA=1
  [[ $SELECTIONS == *4* ]] && INSTALL_LANGS=1
  [[ $SELECTIONS == *5* ]] && INSTALL_NVIM=1
  [[ $SELECTIONS == *6* ]] && INSTALL_APPS=1
fi

# Función para verificar si un archivo existe antes de copiarlo
copy_if_exists() {
  local src="$1"
  local dest="$2"
  if [[ -f "$src" ]]; then
    cp "$src" "$dest"
    echo "✓ Copiado: $src"
  else
    echo "⚠ Archivo no encontrado: $src"
  fi
}

# Función para verificar si un directorio existe antes de copiarlo
copy_dir_if_exists() {
  local src="$1"
  local dest="$2"
  if [[ -d "$src" ]]; then
    cp -r "$src"/* "$dest/" 2>/dev/null || true
    echo "✓ Copiado directorio: $src"
  else
    echo "⚠ Directorio no encontrado: $src"
  fi
}

# Instalación de componentes visuales
if [[ $INSTALL_VISUALS == 1 ]]; then
  echo "\n📦 Instalando componentes visuales..."
  
  # Verificar si estamos en un entorno real (no WSL)
  if [[ -d "/boot" && -f "/etc/default/grub" ]]; then
    PACKAGES=(kitty tmux fish git curl unzip grub hyprland waybar mako wofi swww eww grim slurp wl-clipboard ttf-firacode-nerd ttf-jetbrains-mono-nerd)
  else
    echo "⚠ Detectado entorno virtual/WSL - omitiendo GRUB y Hyprland"
    PACKAGES=(kitty tmux fish git curl unzip waybar mako wofi swww eww grim slurp wl-clipboard ttf-firacode-nerd ttf-jetbrains-mono-nerd)
  fi
  
  # Instalar paquetes principales
  sudo pacman -Syu --noconfirm "${PACKAGES[@]}"
  
  # Crear directorios de configuración
  mkdir -p ~/.config/kitty ~/.config/fish ~/.tmux ~/.config/hypr ~/.config/waybar ~/.config/mako ~/.config/wofi ~/.config/swww ~/.config/eww
  
  # Copiar archivos de configuración con verificación
  copy_if_exists "dotfiles/kitty/kitty.conf" "~/.config/kitty/kitty.conf"
  copy_if_exists "dotfiles/fish/config.fish" "~/.config/fish/config.fish"
  copy_if_exists "dotfiles/tmux/.tmux.conf" "~/.tmux.conf"
  copy_if_exists "dotfiles/hypr/hyprland.conf" "~/.config/hypr/hyprland.conf"
  copy_if_exists "dotfiles/waybar/config" "~/.config/waybar/config"
  copy_if_exists "dotfiles/waybar/style.css" "~/.config/waybar/style.css"
  copy_if_exists "dotfiles/mako/config" "~/.config/mako/config"
  copy_if_exists "dotfiles/wofi/config" "~/.config/wofi/config"
  copy_if_exists "dotfiles/wofi/style.css" "~/.config/wofi/style.css"
  copy_dir_if_exists "dotfiles/eww" "~/.config/eww"
  
  # Copiar wallpapers
  mkdir -p ~/Pictures/wallpapers
  copy_dir_if_exists "dotfiles/wallpapers" "~/Pictures/wallpapers"
  
  # Configurar GRUB solo si estamos en un entorno real
  if [[ -d "/boot" && -f "/etc/default/grub" && -d "dotfiles/grub-themes" ]]; then
    echo "\n🎨 Configurando tema GRUB..."
    sudo mkdir -p /boot/grub/themes
    sudo cp -r dotfiles/grub-themes/* /boot/grub/themes/
    sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub
    echo 'GRUB_THEME="/boot/grub/themes/Vimix/theme.txt"' | sudo tee -a /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo "✓ Tema GRUB configurado"
  fi
  
  # Cambiar shell a fish solo si es posible
  if command -v fish >/dev/null 2>&1 && [[ "$SHELL" != "$(which fish)" ]]; then
    if chsh -s $(which fish) 2>/dev/null; then
      echo "✓ Shell cambiado a fish. Reinicia la terminal para aplicar."
    else
      echo "⚠ No se pudo cambiar el shell a fish (puede requerir permisos especiales)"
    fi
  fi
fi

# Instalación de herramientas extra
if [[ $INSTALL_EXTRA == 1 ]]; then
  echo "\n🛠️ Instalando herramientas extra..."
  EXTRA_PKGS=(gh yazi bat fd ripgrep btop zoxide fzf lazygit)
  sudo pacman -Syu --noconfirm "${EXTRA_PKGS[@]}"
  echo "✓ Herramientas extra instaladas"
fi

# Instalación de lenguajes de programación
if [[ $INSTALL_LANGS == 1 ]]; then
  echo "\n💻 Instalando lenguajes de programación..."
  sudo pacman -Syu --noconfirm python python-pip nodejs npm rust go jdk-openjdk gcc clang
  echo "✓ Lenguajes de programación instalados"
fi

# Instalación de Neovim IDE
if [[ $INSTALL_NVIM == 1 ]]; then
  echo "\n📝 Instalando Neovim IDE..."
  sudo pacman -Syu --noconfirm neovim
  mkdir -p ~/.config/nvim
  copy_dir_if_exists "dotfiles/nvim" "~/.config/nvim"
  echo "✓ Neovim IDE instalado"
fi

# Instalación de apps creativas, gaming y utilidades
if [[ $INSTALL_APPS == 1 ]]; then
  echo "\n🎮 Instalando apps creativas, gaming y utilidades..."
  
  # Paquetes del repositorio oficial
  OFFICIAL_PKGS=(ufw openvpn networkmanager-openvpn neofetch fastfetch obs-studio gimp kdenlive inkscape darktable blender steam blueman pavucontrol flameshot copyq cliphist jenkins vscodium podman)
  sudo pacman -Syu --noconfirm "${OFFICIAL_PKGS[@]}"
  
  # Paquetes que pueden requerir AUR
  AUR_PKGS=(appflowy ferdium discord heroic-games-launcher insomnia beekeeper-studio)
  echo "\n⚠ Los siguientes paquetes pueden requerir AUR:"
  for pkg in "${AUR_PKGS[@]}"; do
    echo "  - $pkg"
  done
  echo "\n💡 Si algún paquete no se instala, usa: yay -S <paquete> o pamac build <paquete>"
  
  echo "✓ Apps instaladas"
fi

echo "\n🎉 ¡Instalación completada! Reinicia tu sesión para aplicar todos los cambios." 