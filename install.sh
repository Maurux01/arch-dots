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

echo "\nSelecciona qué deseas instalar (usa espacio para seleccionar, enter para continuar):"
OPTIONS=(
  "Todo el entorno (recomendado)"
  "Componentes visuales (Hyprland, Waybar, eww, etc.)"
  "Herramientas extra (yazi, lazygit, etc.)"
  "Lenguajes de programación (Python, Node, Rust, etc.)"
  "Neovim IDE"
  "Apps creativas, gaming y utilidades"
)
SELECTIONS=$(printf '%s\n' "${OPTIONS[@]}" | fzf --multi --prompt="Selecciona: " --header="[Espacio] selecciona, [Enter] confirma")

if [[ "$SELECTIONS" == *"Todo el entorno"* ]]; then
  INSTALL_VISUALS=1
  INSTALL_EXTRA=1
  INSTALL_LANGS=1
  INSTALL_NVIM=1
  INSTALL_APPS=1
else
  [[ "$SELECTIONS" == *"Componentes visuales"* ]] && INSTALL_VISUALS=1
  [[ "$SELECTIONS" == *"Herramientas extra"* ]] && INSTALL_EXTRA=1
  [[ "$SELECTIONS" == *"Lenguajes de programación"* ]] && INSTALL_LANGS=1
  [[ "$SELECTIONS" == *"Neovim IDE"* ]] && INSTALL_NVIM=1
  [[ "$SELECTIONS" == *"Apps creativas, gaming y utilidades"* ]] && INSTALL_APPS=1
fi

# Instalación de componentes visuales
if [[ $INSTALL_VISUALS == 1 ]]; then
  PACKAGES=(kitty tmux fish git curl unzip grub hyprland waybar mako wofi swww eww grim slurp wl-clipboard ttf-firacode-nerd ttf-jetbrains-mono-nerd pamac)
  sudo pacman -Syu --noconfirm "${PACKAGES[@]}"
  mkdir -p ~/.config/kitty ~/.config/fish ~/.tmux ~/.config/hypr ~/.config/waybar ~/.config/mako ~/.config/wofi ~/.config/swww ~/.config/eww
  cp dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
  cp dotfiles/fish/config.fish ~/.config/fish/config.fish
  cp dotfiles/tmux/.tmux.conf ~/.tmux.conf
  cp dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
  cp dotfiles/waybar/config ~/.config/waybar/config
  cp dotfiles/waybar/style.css ~/.config/waybar/style.css
  cp dotfiles/mako/config ~/.config/mako/config
  cp dotfiles/wofi/config ~/.config/wofi/config
  cp dotfiles/wofi/style.css ~/.config/wofi/style.css
  cp -r dotfiles/eww/* ~/.config/eww/
  mkdir -p ~/Pictures/wallpapers
  cp dotfiles/wallpapers/* ~/Pictures/wallpapers/ 2>/dev/null || true
  if [ -d dotfiles/grub-themes ]; then
    sudo mkdir -p /boot/grub/themes
    sudo cp -r dotfiles/grub-themes/* /boot/grub/themes/
    sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub
    echo 'GRUB_THEME="/boot/grub/themes/Vimix/theme.txt"' | sudo tee -a /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
  fi
  if [ "$SHELL" != "$(which fish)" ]; then
    chsh -s $(which fish)
    echo "Shell cambiado a fish. Reinicia la terminal para aplicar."
  fi
fi

# Instalación de herramientas extra
if [[ $INSTALL_EXTRA == 1 ]]; then
  EXTRA_PKGS=(gh yazi bat fd ripgrep btop zoxide fzf lazygit)
  sudo pacman -Syu --noconfirm "${EXTRA_PKGS[@]}"
fi

# Instalación de lenguajes de programación
if [[ $INSTALL_LANGS == 1 ]]; then
  sudo pacman -Syu --noconfirm python python-pip nodejs npm rust go jdk-openjdk gcc clang
  echo "Lenguajes de programación instalados."
fi

# Instalación de Neovim IDE
if [[ $INSTALL_NVIM == 1 ]]; then
  sudo pacman -Syu --noconfirm neovim
  mkdir -p ~/.config/nvim
  cp -r dotfiles/nvim/* ~/.config/nvim/
fi

# Instalación de apps creativas, gaming y utilidades
if [[ $INSTALL_APPS == 1 ]]; then
  APPS_PKGS=(ufw openvpn networkmanager-openvpn neofetch fastfetch appflowy obs-studio gimp kdenlive ferdium inkscape darktable discord blender steam heroic-games-launcher insomnia blueman pavucontrol flameshot copyq cliphist jenkins beekeeper-studio)
  sudo pacman -Syu --noconfirm "${APPS_PKGS[@]}"
  echo "\n¡Apps creativas, gaming y utilidades instaladas!"
  echo "\nRecuerda: algunas apps como appflowy, heroic, ferdium, lm studio o beekeeper-studio pueden requerir AUR. Si no se instalan, usa pamac o yay para instalarlas."
fi

echo "\n¡Instalación completada! Reinicia tu sesión para aplicar todos los cambios." 