#!/bin/bash

# Script de instalación simplificado para Hyprland
# Solo instala lo mínimo necesario

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variables globales
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

# Función para logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    Archriced - Simple                       ║${NC}"
    echo -e "${BLUE}║                  by maurux01                                ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo -e "${CYAN}▸ $1${NC}"
    log "SECCIÓN: $1"
}

print_step() {
    echo -e "${YELLOW}  → $1${NC}"
    log "PASO: $1"
}

print_success() {
    echo -e "${GREEN}  ✓ $1${NC}"
    log "ÉXITO: $1"
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
        if [[ "$pkg" == "heroic-games-launcher" || "$pkg" == "hyperlock" ]]; then
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
    print_section "Verificando sistema..."
    
    if [ ! -f "/etc/arch-release" ]; then
        print_error "Este script está diseñado para Arch Linux"
        exit 1
    fi
    
    if [ "$EUID" -eq 0 ]; then
        print_error "No ejecutes este script como root"
        exit 1
    fi
    
    print_success "Sistema verificado"
}

# Función para actualizar sistema
update_system() {
    print_section "Actualizando sistema..."
    # Solo actualizar base de datos, no todo el sistema
    sudo pacman -Sy --noconfirm
    print_success "Base de datos actualizada"
}

# Función para instalar Hyprland mínimo
install_hyprland_minimal() {
    print_section "Instalando Hyprland mínimo..."
    
    # Solo lo esencial para Hyprland/Wayland
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
    
    print_step "Instalando paquetes esenciales..."
    # Instalar en paralelo para mayor velocidad
    sudo pacman -S "${essential_packages[@]}" --noconfirm --needed --overwrite="*"
    
    print_success "Hyprland mínimo instalado"
}

# Función para instalar AUR helper básico
install_aur_helper() {
    print_section "Instalando AUR helper..."
    
    if command -v yay >/dev/null 2>&1; then
        print_success "yay ya está instalado"
        return
    fi
    
    print_step "Instalando yay..."
    cd /tmp
    git clone --depth 1 https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --skippgpcheck
    cd "$SCRIPT_DIR"
    rm -rf /tmp/yay
    
    print_success "AUR helper instalado"
}

# Función para instalar Hyprland y componentes
install_hyprland() {
    print_section "Instalando Hyprland y componentes..."
    
    local hyprland_packages=(
        "hyprland" "waybar" "eww" "swww" "wofi" "mako" "swaylock"
        "swayidle" "grim" "slurp" "wl-clipboard" "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk" "kitty" "neovim" "fish" "starship"
    )
    
    install_packages "${hyprland_packages[@]}"
    print_success "Hyprland y componentes instalados"
}

# Función para instalar utilidades del sistema
# NOTA: Usamos Fish shell en lugar de zsh para mejor integración con Wayland
install_system_utils() {
    print_section "Instalando utilidades del sistema..."
    
    local util_packages=(
        "bat" "fd" "ripgrep" "fzf" "lazygit" "yazi" "btop" "htop"
        "neofetch" "fastfetch" "cava" "pavucontrol" "blueman"
        "networkmanager" "network-manager-applet" "mpv" "vlc"
        "steam" "lutris" "wine" "gamemode" "mangohud"
        "cliphist" "copyq" "heroic-games-launcher"
    )
    
    install_packages "${util_packages[@]}"
    print_success "Utilidades del sistema instaladas"
}

# Función para instalar desarrollo
install_development() {
    print_section "Instalando herramientas de desarrollo..."
    
    local dev_packages=(
        "nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk"
        "gcc" "cmake" "ninja" "meson" "valgrind" "gdb" "code-oss"
    )
    
    install_packages "${dev_packages[@]}"
    print_success "Herramientas de desarrollo instaladas"
}

# Función para instalar fuentes y temas
install_fonts_themes() {
    print_section "Instalando fuentes y temas..."
    
    local font_packages=(
        "nerd-fonts-jetbrains-mono" "nerd-fonts-fira-code" "noto-fonts"
        "noto-fonts-emoji" "ttf-dejavu" "ttf-liberation"
    )
    
    local theme_packages=(
        "catppuccin-gtk-theme" "papirus-icon-theme" "bibata-cursor-theme"
        "adwaita-icon-theme" "gnome-themes-extra"
    )
    
    install_packages "${font_packages[@]}" "${theme_packages[@]}"
    print_success "Fuentes y temas instalados"
}

