#!/bin/bash
set -e

# Paquetes necesarios
PACKAGES=(kitty tmux neovim fish git curl unzip grub)

# Instalar paquetes
sudo pacman -Syu --noconfirm "${PACKAGES[@]}"

# Instalar Oh My Fish
if ! command -v omf &> /dev/null; then
  curl -L https://get.oh-my.fish | fish
fi

# Instalar tema para Oh My Fish
fish -c "omf install bobthefish"

# Copiar dotfiles
mkdir -p ~/.config/kitty ~/.config/nvim ~/.config/fish ~/.tmux
cp dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
cp dotfiles/nvim/init.vim ~/.config/nvim/init.vim
cp dotfiles/fish/config.fish ~/.config/fish/config.fish
cp dotfiles/tmux/.tmux.conf ~/.tmux.conf

# Copiar wallpapers
mkdir -p ~/Pictures/wallpapers
cp dotfiles/wallpapers/* ~/Pictures/wallpapers/ 2>/dev/null || true

# Instalar tema de GRUB (ejemplo con Vimix)
if [ -d dotfiles/grub-themes ]; then
  sudo mkdir -p /boot/grub/themes
  sudo cp -r dotfiles/grub-themes/* /boot/grub/themes/
  sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub
  echo 'GRUB_THEME="/boot/grub/themes/Vimix/theme.txt"' | sudo tee -a /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

# Instalar picom para animaciones (opcional)
if ! pacman -Qs picom > /dev/null; then
  sudo pacman -S --noconfirm picom
fi

# Mensaje final
echo "\n¡Configuración completada! Reinicia tu sesión para aplicar los cambios." 