#!/bin/bash

# Script de instalación optimizado para Hyprland
# Versión simplificada y eficiente

set -e

# Output colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Global variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

print_header() {
    echo -e "${BLUE} ═════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                          Archriced                           ║${NC}"
    echo -e "${BLUE}║                         by maurux01                          ║${NC}"
    echo -e "${BLUE} ════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_section() {
    echo -e "${CYAN}› $1${NC}"
    log "SECTION: $1"
}

print_step() {
    echo -e "${YELLOW}  → $1${NC}"
    log "STEP: $1"
}

print_success() {
    echo -e "${GREEN}  ✓ $1${NC}"
    log "SUCCESS: $1"
}

print_error() {
    echo -e "${RED}  ✗ $1${NC}"
    log "ERROR: $1"
}

print_warning() {
    echo -e "${YELLOW}  ⚠ $1${NC}"
    log "ADVERTENCIA: $1"
}

# Función para instalar paquetes de forma eficiente
install_packages() {
    local packages=("$@")
    local aur_packages=()
    local pacman_packages=()
    
    # Separar paquetes AUR de paquetes oficiales
    for pkg in "${packages[@]}"; do
        if [[ "$pkg" == "hyperlock" || "$pkg" == "oss" || "$pkg" == "nerd-fonts-complete" ]]; then
            aur_packages+=("$pkg")
        else
            pacman_packages+=("$pkg")
        fi
    done
    
    # Instalar paquetes oficiales
    if [ ${#pacman_packages[@]} -gt 0 ]; then
        print_step "Instalando paquetes oficiales..."
        sudo pacman -S "${pacman_packages[@]}" --noconfirm --needed
    fi
    
    # Instalar paquetes AUR
    if [ ${#aur_packages[@]} -gt 0 ]; then
        print_step "Instalando paquetes AUR..."
        for pkg in "${aur_packages[@]}"; do
            yay -S "$pkg" --noconfirm --needed
        done
    fi
}

# Función para verificar sistema
check_system() {
    print_section "Checking system..."
    
    if [ ! -f "/etc/arch-release" ]; then
        print_error "This script is designed for Arch Linux only."
        exit 1
    fi
    
    if [ "$EUID" -eq 0 ]; then
        print_error "Do not run this script as root."
        exit 1
    fi
    
    print_success "System verified."
}

# System update function
update_system() {
    print_section "Actualizando sistema..."
    sudo pacman -Sy --noconfirm
    print_success "Database updated."
}

# Minimal Hyprland installation function
install_hyprland_minimal() {
    print_section "Installing minimal Hyprland setup..."
    
    # Only the essentials for Hyprland/Wayland
    local essential_packages=(
        "hyprland"
        "waybar"
        "wofi"
        "mako"
        "swaylock"
        "swayidle"
        "flameshot"
        "wl-clipboard"
        "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk"
        "kitty"
        "fish"
        "neovim"
        "neofetch"
        "fastfetch"
        "bat"
        "fd"
        "ripgrep"
        "fzf"
        "btop"
        "htop"
        "pavucontrol"
        "blueman"
        "networkmanager"
        "network-manager-applet"
        "gdm"
        "exa"
        "starship"
        "zoxide"
        "nerd-fonts-jetbrains-mono"
        "jq"
        "curl"
    )
    
    print_step "Installing essential packages..."
    # Install in parallel for speed
    sudo pacman -S "${essential_packages[@]}" --noconfirm --needed --overwrite="*"
    
    print_success "Minimal Hyprland installed."
}

# Basic AUR helper installation function
install_aur_helper() {
    print_section "Installing AUR helper..."
    
    if command -v yay >/dev/null 2>&1; then
        print_success "yay is already installed."
        return
    fi
    
    print_step "Installing yay..."
    cd /tmp
    git clone --depth 1 https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --skippgpcheck
    cd "$SCRIPT_DIR"
    rm -rf /tmp/yay
    
    print_success "AUR helper installed."
}

# Función para instalar paquetes esenciales
install_essential_packages() {
    print_section "Instalando paquetes esenciales..."
    
    local essential_packages=(
        # Hyprland y componentes
        "hyprland" "waybar" "eww" "swww" "wofi" "mako" "swaylock"
        "swayidle" "grim" "slurp" "wl-clipboard" "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk"
        
        # Terminal y shell
        "kitty" "fish" "starship" "zoxide" "tmux"
        
        # Editores
        "nvim"
        
        # Utilidades del sistema
        "bat" "fd" "ripgrep" "fzf" "btop" "exa" "htop" "ncdu" "iotop" "nvtop"
        "pavucontrol" "blueman" "networkmanager" "network-manager-applet"
        "speedtest-cli" "nmtui" "playerctl" "pamixer" "brightnessctl"
        
        # Herramientas de desarrollo
        "nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk"
        "gcc" "cmake" "ninja" "meson" "valgrind" "gdb"
        "docker" "docker-compose" "podman" "buildah" "skopeo"
        
        # Herramientas adicionales
        "lazygit" "lazydocker" "yazi"
        
        # Reproductores multimedia
        "mpv" "vlc" "cava" "oss" "spotify" "discord" "telegram-desktop"
        "obs" "obs-studio" "krita" "gimp" "inkscape"
        
        # Herramientas de creación multimedia
        "lmms" "pixelorama" "upscayl"
        
        # Portapapeles e historial
        "cliphist" "copyq" "obsidian" "libreoffice" "firefox" "brave"
        "nautilus" "thunar" "geany" "code" "code-marketplace"
        
        # Fuentes y temas
        "nerd-fonts-complete" "noto-fonts" "noto-fonts-emoji" 
        "ttf-dejavu" "ttf-liberation" "ttf-jetbrains-mono"
        "papirus-icon-theme" "bibata-cursor-theme"
        
        # Gaming y desarrollo
        "steam" "lutris" "wine" "gamemode" "mangohud" "heroic-games-launcher"
        "retroarch" "dolphin-emu" "ppsspp" "citra-git"
        
        # Herramientas adicionales
        "jq" "curl" "gdm" "atuin" "just" "httpie" "swappy" "swaylock-effects"
        "hyperlock" "waybar-hyprland" "eww-wayland" "wofi" "mako" "waypaper"
    )
    
    install_packages "${essential_packages[@]}"
    
    print_success "Paquetes esenciales instalados"
}

# Función para configurar Hyprlock
configure_hyprlock() {
    print_section "Configurando Hyprlock..."
    
    print_step "Verificando instalación de hyprlock..."
    if ! command -v hyprlock >/dev/null 2>&1; then
        print_step "Instalando hyprlock..."
        yay -S "hyprlock" --noconfirm --needed
    fi
    
    print_step "Configurando Hyprlock..."
    mkdir -p "$HOME/.config/hyprlock"
    
    # Si existe configuración en dotfiles, copiarla
    if [ -f "$DOTFILES_DIR/hyprlock/hyprlock.conf" ]; then
        print_step "Copiando configuración de hyprlock desde dotfiles..."
        cp "$DOTFILES_DIR/hyprlock/hyprlock.conf" "$HOME/.config/hyprlock/"
        
        # Copiar assets si existen
        if [ -d "$DOTFILES_DIR/hyprlock/assets" ]; then
            cp -r "$DOTFILES_DIR/hyprlock/assets" "$HOME/.config/hyprlock/"
        fi
        
        print_success "Configuración de hyprlock copiada"
    else
        print_warning "No se encontró configuración de hyprlock en dotfiles"
    fi
}

# Función para configurar portapapeles e historial
configure_clipboard() {
    print_section "Configurando portapapeles e historial..."
    
    print_step "Configurando cliphist..."
    mkdir -p "$HOME/.config/cliphist"
    
    # Crear configuración de cliphist
    cat > "$HOME/.config/cliphist/config" << 'EOF'
# Configuración de cliphist
max-entries = 1000
max-size = 1000000
date-format = "%Y-%m-%d %H:%M:%S"
show-date = true
show-size = true
filter-duplicates = true
save-images = true
save-files = true
EOF
    
    print_step "Configurando copyq..."
    mkdir -p "$HOME/.config/copyq"
    
    # Crear configuración básica de copyq
    cat > "$HOME/.config/copyq/copyq.conf" << 'EOF'
[General]
autostart=true
closeOnUnfocus=true
closeOnMouseDown=true
showTrayIcon=true
trayIconCommands=show
maxItems=100
saveImages=true
saveUrls=true
saveFormats=text/plain,text/html,image/png,image/jpeg,image/gif
move=true
viMode=false
checkClipboard=true
monitoring=true
notificationPosition=top-right
notificationMaximumWidth=300
notificationMaximumHeight=200
notificationTimeout=3000
notificationOpacity=0.8
notificationIconSize=24
notificationFontSize=10
notificationFontFamily=AdawitaMono Nerd Font
notificationBackgroundColor=#1e1e2e
notificationTextColor=#cdd6f4
notificationBorderColor=#89b4fa
notificationBorderWidth=1
notificationBorderRadius=8
notificationShadow=true
notificationShadowColor=#000000
notificationShadowBlurRadius=10
notificationShadowOffsetX=0
notificationShadowOffsetY=2
EOF
    
    print_success "Portapapeles e historial configurado"
}

# Función para configurar Waypaper
configure_waypaper() {
    print_section "Configurando Waypaper..."
    
    print_step "Verificando instalación de waypaper..."
    if ! command -v waypaper >/dev/null 2>&1; then
        print_step "Instalando waypaper..."
        yay -S waypaper --noconfirm --needed
    fi
    
    print_step "Creando directorio de configuración..."
    mkdir -p "$HOME/.config/waypaper"
    
    print_step "Creando configuración de waypaper..."
    cat > "$HOME/.config/waypaper/waypaper.json" << 'EOF'
{
    "daemon": {
        "enabled": true,
        "interval": 300
    },
    "wallpaper": {
        "mode": "stretch",
        "output": "all"
    },
    "image": {
        "path": "~/Pictures/wallpapers",
        "sort": "name"
    },
    "hyprland": {
        "enabled": true,
        "method": "hyprctl"
    }
}
EOF
    
    print_step "Configurando directorio de wallpapers..."
    mkdir -p "$HOME/Pictures/wallpapers"
    
    print_step "Configurando inicio automático..."
    mkdir -p "$HOME/.config/autostart"
    
    cat > "$HOME/.config/autostart/waypaper.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=Waypaper
Comment=Waypaper wallpaper daemon
Exec=waypaper --daemon
Terminal=false
X-GNOME-Autostart-enabled=true
EOF
    
    chmod +x "$HOME/.config/autostart/waypaper.desktop"
    
    print_success "Waypaper configurado"
}

# Función para instalar herramientas multimedia
install_multimedia_tools() {
    print_section "Instalando herramientas multimedia..."
    
    print_step "Instalando LMMS (Linux MultiMedia Studio)..."
    sudo pacman -S lmms --noconfirm --needed
    
    print_step "Instalando Pixelorama (Pixel Art)..."
    yay -S pixelorama --noconfirm --needed
    
    print_step "Instalando Upscayl (AI Upscaler)..."
    yay -S upscayl --noconfirm --needed
    
    print_step "Instalando dependencias adicionales para multimedia..."
    sudo pacman -S ffmpeg v4l-utils pulseaudio-alsa --noconfirm --needed
    
    print_success "Herramientas multimedia instaladas"
    print_info "LMMS: Editor de música y audio"
    print_info "Pixelorama: Editor de pixel art"
    print_info "Upscayl: Upscaler de imágenes con IA"
}

# Función para instalar tema GRUB Catppuccin
install_grub_theme() {
    print_section "Instalando tema GRUB Catppuccin..."
    
    print_step "Clonando repositorio Catppuccin GRUB..."
    cd /tmp
    git clone https://github.com/catppuccin/grub.git catppuccin-grub
    cd catppuccin-grub
    
    print_step "Instalando tema GRUB..."
    sudo cp -r src/catppuccin-grub-theme /usr/share/grub/themes/
    
    print_step "Configurando GRUB..."
    # Backup del archivo GRUB actual
    sudo cp /etc/default/grub /etc/default/grub.backup
    
    # Configurar el tema en GRUB
    sudo sed -i 's/GRUB_THEME=.*/GRUB_THEME="\/usr\/share\/grub\/themes\/catppuccin-grub-theme\/theme.txt"/' /etc/default/grub
    
    print_step "Actualizando GRUB..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    print_step "Limpiando archivos temporales..."
    cd "$SCRIPT_DIR"
    rm -rf /tmp/catppuccin-grub
    
    print_success "Tema GRUB Catppuccin instalado"
    print_warning "Reinicia el sistema para ver el nuevo tema GRUB"
}

# Función para instalar NVimX desde GitHub
install_nvimx() {
    print_section "Instalando NVimX desde GitHub"
    
    print_step "Clonando NVimX desde GitHub..."
    if [ -d "$HOME/.config/nvim" ]; then
        print_step "Haciendo backup de la configuración actual de nvim..."
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    if git clone https://github.com/Maurux01/NVimX.git "$HOME/.config/nvim" 2>/dev/null; then
        print_success "NVimX clonado exitosamente"
        
        # Remover directorio .git para evitar conflictos
        rm -rf "$HOME/.config/nvim/.git"
        
        print_step "Instalando plugins de Neovim..."
        nvim --headless -c "Lazy! sync" -c "quit" 2>/dev/null || true
        print_success "Plugins de Neovim instalados"
        
        print_success "NVimX instalado exitosamente"
        print_info "Ahora puedes usar Neovim con tu configuración personalizada"
    else
        print_error "Falló al instalar NVimX"
        print_info "Verifica tu conexión a internet e intenta de nuevo"
    fi
}

# Function to install custom fonts
install_custom_fonts() {
    print_section "Installing custom fonts..."
    
    local fonts_dir="$DOTFILES_DIR/fonts"
    local user_fonts="$HOME/.local/share/fonts"
    local system_fonts="/usr/share/fonts"
    
    # Create user fonts directory if it doesn't exist
    mkdir -p "$user_fonts"
    
    if [ -d "$fonts_dir" ]; then
        print_step "Copying custom fonts..."
        
        # Find font files
        local font_files=($(find "$fonts_dir" -type f \( -iname "*.ttf" -o -iname "*.otf" -o -iname "*.woff" -o -iname "*.woff2" \) 2>/dev/null))
        
        if [ ${#font_files[@]} -gt 0 ]; then
            # Copy fonts to user directory
            cp "${font_files[@]}" "$user_fonts/"
            print_success "Fonts copied to $user_fonts"
            
            # Update font cache
            print_step "Updating font cache..."
            fc-cache -fv
            print_success "Font cache updated"
            
            # Create system fonts directory if possible
            if sudo -n true 2>/dev/null; then
                print_step "Installing fonts in system..."
                sudo mkdir -p "$system_fonts/custom"
                sudo cp "${font_files[@]}" "$system_fonts/custom/"
                sudo fc-cache -fv
                print_success "Fonts installed in system"
            else
                print_warning "Could not install fonts in system (requires sudo)"
            fi
        else
            print_warning "No font files found in $fonts_dir"
        fi
    else
        print_warning "Fonts folder not found in dotfiles."
    fi
}

# Function to copy wallpapers
copy_wallpapers() {
    print_section "Copying wallpapers..."
    
    # Create Pictures directory if it doesn't exist
    local user_pictures="$HOME/Pictures"
    [ -d "$user_pictures" ] || user_pictures="$HOME/Imágenes"
    mkdir -p "$user_pictures"
    
    # Create wallpapers folder inside Pictures
    local wallpapers_dir="$user_pictures/wallpapers"
    mkdir -p "$wallpapers_dir"
    
    if [ -d "$DOTFILES_DIR/wallpapers" ]; then
        print_step "Copying wallpapers to $wallpapers_dir..."
        cp -r "$DOTFILES_DIR/wallpapers"/* "$wallpapers_dir/"
        print_success "Wallpapers copied to $wallpapers_dir"
        
        # Create symbolic link for compatibility
        if [ ! -L "$HOME/.local/share/wallpapers" ]; then
            ln -sf "$wallpapers_dir" "$HOME/.local/share/wallpapers"
            print_success "Symbolic link created at ~/.local/share/wallpapers"
        fi
    else
        print_warning "Wallpapers folder not found in dotfiles."
    fi
}

# Dotfiles copy function
copy_dotfiles() {
    print_section "Copying dotfiles..."
    
    print_step "Creating directories..."
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/share"
    mkdir -p "$HOME/.local/bin"
    
    print_step "Copying configurations..."
    
    # Map folders to their correct paths with specific handling
    declare -A config_paths=(
        ["hypr"]="$HOME/.config/hypr"
        ["kitty"]="$HOME/.config/kitty"
        ["nvim"]="$HOME/.config/nvim"
        ["eww"]="$HOME/.config/eww"
        ["wofi"]="$HOME/.config/wofi"
        ["mako"]="$HOME/.config/mako"
        ["swww"]="$HOME/.config/swww"
        ["fish"]="$HOME/.config/fish"
        ["tmux"]="$HOME/.tmux.conf"
        ["neofetch"]="$HOME/.config/neofetch"
        ["sddm"]="/etc/sddm.conf.d"
        ["grub-themes"]="/usr/share/grub/themes"
    )
    
    # Copy each folder to its correct location
    for item in "$DOTFILES_DIR"/*; do
        if [ -d "$item" ]; then
            local dirname=$(basename "$item")
            local target_path="${config_paths[$dirname]}"
            
            if [ -n "$target_path" ]; then
                print_step "Copying $dirname to $target_path..."
                mkdir -p "$(dirname "$target_path")"
                
                # Special handling for different types of configs
                case "$dirname" in
                    "nvim")
                        # Clone NVimX from GitHub repository
                        print_step "Cloning NVimX from GitHub..."
                        if [ -d "$HOME/.config/nvim" ]; then
                            print_step "Backing up existing nvim config..."
                            mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
                        fi
                        
                        # Clone the repository
                        if git clone https://github.com/Maurux01/NVimX.git "$HOME/.config/nvim" 2>/dev/null; then
                            print_success "NVimX cloned successfully"
                            
                            # Remove .git directory to avoid conflicts
                            rm -rf "$HOME/.config/nvim/.git"
                            
                            # Install plugins
                            print_step "Installing Neovim plugins..."
                            nvim --headless -c "Lazy! sync" -c "quit" 2>/dev/null || true
                            print_success "Neovim plugins installed"
                        else
                            print_error "Failed to clone NVimX, using local config as fallback"
                            cp -r "$item" "$HOME/.config/nvim"
                            print_success "Local Neovim config copied as fallback"
                        fi
                        ;;
                    "sddm")
                        # Copy SDDM config to system location
                        print_step "Copying SDDM configuration..."
                        sudo cp "$item"/* "$target_path/" 2>/dev/null || true
                        print_success "SDDM config copied"
                        ;;
                    "grub-themes")
                        # Skip grub themes as they're handled separately
                        print_step "Skipping grub-themes (handled by install_grub_theme function)"
                        ;;
                    "tmux")
                        # Copy tmux config and create tmux directory in home
                        print_step "Copying Tmux configuration..."
                        if [ -f "$item/.tmux.conf" ]; then
                            # Copy tmux.conf to home directory
                            cp "$item/.tmux.conf" "$HOME/.tmux.conf"
                            print_success "Tmux config copied to $HOME/.tmux.conf"
                            
                            # Create tmux directory in home for plugins
                            mkdir -p "$HOME/.tmux"
                            
                            # Install Catppuccin tmux plugin
                            print_step "Installing Catppuccin tmux plugin..."
                            mkdir -p ~/.config/tmux/plugins/catppuccin
                            if git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux 2>/dev/null; then
                                print_success "Catppuccin tmux plugin installed"
                            else
                                print_warning "Failed to install Catppuccin tmux plugin"
                            fi
                        else
                            print_error "Tmux config file not found"
                        fi
                        ;;
                    *)
                        # Standard copy for other configs
                        if [[ "$target_path" == /etc/* ]]; then
                            # System configs need sudo
                            sudo cp -r "$item"/* "$target_path/" 2>/dev/null || sudo cp -r "$item" "$(dirname "$target_path")/"
                        else
                            # User configs
                            cp -r "$item"/* "$target_path/" 2>/dev/null || cp -r "$item" "$(dirname "$target_path")/"
                        fi
                        print_success "$dirname copied to $target_path"
                        ;;
                esac
            else
                print_step "Copying $dirname to ~/.config/$dirname..."
                cp -r "$item" "$HOME/.config/"
                print_success "$dirname copied to ~/.config/$dirname"
            fi
        fi
    done
    
    # Make scripts executable
    print_step "Making scripts executable..."
    find "$HOME/.config" -name "*.sh" -type f -exec chmod +x {} \; 2>/dev/null || true
    
    # Copy scripts to proper location
    if [ -d "$DOTFILES_DIR/scripts" ]; then
        print_step "Copying scripts..."
        mkdir -p "$HOME/.config/scripts"
        cp "$DOTFILES_DIR/scripts"/*.sh "$HOME/.config/scripts/"
        chmod +x "$HOME/.config/scripts"/*.sh
        print_success "Scripts copied to ~/.config/scripts/"
    fi
    
    # Copy specific configuration files with proper handling
    if [ -f "$DOTFILES_DIR/fish/config.fish" ]; then
        print_step "Copying Fish configuration..."
        mkdir -p "$HOME/.config/fish"
        cp "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/"
        print_success "Fish config copied"
    fi
    
    if [ -f "$DOTFILES_DIR/neofetch/neofetch.conf" ]; then
        print_step "Copying Neofetch configuration..."
        mkdir -p "$HOME/.config/neofetch"
        cp "$DOTFILES_DIR/neofetch/neofetch.conf" "$HOME/.config/neofetch/"
        print_success "Neofetch config copied"
    fi
    
    if [ -f "$DOTFILES_DIR/neofetch/fastfetch.jsonc" ]; then
        print_step "Copying Fastfetch configuration..."
        cp "$DOTFILES_DIR/neofetch/fastfetch.jsonc" "$HOME/.config/"
        print_success "Fastfetch config copied"
    fi
    
    # Copy SDDM configuration files
    if [ -d "$DOTFILES_DIR/sddm" ]; then
        print_step "Copying SDDM configuration..."
        sudo mkdir -p /etc/sddm.conf.d
        sudo cp "$DOTFILES_DIR/sddm"/* /etc/sddm.conf.d/ 2>/dev/null || true
        print_success "SDDM config copied"
    fi
    
    # Copy hyprlock configuration
    if [ -f "$DOTFILES_DIR/hyprlock/hyprlock.conf" ]; then
        print_step "Copying Hyprlock configuration..."
        mkdir -p "$HOME/.config/hyprlock"
        cp "$DOTFILES_DIR/hyprlock/hyprlock.conf" "$HOME/.config/hyprlock/"
        print_success "Hyprlock config copied"
    fi
    
    print_success "All dotfiles copied successfully."
}

# Verification function
verify_installation() {
    print_section "Verificando instalación..."
    
    local errors=0
    
    # Check essential directories
    local essential_dirs=(
        "$HOME/.config/hypr"
        "$HOME/.config/kitty"
        "$HOME/.config/fish"
        "$HOME/.config/nvim"
        "$HOME/.config/eww"
        "$HOME/.config/wofi"
        "$HOME/.config/mako"
        "$HOME/.config/swww"
    )
    
    for dir in "${essential_dirs[@]}"; do
        if [ -d "$dir" ]; then
            print_success "✓ $dir exists"
        else
            print_error "✗ $dir missing"
            ((errors++))
        fi
    done
    
    # Check essential files
    local essential_files=(
        "$HOME/.config/hypr/hyprland.conf"
        "$HOME/.config/fish/config.fish"
        "$HOME/.config/kitty/kitty.conf"
    )
    
    for file in "${essential_files[@]}"; do
        if [ -f "$file" ]; then
            print_success "✓ $file exists"
        else
            print_error "✗ $file missing"
            ((errors++))
        fi
    done
    
    # Check if fish is default shell
    if [ "$SHELL" = "/usr/bin/fish" ]; then
        print_success "✓ Fish is default shell"
    else
        print_warning "⚠ Fish is not default shell (current: $SHELL)"
    fi
    
    if [ $errors -eq 0 ]; then
        print_success "All essential components verified successfully"
    else
        print_error "Found $errors error(s) in installation"
    fi
}

# Fish shell configuration function
configure_fish_shell() {
    print_section "Configuring Fish shell..."
    
    print_step "Setting Fish as default shell..."
    # Add fish to /etc/shells if not already there
    if ! grep -q "/usr/bin/fish" /etc/shells; then
        echo "/usr/bin/fish" | sudo tee -a /etc/shells
    fi
    
    # Change default shell to fish
    sudo chsh -s /usr/bin/fish "$USER"
    print_success "Fish shell set as default"
    
    print_step "Configuring Fish environment..."
    # Create fish config directory if it doesn't exist
    mkdir -p "$HOME/.config/fish"
    
    # Ensure fish config is properly set up
    if [ -f "$HOME/.config/fish/config.fish" ]; then
        print_success "Fish configuration found"
    else
        print_warning "Fish configuration not found, creating basic config"
        cat > "$HOME/.config/fish/config.fish" << 'EOF'
# Fish shell configuration
set -g fish_greeting ""

# Add local bin to PATH
set -gx PATH $HOME/.local/bin $PATH

# Source starship if available
if command -q starship
    starship init fish | source
end

# Source zoxide if available
if command -q zoxide
    zoxide init fish | source
end
EOF
    fi
    
    print_success "Fish shell configured"
}

# Basic system configuration function
configure_system() {
    print_section "Configuring system..."
    
    print_step "Configuring permissions and services..."
    # Do everything in parallel for speed
    sudo usermod -aG wheel "$USER" &
    sudo systemctl enable NetworkManager bluetooth gdm &
    wait
    
    print_step "Configuring GDM for Hyprland..."
    # Create Hyprland configuration file for GDM
    sudo mkdir -p /usr/share/wayland-sessions
    sudo tee /usr/share/wayland-sessions/hyprland.desktop > /dev/null << 'EOF'
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
    
    print_success "System configured."
}

# Final information display function
show_final_info() {
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}║                    INSTALLATION COMPLETED                                   ║${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo "Next steps:"
    echo "1. Reboot your system"
    echo "2. Log in with Hyprland"
    echo ""
    
    echo "Basic commands:"
    echo "• SUPER+N - Neovim (Default editor)"
    echo "• SUPER+B - Browser (Brave)"
    echo "• SUPER+D - Application launcher"
    echo "• SUPER+RETURN - Terminal"
    echo "• SUPER+Q - Close window"
    echo "• SUPER+SHIFT+W - Random wallpaper"
    echo ""
    
    echo "Font management:"
    echo "• Place custom fonts in dotfiles/fonts/"
    echo "• Run ~/.config/scripts/change-font.sh to change fonts"
    echo "• Use ~/.config/scripts/change-font.sh --list to see options"
    echo ""
    
    echo "Multimedia tools installed:"
    echo "• LMMS - Linux MultiMedia Studio (music production)"
    echo "• Pixelorama - Pixel art editor"
    echo "• Upscayl - AI image upscaler"
    echo ""
    
    echo "To install more applications:"
    echo "• sudo pacman -S [package]"
    echo "• yay -S [aur-package]"
    echo ""
}

# Main function
main() {
    print_header
    check_system
    update_system
    install_aur_helper
    install_essential_packages
    install_multimedia_tools
    install_custom_fonts
    copy_wallpapers
    configure_hyprlock
    configure_clipboard
    configure_waypaper
    install_grub_theme
    copy_dotfiles
    configure_fish_shell
    configure_system
    verify_installation
    show_final_info
}

# Execute main function
main "$@" 