# Función para instalar todas las Nerd Fonts disponibles
install_all_nerdfonts() {
    print_section "Instalando todas las Nerd Fonts..."
    local fonts=(
        nerd-fonts-complete nerd-fonts-fira-code nerd-fonts-hack nerd-fonts-jetbrains-mono nerd-fonts-meslo nerd-fonts-ubuntu nerd-fonts-dejavu-sans-mono nerd-fonts-iosevka nerd-fonts-cascadia-code nerd-fonts-mononoki nerd-fonts-source-code-pro nerd-fonts-terminus nerd-fonts-victor-mono nerd-fonts-agave nerd-fonts-anonymice-pro nerd-fonts-arimo nerd-fonts-bigblue-terminal nerd-fonts-bitstream-vera-sans-mono nerd-fonts-cousine nerd-fonts-daddy-time-mono nerd-fonts-fantasque-sans-mono nerd-fonts-go-mono nerd-fonts-inconsolata nerd-fonts-lekton nerd-fonts-liberation-mono nerd-fonts-noto nerd-fonts-profont nerd-fonts-roboto-mono nerd-fonts-shure-tech-mono nerd-fonts-space-mono nerd-fonts-tinos nerd-fonts-ubuntu-mono
    )
    install_packages "${fonts[@]}"
    print_success "Todas las Nerd Fonts instaladas."
}

# Función para configurar Hyperlock
configure_hyperlock() {
    print_section "Configurando Hyperlock..."
    
    install_packages "hyperlock"
    
    print_step "Configurando Hyperlock..."
    mkdir -p "$HOME/.config/hyperlock"
    
    # Crear configuración básica de Hyperlock
    cat > "$HOME/.config/hyperlock/config.toml" << 'EOF'
# Configuración de Hyperlock
[general]
idle_timeout = 300
show_indicator = true
indicator_position = "top"
indicator_color = "#89b4fa"
indicator_size = 2
show_datetime = true
datetime_format = "%H:%M"
datetime_position = "center"
datetime_color = "#cdd6f4"
datetime_font_size = 24
show_background = true
background_blur = 10
background_opacity = 0.8
show_lock_message = true
lock_message = "Pantalla bloqueada"
lock_message_color = "#cdd6f4"
lock_message_font_size = 16
lock_message_position = "bottom"
play_sound = false
show_battery = true
show_network = true
show_volume = true

[colors]
background = "#1e1e2e"
surface = "#313244"
primary = "#89b4fa"
secondary = "#f5c2e7"
accent = "#f38ba8"
text = "#cdd6f4"
text_secondary = "#a6adc8"
error = "#f38ba8"
success = "#a6e3a1"
warning = "#f9e2af"
EOF
    
    print_success "Hyperlock configurado"
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
notificationFontFamily=JetBrains Mono
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

# Función para copiar dotfiles con ubicaciones correctas del sistema
copy_dotfiles() {
    print_section "Copiando dotfiles a ubicaciones correctas del sistema..."
    
    print_step "Creando directorios del sistema..."
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/share"
    mkdir -p "$HOME/.local/bin"
    mkdir -p "$HOME/.cache"
    
    print_step "Definiendo mapeo de carpetas a ubicaciones correctas..."
    
    # Mapeo completo de carpetas a sus rutas correctas del sistema
    declare -A config_paths=(
        # Configuraciones principales
        ["hypr"]="$HOME/.config/hypr"
        ["waybar"]="$HOME/.config/waybar"
        ["kitty"]="$HOME/.config/kitty"
        ["nvim"]="$HOME/.config/nvim"
        ["eww"]="$HOME/.config/eww"
        ["wofi"]="$HOME/.config/wofi"
        ["mako"]="$HOME/.config/mako"
        ["swww"]="$HOME/.config/swww"
        ["fish"]="$HOME/.config/fish"
        ["tmux"]="$HOME/.config/tmux"
        ["neofetch"]="$HOME/.config/neofetch"
        
        # Datos del usuario
        ["wallpapers"]="$HOME/.local/share/wallpapers"
        ["scripts"]="$HOME/.config/scripts"
        
        # Configuraciones específicas
        ["grub-themes"]="/boot/grub/themes"
        ["grub"]="/etc/default"
    )
    
    print_step "Copiando configuraciones a ubicaciones correctas..."
    
    # Copiar cada carpeta a su ubicación correcta del sistema
    for item in "$DOTFILES_DIR"/*; do
        if [ -d "$item" ]; then
            local dirname=$(basename "$item")
            local target_path="${config_paths[$dirname]}"
            
            if [ -n "$target_path" ]; then
                print_step "Copiando $dirname a $target_path..."
                
                # Crear directorio de destino si no existe
                mkdir -p "$(dirname "$target_path")"
                
                # Copiar contenido preservando estructura
                if [ "$dirname" = "grub-themes" ]; then
                    # Caso especial para temas de GRUB (requiere sudo)
                    sudo mkdir -p "$target_path"
                    sudo cp -r "$item"/* "$target_path/" 2>/dev/null || true
                elif [ "$dirname" = "grub" ]; then
                    # Caso especial para configuración de GRUB
                    sudo cp "$item"/* "$target_path/" 2>/dev/null || true
                else
                    # Caso normal para configuraciones de usuario
                    cp -r "$item"/* "$target_path/" 2>/dev/null || cp -r "$item" "$(dirname "$target_path")/"
                fi
            else
                print_step "Copiando $dirname a ~/.config/$dirname..."
                cp -r "$item" "$HOME/.config/"
            fi
        fi
    done
    
    # Configurar permisos y hacer scripts ejecutables
    print_step "Configurando permisos y scripts ejecutables..."
    
    # Scripts de Waybar
    if [ -d "$HOME/.config/waybar/scripts" ]; then
        chmod +x "$HOME/.config/waybar/scripts"/*.sh 2>/dev/null || true
    fi
    
    # Scripts generales
    if [ -d "$HOME/.config/scripts" ]; then
        chmod +x "$HOME/.config/scripts"/*.sh 2>/dev/null || true
    fi
    
    # Scripts de EWW
    if [ -d "$HOME/.config/eww/scripts" ]; then
        chmod +x "$HOME/.config/eww/scripts"/*.sh 2>/dev/null || true
    fi
    
    # Scripts de TMUX
    if [ -d "$HOME/.config/tmux/scripts" ]; then
        chmod +x "$HOME/.config/tmux/scripts"/*.sh 2>/dev/null || true
    fi
    
    # Copiar scripts específicos a ubicaciones del sistema
    print_step "Copiando scripts específicos..."
    
    # Script de wallpaper aleatorio
    if [ -f "$DOTFILES_DIR/scripts/random-wallpaper.sh" ]; then
        mkdir -p "$HOME/.local/bin"
        cp "$DOTFILES_DIR/scripts/random-wallpaper.sh" "$HOME/.local/bin/"
        chmod +x "$HOME/.local/bin/random-wallpaper.sh"
    fi
    
    # Scripts de utilidades
    if [ -d "$DOTFILES_DIR/scripts" ]; then
        mkdir -p "$HOME/.local/bin"
        for script in "$DOTFILES_DIR/scripts"/*.sh; do
            if [ -f "$script" ]; then
                local script_name=$(basename "$script")
                cp "$script" "$HOME/.local/bin/"
                chmod +x "$HOME/.local/bin/$script_name"
            fi
        done
    fi
    
    # Configurar Neovim específicamente
    print_step "Configurando Neovim..."
    if [ -d "$HOME/.config/nvim" ]; then
        # Crear directorios necesarios para Neovim
        mkdir -p "$HOME/.config/nvim/lua"
        mkdir -p "$HOME/.config/nvim/after"
        mkdir -p "$HOME/.cache/nvim"
        
        # Asegurar que los plugins se instalen correctamente
        if [ -f "$HOME/.config/nvim/init.lua" ]; then
            print_step "Neovim configurado en ~/.config/nvim"
        fi
    fi
    
    # Configurar Fish específicamente
    print_step "Configurando Fish shell..."
    if [ -d "$HOME/.config/fish" ]; then
        # Crear directorios necesarios para Fish
        mkdir -p "$HOME/.config/fish/functions"
        mkdir -p "$HOME/.config/fish/completions"
        mkdir -p "$HOME/.config/fish/conf.d"
        
        # Asegurar que la configuración esté en el lugar correcto
        if [ -f "$HOME/.config/fish/config.fish" ]; then
            print_step "Fish configurado en ~/.config/fish"
        fi
    fi
    
    # Configurar Kitty específicamente
    print_step "Configurando Kitty terminal..."
    if [ -d "$HOME/.config/kitty" ]; then
        # Crear directorios necesarios para Kitty
        mkdir -p "$HOME/.config/kitty/themes"
        
        # Asegurar que la configuración esté en el lugar correcto
        if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
            print_step "Kitty configurado en ~/.config/kitty"
        fi
    fi
    
    # Configurar Hyprland específicamente
    print_step "Configurando Hyprland..."
    if [ -d "$HOME/.config/hypr" ]; then
        # Asegurar que la configuración esté en el lugar correcto
        if [ -f "$HOME/.config/hypr/hyprland.conf" ]; then
            print_step "Hyprland configurado en ~/.config/hypr"
        fi
    fi
    
    # Configurar Waybar específicamente
    print_step "Configurando Waybar..."
    if [ -d "$HOME/.config/waybar" ]; then
        # Asegurar que la configuración esté en el lugar correcto
        if [ -f "$HOME/.config/waybar/config" ]; then
            print_step "Waybar configurado en ~/.config/waybar"
        fi
    fi
    
    # Configurar EWW específicamente
    print_step "Configurando EWW widgets..."
    if [ -d "$HOME/.config/eww" ]; then
        # Crear directorios necesarios para EWW
        mkdir -p "$HOME/.config/eww/scripts"
        
        # Asegurar que la configuración esté en el lugar correcto
        if [ -f "$HOME/.config/eww/eww.yuck" ]; then
            print_step "EWW configurado en ~/.config/eww"
        fi
    fi
    
    # Configurar Wofi específicamente
    print_step "Configurando Wofi..."
    if [ -d "$HOME/.config/wofi" ]; then
        # Asegurar que la configuración esté en el lugar correcto
        if [ -f "$HOME/.config/wofi/config" ]; then
            print_step "Wofi configurado en ~/.config/wofi"
        fi
    fi
    
    # Configurar Mako específicamente
    print_step "Configurando Mako notifications..."
    if [ -d "$HOME/.config/mako" ]; then
        # Asegurar que la configuración esté en el lugar correcto
        if [ -f "$HOME/.config/mako/config" ]; then
            print_step "Mako configurado en ~/.config/mako"
        fi
    fi
    
    # Configurar SWWW específicamente
    print_step "Configurando SWWW wallpaper..."
    if [ -d "$HOME/.config/swww" ]; then
        # Asegurar que la configuración esté en el lugar correcto
        print_step "SWWW configurado en ~/.config/swww"
    fi
    
    # Configurar TMUX específicamente
    print_step "Configurando TMUX..."
    if [ -d "$HOME/.config/tmux" ]; then
        # Crear directorios necesarios para TMUX
        mkdir -p "$HOME/.config/tmux/scripts"
        
        # Asegurar que la configuración esté en el lugar correcto
        if [ -d "$HOME/.config/tmux" ]; then
            print_step "TMUX configurado en ~/.config/tmux"
        fi
    fi
    
    # Configurar Neofetch específicamente
    print_step "Configurando Neofetch..."
    if [ -d "$HOME/.config/neofetch" ]; then
        # Asegurar que la configuración esté en el lugar correcto
        if [ -f "$HOME/.config/neofetch/neofetch.conf" ]; then
            print_step "Neofetch configurado en ~/.config/neofetch"
        fi
    fi
    
    # Configurar Fastfetch
    if [ -f "$HOME/.config/fastfetch.jsonc" ]; then
        print_step "Fastfetch configurado en ~/.config/fastfetch.jsonc"
    fi
    
    print_success "Todos los dotfiles copiados a ubicaciones correctas del sistema"
}

# Función para verificar instalación correcta
verify_installation() {
    print_section "Verificando instalación en ubicaciones correctas..."
    
    local errors=0
    local warnings=0
    
    print_step "Verificando configuraciones principales..."
    
    # Verificar configuraciones principales
    local configs=(
        "~/.config/hypr/hyprland.conf"
        "~/.config/waybar/config"
        "~/.config/kitty/kitty.conf"
        "~/.config/nvim/init.lua"
        "~/.config/eww/eww.yuck"
        "~/.config/wofi/config"
        "~/.config/mako/config"
        "~/.config/fish/config.fish"
        "~/.config/neofetch/neofetch.conf"
    )
    
    for config in "${configs[@]}"; do
        local expanded_path=$(eval echo "$config")
        if [ -f "$expanded_path" ]; then
            print_success "✓ $(basename "$config") instalado correctamente"
        else
            print_error "✗ $(basename "$config") NO encontrado en $expanded_path"
            ((errors++))
        fi
    done
    
    print_step "Verificando directorios del sistema..."
    
    # Verificar directorios del sistema
    local dirs=(
        "~/.config/hypr"
        "~/.config/waybar"
        "~/.config/kitty"
        "~/.config/nvim"
        "~/.config/eww"
        "~/.config/wofi"
        "~/.config/mako"
        "~/.config/swww"
        "~/.config/fish"
        "~/.config/tmux"
        "~/.config/neofetch"
        "~/.config/scripts"
        "~/.local/share/wallpapers"
        "~/.local/bin"
    )
    
    for dir in "${dirs[@]}"; do
        local expanded_dir=$(eval echo "$dir")
        if [ -d "$expanded_dir" ]; then
            print_success "✓ $(basename "$dir") creado correctamente"
        else
            print_warning "⚠ $(basename "$dir") NO encontrado en $expanded_dir"
            ((warnings++))
        fi
    done
    
    print_step "Verificando scripts ejecutables..."
    
    # Verificar scripts ejecutables
    if [ -d "$HOME/.local/bin" ]; then
        local script_count=$(find "$HOME/.local/bin" -name "*.sh" -executable 2>/dev/null | wc -l)
        if [ "$script_count" -gt 0 ]; then
            print_success "✓ $script_count scripts ejecutables instalados en ~/.local/bin"
        else
            print_warning "⚠ No se encontraron scripts ejecutables en ~/.local/bin"
            ((warnings++))
        fi
    fi
    
    print_step "Verificando permisos de scripts..."
    
    # Verificar permisos de scripts en diferentes ubicaciones
    local script_dirs=(
        "~/.config/waybar/scripts"
        "~/.config/eww/scripts"
        "~/.config/tmux/scripts"
        "~/.config/scripts"
    )
    
    for script_dir in "${script_dirs[@]}"; do
        local expanded_script_dir=$(eval echo "$script_dir")
        if [ -d "$expanded_script_dir" ]; then
            local executable_scripts=$(find "$expanded_script_dir" -name "*.sh" -executable 2>/dev/null | wc -l)
            local total_scripts=$(find "$expanded_script_dir" -name "*.sh" 2>/dev/null | wc -l)
            if [ "$executable_scripts" -eq "$total_scripts" ] && [ "$total_scripts" -gt 0 ]; then
                print_success "✓ Scripts en $(basename "$script_dir") con permisos correctos"
            elif [ "$total_scripts" -gt 0 ]; then
                print_warning "⚠ Algunos scripts en $(basename "$script_dir") sin permisos de ejecución"
                ((warnings++))
            fi
        fi
    done
    
    # Resumen final
    echo ""
    if [ "$errors" -eq 0 ] && [ "$warnings" -eq 0 ]; then
        print_success "✅ Instalación verificada completamente - Todo instalado correctamente"
    elif [ "$errors" -eq 0 ]; then
        print_warning "⚠ Instalación verificada con $warnings advertencias menores"
    else
        print_error "❌ Instalación verificada con $errors errores y $warnings advertencias"
    fi
    
    echo ""
    print_info "Ubicaciones principales de configuración:"
    echo "  • Hyprland: ~/.config/hypr/"
    echo "  • Neovim: ~/.config/nvim/"
    echo "  • Fish: ~/.config/fish/"
    echo "  • Kitty: ~/.config/kitty/"
    echo "  • Waybar: ~/.config/waybar/"
    echo "  • EWW: ~/.config/eww/"
    echo "  • Scripts: ~/.local/bin/"
    echo "  • Wallpapers: ~/.local/share/wallpapers/"
    echo ""
}

# Función para copiar wallpapers a la carpeta de imágenes del usuario
copy_wallpapers() {
    print_section "Copiando wallpapers a la carpeta de imágenes del usuario..."
    local user_pictures="$HOME/Pictures"
    [ -d "$user_pictures" ] || user_pictures="$HOME/Imágenes"
    mkdir -p "$user_pictures"
    if [ -d "$DOTFILES_DIR/wallpapers" ]; then
        cp -r "$DOTFILES_DIR/wallpapers"/* "$user_pictures/"
        print_success "Wallpapers copiados a $user_pictures"
    else
        print_warning "No se encontró la carpeta de wallpapers en dotfiles."
    fi
}

# Función para configurar sistema básico
configure_system() {
    print_section "Configurando sistema..."
    
    print_step "Configurando permisos y servicios..."
    # Hacer todo en paralelo para mayor velocidad
    # NOTA: Configuramos Fish como shell por defecto (no zsh)
    sudo usermod -aG wheel "$USER" &
    sudo systemctl enable NetworkManager bluetooth gdm &
    sudo chsh -s /usr/bin/fish "$USER" &
    wait
    
    print_step "Configurando GDM para Hyprland..."
    # Crear archivo de configuración para Hyprland en GDM
    sudo mkdir -p /usr/share/wayland-sessions
    sudo tee /usr/share/wayland-sessions/hyprland.desktop > /dev/null << 'EOF'
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
    
    print_success "Sistema configurado"
}

# Función para instalar tema Catppuccin de GRUB2
install_grub_theme() {
    print_section "Instalando tema Catppuccin para GRUB2..."
    local grub_theme_repo="https://github.com/vinceliuice/grub2-themes.git"
    local tmp_dir="/tmp/grub2-themes"
    local theme_name="catppuccin"
    
    print_step "Clonando repositorio de temas..."
    git clone --depth=1 "$grub_theme_repo" "$tmp_dir"
    
    print_step "Copiando tema Catppuccin a /boot/grub/themes..."
    sudo mkdir -p /boot/grub/themes
    sudo cp -r "$tmp_dir/themes/$theme_name" /boot/grub/themes/
    
    print_step "Configurando GRUB para usar el tema..."
    if grep -q '^GRUB_THEME=' /etc/default/grub; then
        sudo sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/catppuccin/theme.txt"|' /etc/default/grub
    else
        echo 'GRUB_THEME="/boot/grub/themes/catppuccin/theme.txt"' | sudo tee -a /etc/default/grub
    fi
    
    print_step "Actualizando configuración de GRUB..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    print_success "Tema Catppuccin para GRUB2 instalado"
}

# Función para mostrar información final
show_final_info() {
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo "✅ Todo instalado en ubicaciones correctas del sistema:"
    echo ""
    echo "📁 Ubicaciones principales:"
    echo "  • Hyprland: ~/.config/hypr/"
    echo "  • Neovim: ~/.config/nvim/"
    echo "  • Fish: ~/.config/fish/"
    echo "  • Kitty: ~/.config/kitty/"
    echo "  • Waybar: ~/.config/waybar/"
    echo "  • EWW: ~/.config/eww/"
    echo "  • Scripts: ~/.local/bin/"
    echo "  • Wallpapers: ~/.local/share/wallpapers/"
    echo ""
    
    echo "🚀 Próximos pasos:"
    echo "1. Reinicia tu sistema"
    echo "2. Inicia sesión con Hyprland"
    echo ""
    
    echo "⌨️  Comandos básicos:"
    echo "• SUPER+Return - Terminal principal"
    echo "• SUPER+T - Terminal flotante"
    echo "• SUPER+N - Neovim en terminal"
    echo "• SUPER+V - VS Code"
    echo "• SUPER+X - Monitor de procesos (htop)"
    echo "• SUPER+B - Browser (Firefox)"
    echo "• SUPER+D - Lanzador de aplicaciones"
    echo "• SUPER+Q - Cerrar ventana"
    echo "• SUPER+SHIFT+W - Wallpaper aleatorio"
    echo ""
    
    echo "🛠️  Herramientas de desarrollo:"
    echo "• SUPER+SHIFT+V - Git GUI (LazyGit)"
    echo "• SUPER+SHIFT+N - File manager TUI (Yazi)"
    echo "• SUPER+CTRL+N - Monitor de sistema (btop)"
    echo "• SUPER+SHIFT+X - Editar configuración Hyprland"
    echo ""
    
    echo "📦 Para instalar más aplicaciones:"
    echo "• sudo pacman -S [paquete]"
    echo "• yay -S [paquete-aur]"
    echo ""
    
    echo "🔧 Para editar configuraciones:"
    echo "• nvim ~/.config/hypr/hyprland.conf"
    echo "• nvim ~/.config/nvim/init.lua"
    echo "• nvim ~/.config/fish/config.fish"
    echo "• nvim ~/.config/kitty/kitty.conf"
    echo ""
}

# Función principal
main() {
    print_header
    check_system
    update_system
    install_hyprland_minimal
    install_aur_helper
    install_hyprland
    install_system_utils
    install_development
    install_all_nerdfonts
    install_fonts_themes
    copy_wallpapers
    configure_hyperlock
    configure_clipboard
    copy_dotfiles
    configure_system
    install_grub_theme
    verify_installation
    show_final_info
}

# Ejecutar función principal
main "$@"