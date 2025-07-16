#!/bin/bash

# =============================================================================
#                           🚀 ARCH DOTS INSTALLER
# =============================================================================
# Script de instalación unificado y modular para Arch Linux
# Incluye: Hyprland, Neovim, herramientas multimedia, soporte de imágenes
# =============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Variables globales
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
BACKUP_DIR="$HOME/.archriced-backup-$(date +%Y%m%d-%H%M%S)"
LOG_FILE="$HOME/.archriced-install.log"

# Función para logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

print_header() {
    echo -e "${BLUE} ═════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                    🚀 ARCH DOTS INSTALLER                   ║${NC}"
    echo -e "${BLUE}║                    by maurux01                              ║${NC}"
    echo -e "${BLUE}║                    Instalación unificada                    ║${NC}"
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
    log "WARNING: $1"
}

print_info() {
    echo -e "${BLUE}  ℹ $1${NC}"
    log "INFO: $1"
}

# =============================================================================
#                           🔧 FUNCIONES DE VERIFICACIÓN
# =============================================================================

check_system() {
    print_section "Verificando sistema..."
    
    if [ ! -f "/etc/arch-release" ]; then
        print_error "Este script está diseñado solo para Arch Linux."
        exit 1
    fi
    
    if [ "$EUID" -eq 0 ]; then
        print_error "No ejecutes este script como root."
        exit 1
    fi
    
    print_success "Sistema verificado."
}

check_dependencies() {
    print_section "Verificando dependencias básicas..."
    
    local missing_deps=()
    
    for dep in "git" "sudo" "pacman"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Dependencias faltantes: ${missing_deps[*]}"
        print_info "Instala las dependencias básicas antes de continuar."
        exit 1
    fi
    
    print_success "Dependencias básicas verificadas."
}

# =============================================================================
#                           📦 FUNCIONES DE INSTALACIÓN
# =============================================================================

update_system() {
    print_section "Actualizando sistema..."
    sudo pacman -Sy --noconfirm
    print_success "Base de datos actualizada."
}

install_aur_helper() {
    print_section "Instalando AUR helper..."
    
    if command -v yay >/dev/null 2>&1; then
        print_success "yay ya está instalado."
        return
    fi
    
    print_step "Instalando yay..."
    cd /tmp
    git clone --depth 1 https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --skippgpcheck
    cd "$SCRIPT_DIR"
    rm -rf /tmp/yay
    
    print_success "AUR helper instalado."
}

install_compiler() {
    print_section "Instalando compilador C..."
    
    print_step "Verificando compilador existente..."
    if command -v gcc >/dev/null 2>&1; then
        print_success "gcc ya está instalado: $(gcc --version | head -1)"
        return
    elif command -v clang >/dev/null 2>&1; then
        print_success "clang ya está instalado: $(clang --version | head -1)"
        return
    fi
    
    print_step "Instalando base-devel (incluye gcc)..."
    sudo pacman -S base-devel --noconfirm --needed
    
    print_step "Verificando instalación..."
    if command -v gcc >/dev/null 2>&1; then
        print_success "Compilador C instalado: $(gcc --version | head -1)"
    else
        print_error "Falló al instalar compilador C"
    fi
}

install_core_packages() {
    print_section "Instalando paquetes core..."
    
    print_step "Instalando paquetes oficiales..."
    
    # Instalar paquetes en grupos para evitar conflictos
    local terminal_packages=("kitty" "fish" "starship" "zoxide" "tmux")
    local editor_packages=("neovim")
    local system_packages=("bat" "fd" "ripgrep" "fzf" "btop" "exa" "htop" "ncdu" "iotop" "nvtop")
    local media_packages=("pavucontrol" "blueman" "networkmanager" "network-manager-applet" "speedtest-cli" "nmtui" "playerctl" "pamixer" "brightnessctl")
    local dev_packages=("nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk" "gcc" "cmake" "ninja" "meson" "valgrind" "gdb")
    local docker_packages=("docker" "docker-compose" "podman" "buildah" "skopeo")
    local image_packages=("imagemagick" "ffmpeg" "v4l-utils" "pulseaudio-alsa" "libpng" "libjpeg-turbo" "libwebp" "librsvg" "giflib")
    local capture_packages=("flameshot" "grim" "slurp" "spectacle" "maim" "xclip")
    local utility_packages=("lazygit" "lazydocker" "yazi" "feh" "imv" "pcmanfm" "dolphin" "korganizer" "pamac" "polybar" "qalculate-gtk" "gnome-clocks" "w3m" "w3m-img")
    local media_player_packages=("mpv" "vlc" "cava" "oss" "spotify" "discord" "telegram-desktop" "mpd" "mpc")
    local creation_packages=("obs-studio" "krita" "gimp" "inkscape" "lmms" "pixelorama" "upscayl" "scribus")
    local clipboard_packages=("cliphist" "copyq" "libreoffice" "brave" "code")
    local font_packages=("nerd-fonts-complete" "noto-fonts" "noto-fonts-emoji" "ttf-dejavu" "ttf-liberation" "ttf-jetbrains-mono" "papirus-icon-theme" "bibata-cursor-theme")
    local gaming_packages=("steam" "lutris" "wine" "gamemode" "heroic-games-launcher" "mgba" "snes9x" "fceux")
    local additional_packages=("jq" "curl" "gdm" "atuin" "just" "httpie" "swappy" "swaylock-effects" "hyperlock" "waybar-hyprland" "eww-wayland" "wofi" "mako" "waypaper")
    local security_packages=("ufw" "wireguard-tools" "openvpn" "networkmanager-openvpn" "networkmanager-vpnc" "networkmanager-pptp" "networkmanager-l2tp" "nmap" "wireshark-qt" "tcpdump" "netcat" "nethogs" "iftop" "fail2ban" "rkhunter" "clamav" "clamav-unofficial-sigs")
    
    # Instalar paquetes críticos primero
    print_step "Instalando paquetes críticos..."
    sudo pacman -S "${terminal_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de terminal fallaron"
    
    # Instalar paquetes del sistema
    print_step "Instalando paquetes del sistema..."
    sudo pacman -S "${system_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes del sistema fallaron"
    
    # Instalar paquetes de desarrollo
    print_step "Instalando paquetes de desarrollo..."
    sudo pacman -S "${dev_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de desarrollo fallaron"
    
    # Instalar paquetes multimedia
    print_step "Instalando paquetes multimedia..."
    sudo pacman -S "${media_packages[@]}" "${image_packages[@]}" "${media_player_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes multimedia fallaron"
    
    # Instalar paquetes de utilidades
    print_step "Instalando paquetes de utilidades..."
    sudo pacman -S "${utility_packages[@]}" "${capture_packages[@]}" "${additional_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de utilidades fallaron"
    
    # Instalar paquetes de creación
    print_step "Instalando paquetes de creación..."
    sudo pacman -S "${creation_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de creación fallaron"
    
    # Instalar paquetes de portapapeles
    print_step "Instalando paquetes de portapapeles..."
    sudo pacman -S "${clipboard_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de portapapeles fallaron"
    
    # Instalar paquetes de fuentes
    print_step "Instalando paquetes de fuentes..."
    sudo pacman -S "${font_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de fuentes fallaron"
    
    # Instalar paquetes de gaming
    print_step "Instalando paquetes de gaming..."
    sudo pacman -S "${gaming_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de gaming fallaron"
    
    # Instalar paquetes de seguridad
    print_step "Instalando paquetes de seguridad..."
    sudo pacman -S "${security_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de seguridad fallaron"
    
    # Instalar paquetes de Docker por separado
    print_step "Instalando paquetes de Docker..."
    sudo pacman -S "${docker_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes de Docker fallaron"
    
    # Instalar Polybar explícitamente
    print_step "Instalando Polybar..."
    sudo pacman -S polybar --noconfirm --needed || print_warning "Polybar no se pudo instalar"
    
    print_success "Paquetes core instalados."
}

install_custom_icons_cursors() {
    print_section "Instalando iconos y cursores personalizados..."
    
    # Directorios de destino
    local icons_dir="$HOME/.local/share/icons"
    local cursors_dir="$HOME/.local/share/icons"
    local system_icons_dir="/usr/share/icons"
    local system_cursors_dir="/usr/share/icons"
    
    print_step "Creando directorios de destino..."
    mkdir -p "$icons_dir"
    mkdir -p "$cursors_dir"
    
    # Instalar iconos personalizados
    if [ -d "$DOTFILES_DIR/icons" ]; then
        print_step "Instalando iconos personalizados..."
        
        cd "$DOTFILES_DIR/icons"
        
        # Instalar Gradient-Dark-Icons
        if [ -f "Gradient-Dark-Icons.tar.gz" ]; then
            print_step "Instalando Gradient-Dark-Icons..."
            tar -xzf "Gradient-Dark-Icons.tar.gz" -C "$icons_dir" 2>/dev/null || {
                print_warning "No se pudo extraer Gradient-Dark-Icons"
            }
        fi
        
        # Instalar Tela-circle icons
        if [ -f "01-Tela-circle.tar.xz" ]; then
            print_step "Instalando Tela-circle icons..."
            tar -xf "01-Tela-circle.tar.xz" -C "$icons_dir" 2>/dev/null || {
                print_warning "No se pudo extraer Tela-circle icons"
            }
        fi
        
        # Instalar candy-icons
        if [ -f "candy-icons.tar.xz" ]; then
            print_step "Instalando candy-icons..."
            tar -xf "candy-icons.tar.xz" -C "$icons_dir" 2>/dev/null || {
                print_warning "No se pudo extraer candy-icons"
            }
        fi
        
        # Instalar Ketsa-icons
        if [ -f "Ketsa-icons.tar.xz" ]; then
            print_step "Instalando Ketsa-icons..."
            tar -xf "Ketsa-icons.tar.xz" -C "$icons_dir" 2>/dev/null || {
                print_warning "No se pudo extraer Ketsa-icons"
            }
        fi
        
        print_success "Iconos personalizados instalados"
    else
        print_warning "Directorio de iconos no encontrado en dotfiles"
    fi
    
    # Instalar cursores personalizados
    if [ -d "$DOTFILES_DIR/cursor" ]; then
        print_step "Instalando cursores personalizados..."
        
        cd "$DOTFILES_DIR/cursor"
        
        # Instalar Bibata-Rainbow-Modern
        if [ -f "Bibata-Rainbow-Modern.tar.gz" ]; then
            print_step "Instalando Bibata-Rainbow-Modern cursor..."
            tar -xzf "Bibata-Rainbow-Modern.tar.gz" -C "$cursors_dir" 2>/dev/null || {
                print_warning "No se pudo extraer Bibata-Rainbow-Modern cursor"
            }
        fi
        
        # Instalar Night Diamond cursors
        if [ -f "Night Diamond (Red).tar" ]; then
            print_step "Instalando Night Diamond (Red) cursor..."
            tar -xf "Night Diamond (Red).tar" -C "$cursors_dir" 2>/dev/null || {
                print_warning "No se pudo extraer Night Diamond (Red) cursor"
            }
        fi
        
        if [ -f "Night Diamond (Blue).tar" ]; then
            print_step "Instalando Night Diamond (Blue) cursor..."
            tar -xf "Night Diamond (Blue).tar" -C "$cursors_dir" 2>/dev/null || {
                print_warning "No se pudo extraer Night Diamond (Blue) cursor"
            }
        fi
        
        print_success "Cursores personalizados instalados"
    else
        print_warning "Directorio de cursores no encontrado en dotfiles"
    fi
    
    # Actualizar caché de iconos
    print_step "Actualizando caché de iconos..."
    if command -v gtk-update-icon-cache >/dev/null 2>&1; then
        gtk-update-icon-cache -f -t "$icons_dir" 2>/dev/null || true
    fi
    
    if command -v update-icon-caches >/dev/null 2>&1; then
        update-icon-caches "$icons_dir" 2>/dev/null || true
    fi
    
    # Configurar iconos por defecto
    print_step "Configurando iconos por defecto..."
    mkdir -p "$HOME/.config/gtk-3.0"
    
    cat > "$HOME/.config/gtk-3.0/settings.ini" << 'EOF'
[Settings]
gtk-icon-theme-name = Gradient-Dark-Icons
gtk-cursor-theme-name = Bibata-Rainbow-Modern
gtk-toolbar-style = GTK_TOOLBAR_ICONS
gtk-menu-images = 1
gtk-button-images = 1
gtk-enable-animations = 1
gtk-primary-button-warps-slider = 0
gtk-enable-mnemonics = 1
gtk-auto-mnemonics = 1
gtk-recent-files-enabled = 1
gtk-recent-files-max-age = 30
gtk-can-change-accels = 0
gtk-color-scheme = "selected_bg_color:#3584e4\nselected_fg_color:#ffffff\nbase_color:#ffffff\nfg_color:#2c2c2c\ntooltip_bg_color:#f5f5b5\ntooltip_fg_color:#000000"
gtk-toolbar-icon-size = GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-im-module = gtk-im-context-simple
gtk-menu-popup-delay = 0
gtk-menu-popdown-delay = 0
gtk-enable-accels = 1
gtk-modules = gail:atk-bridge
EOF
    
    # Configurar para GTK4
    mkdir -p "$HOME/.config/gtk-4.0"
    cat > "$HOME/.config/gtk-4.0/settings.ini" << 'EOF'
[Settings]
gtk-icon-theme-name = Gradient-Dark-Icons
gtk-cursor-theme-name = Bibata-Rainbow-Modern
gtk-toolbar-style = GTK_TOOLBAR_ICONS
gtk-menu-images = 1
gtk-button-images = 1
gtk-enable-animations = 1
gtk-primary-button-warps-slider = 0
gtk-enable-mnemonics = 1
gtk-auto-mnemonics = 1
gtk-recent-files-enabled = 1
gtk-recent-files-max-age = 30
gtk-can-change-accels = 0
gtk-toolbar-icon-size = GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-im-module = gtk-im-context-simple
gtk-menu-popup-delay = 0
gtk-menu-popdown-delay = 0
gtk-enable-accels = 1
EOF
    
    # Configurar para aplicaciones Qt
    mkdir -p "$HOME/.config/qt5ct"
    cat > "$HOME/.config/qt5ct/qt5ct.conf" << 'EOF'
[Appearance]
icon_theme = Gradient-Dark-Icons
color_scheme_path = 
custom_palette = false
standard_dialogs = false
style = GTK2
EOF
    
    mkdir -p "$HOME/.config/qt6ct"
    cat > "$HOME/.config/qt6ct/qt6ct.conf" << 'EOF'
[Appearance]
icon_theme = Gradient-Dark-Icons
color_scheme_path = 
custom_palette = false
standard_dialogs = false
style = GTK2
EOF
    
    # Configurar variables de entorno
    print_step "Configurando variables de entorno..."
    cat >> "$HOME/.bashrc" << 'EOF'

# Iconos y cursores personalizados
export GTK_ICON_THEME=Gradient-Dark-Icons
export XCURSOR_THEME=Bibata-Rainbow-Modern
export QT_ICON_THEME=Gradient-Dark-Icons
EOF
    
    if [ -f "$HOME/.zshrc" ]; then
        cat >> "$HOME/.zshrc" << 'EOF'

# Iconos y cursores personalizados
export GTK_ICON_THEME=Gradient-Dark-Icons
export XCURSOR_THEME=Bibata-Rainbow-Modern
export QT_ICON_THEME=Gradient-Dark-Icons
EOF
    fi
    
    if [ -f "$HOME/.config/fish/config.fish" ]; then
        cat >> "$HOME/.config/fish/config.fish" << 'EOF'

# Iconos y cursores personalizados
set -gx GTK_ICON_THEME Gradient-Dark-Icons
set -gx XCURSOR_THEME Bibata-Rainbow-Modern
set -gx QT_ICON_THEME Gradient-Dark-Icons
EOF
    fi
    
    print_success "Iconos y cursores personalizados instalados y configurados"
}

install_aur_packages() {
    print_section "Instalando paquetes AUR..."
    
    local aur_packages=(
        "hyperlock" "oss" "nerd-fonts-complete" "heroic-games-launcher"
        "pixelorama" "upscayl" "appflowy" "figma-linux" "zeal" "trello" "betterdiscord" "opentabletdriver" "rmpc" "spotify-cli" "gemini-cli" "ytui-music"
    )
    
    for pkg in "${aur_packages[@]}"; do
        print_step "Instalando $pkg..."
        yay -S "$pkg" --noconfirm --needed
    done
    
    print_success "Paquetes AUR instalados."
}

install_wayland_components() {
    print_section "Instalando componentes de Wayland..."
    
    local wayland_packages=(
        "hyprland" "waybar" "eww" "swww" "wofi" "mako" "swaylock"
        "swayidle" "grim" "slurp" "wl-clipboard" "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk"
    )
    
    print_step "Instalando componentes de Wayland..."
    sudo pacman -S "${wayland_packages[@]}" --noconfirm --needed || print_warning "Algunos componentes de Wayland fallaron"
    
    print_success "Componentes de Wayland instalados."
}

# =============================================================================
#                           🎨 FUNCIONES DE CONFIGURACIÓN
# =============================================================================

configure_hyprlock() {
    print_section "Configurando Hyprlock..."
    
    print_step "Verificando instalación de hyprlock..."
    if ! command -v hyprlock >/dev/null 2>&1; then
        print_step "Instalando hyprlock..."
        yay -S "hyprlock" --noconfirm --needed
    fi
    
    print_step "Configurando Hyprlock..."
    mkdir -p "$HOME/.config/hyprlock"
    
    if [ -f "$DOTFILES_DIR/hyprlock/hyprlock.conf" ]; then
        print_step "Copiando configuración de hyprlock desde dotfiles..."
        cp "$DOTFILES_DIR/hyprlock/hyprlock.conf" "$HOME/.config/hyprlock/"
        
        if [ -d "$DOTFILES_DIR/hyprlock/assets" ]; then
            cp -r "$DOTFILES_DIR/hyprlock/assets" "$HOME/.config/hyprlock/"
        fi
        
        print_success "Configuración de hyprlock copiada"
    else
        print_warning "No se encontró configuración de hyprlock en dotfiles"
    fi
}

configure_clipboard() {
    print_section "Configurando portapapeles e historial..."
    
    print_step "Configurando cliphist..."
    mkdir -p "$HOME/.config/cliphist"
    
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

install_grub_theme() {
    print_section "Instalando tema GRUB personalizado..."
    
    local grub_themes_dir="$DOTFILES_DIR/grub-themes"
    local grub_system_dir="/boot/grub/themes"
    
    if [ -d "$grub_themes_dir" ]; then
        print_step "Verificando temas GRUB disponibles..."
        
        # Buscar temas disponibles
        local themes_found=()
        for theme_dir in "$grub_themes_dir"/*; do
            if [ -d "$theme_dir" ] && [ -f "$theme_dir/theme.txt" ]; then
                local theme_name=$(basename "$theme_dir")
                themes_found+=("$theme_name")
            fi
        done
        
        if [ ${#themes_found[@]} -gt 0 ]; then
            print_step "Temas encontrados: ${themes_found[*]}"
            
            # Instalar el primer tema encontrado (puedes modificar para seleccionar uno específico)
            local selected_theme="${themes_found[0]}"
            local theme_path="$grub_themes_dir/$selected_theme"
            
            print_step "Instalando tema: $selected_theme"
            
            # Crear directorio de temas GRUB si no existe
            sudo mkdir -p "$grub_system_dir"
            
            # Hacer backup del tema anterior si existe
            if [ -d "$grub_system_dir/$selected_theme" ]; then
                print_step "Haciendo backup del tema anterior..."
                sudo mv "$grub_system_dir/$selected_theme" "$grub_system_dir/${selected_theme}.backup.$(date +%Y%m%d_%H%M%S)"
            fi
            
            # Copiar el tema
            print_step "Copiando tema a $grub_system_dir/$selected_theme..."
            sudo cp -r "$theme_path" "$grub_system_dir/$selected_theme"
            
            # Hacer backup de la configuración GRUB
            print_step "Haciendo backup de la configuración GRUB..."
            sudo cp /etc/default/grub /etc/default/grub.backup.$(date +%Y%m%d_%H%M%S)
            
            # Configurar el tema en GRUB
            print_step "Configurando tema en GRUB..."
            
            # Verificar si ya existe una configuración de tema
            if grep -q "GRUB_THEME=" /etc/default/grub; then
                # Actualizar tema existente
                sudo sed -i "s|GRUB_THEME=.*|GRUB_THEME=\"$grub_system_dir/$selected_theme/theme.txt\"|" /etc/default/grub
            else
                # Agregar configuración de tema
                echo "GRUB_THEME=\"$grub_system_dir/$selected_theme/theme.txt\"" | sudo tee -a /etc/default/grub
            fi
            
            # Configurar resolución si no está configurada
            if ! grep -q "GRUB_GFXMODE=" /etc/default/grub; then
                print_step "Configurando resolución GRUB..."
                echo "GRUB_GFXMODE=1920x1080,1600x900,1366x768,1024x768" | sudo tee -a /etc/default/grub
            fi
            
            # Configurar timeout si no está configurado
            if ! grep -q "GRUB_TIMEOUT=" /etc/default/grub; then
                print_step "Configurando timeout GRUB..."
                echo "GRUB_TIMEOUT=5" | sudo tee -a /etc/default/grub
            fi
            
            # Actualizar configuración GRUB
            print_step "Actualizando configuración GRUB..."
            sudo grub-mkconfig -o /boot/grub/grub.cfg
            
            print_success "Tema GRUB '$selected_theme' instalado correctamente"
            print_info "Tema ubicado en: $grub_system_dir/$selected_theme"
            print_warning "Reinicia el sistema para ver el nuevo tema GRUB"
            
            # Mostrar información adicional
            if [ -f "$theme_path/README.md" ]; then
                print_info "Información del tema:"
                cat "$theme_path/README.md" | head -10
            fi
            
        else
            print_warning "No se encontraron temas GRUB válidos en $grub_themes_dir"
            print_error "No se instalará ningún tema GRUB. Agrega un tema válido a dotfiles/grub-themes."
        fi
    else
        print_warning "Directorio de temas GRUB no encontrado en dotfiles"
        print_error "No se instalará ningún tema GRUB. Agrega un tema válido a dotfiles/grub-themes."
    fi
}

# =============================================================================
#                           📁 FUNCIONES DE DOTFILES
# =============================================================================

install_custom_fonts() {
    print_section "Instalando fuentes personalizadas..."
    
    local fonts_dir="$DOTFILES_DIR/fonts"
    local user_fonts="$HOME/.local/share/fonts"
    local system_fonts="/usr/share/fonts"
    
    mkdir -p "$user_fonts"
    
    if [ -d "$fonts_dir" ]; then
        print_step "Copiando fuentes personalizadas..."
        
        local font_files=($(find "$fonts_dir" -type f \( -iname "*.ttf" -o -iname "*.otf" -o -iname "*.woff" -o -iname "*.woff2" \) 2>/dev/null))
        
        if [ ${#font_files[@]} -gt 0 ]; then
            cp "${font_files[@]}" "$user_fonts/"
            print_success "Fuentes copiadas a $user_fonts"
            
            print_step "Actualizando caché de fuentes..."
            fc-cache -fv
            print_success "Caché de fuentes actualizado"
            
            if sudo -n true 2>/dev/null; then
                print_step "Instalando fuentes en sistema..."
                sudo mkdir -p "$system_fonts/custom"
                sudo cp "${font_files[@]}" "$system_fonts/custom/"
                sudo fc-cache -fv
                print_success "Fuentes instaladas en sistema"
            else
                print_warning "No se pudieron instalar fuentes en sistema (requiere sudo)"
            fi
        else
            print_warning "No se encontraron archivos de fuentes en $fonts_dir"
        fi
    else
        print_warning "Directorio de fuentes no encontrado en dotfiles."
    fi
}

copy_wallpapers() {
    print_section "Copiando wallpapers..."
    
    local user_pictures="$HOME/Pictures"
    [ -d "$user_pictures" ] || user_pictures="$HOME/Imágenes"
    mkdir -p "$user_pictures"
    
    local wallpapers_dir="$user_pictures/wallpapers"
    mkdir -p "$wallpapers_dir"
    
    if [ -d "$DOTFILES_DIR/wallpapers" ]; then
        print_step "Copiando wallpapers a $wallpapers_dir..."
        cp -r "$DOTFILES_DIR/wallpapers"/* "$wallpapers_dir/"
        print_success "Wallpapers copiados a $wallpapers_dir"
        
        if [ ! -L "$HOME/.local/share/wallpapers" ]; then
            ln -sf "$wallpapers_dir" "$HOME/.local/share/wallpapers"
            print_success "Enlace simbólico creado en ~/.local/share/wallpapers"
        fi
    else
        print_warning "Directorio de wallpapers no encontrado en dotfiles."
    fi
}

copy_dotfiles() {
    print_section "Copiando dotfiles..."
    
    print_step "Creando directorios..."
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/share"
    mkdir -p "$HOME/.local/bin"
    
    print_step "Copiando configuraciones..."
    
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
    
    for item in "$DOTFILES_DIR"/*; do
        if [ -d "$item" ]; then
            local dirname=$(basename "$item")
            local target_path="${config_paths[$dirname]}"
            
            if [ -n "$target_path" ]; then
                print_step "Copiando $dirname a $target_path..."
                mkdir -p "$(dirname "$target_path")"
                
                case "$dirname" in
                    "nvim")
                        print_step "Clonando NVimX desde GitHub..."
                        if [ -d "$HOME/.config/nvim" ]; then
                            print_step "Haciendo backup de la configuración actual de nvim..."
                            mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
                        fi
                        
                        print_step "Configurando Neovim con dashboard..."
                        
                        # Crear directorios
                        mkdir -p "$HOME/.config/nvim/lua/plugins"
                        mkdir -p "$HOME/.config/nvim/lua/config"
                        
                        # Copiar archivos de configuración
                        if [ -d "$item" ]; then
                            cp -r "$item"/* "$HOME/.config/nvim/"
                            print_success "Configuración de Neovim copiada"
                            
                            # Instalar plugins
                            print_step "Instalando plugins de Neovim..."
                            nvim --headless -c "Lazy! sync" -c "quit" 2>/dev/null || true
                            print_success "Plugins de Neovim instalados"
                        else
                            print_error "Configuración de Neovim no encontrada"
                        fi
                        ;;
                    "sddm")
                        print_step "Copiando configuración SDDM..."
                        sudo cp "$item"/* "$target_path/" 2>/dev/null || true
                        print_success "Configuración SDDM copiada"
                        ;;
                    "grub-themes")
                        print_step "Saltando grub-themes (manejado por install_grub_theme)"
                        ;;
                    "tmux")
                        print_step "Configurando Tmux con TPM y keybindings..."
                            
                        # Crear directorio de configuración tmux
                            mkdir -p "$HOME/.tmux"
                        mkdir -p "$HOME/.tmux/plugins"
                        
                        # Instalar TPM si no existe
                        if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
                            print_step "Instalando TPM (Tmux Plugin Manager)..."
                            git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
                            print_success "TPM instalado"
                        else
                            print_success "TPM ya está instalado"
                        fi
                        
                        # Copiar configuración tmux
                        if [ -f "$item/.tmux.conf" ]; then
                            cp "$item/.tmux.conf" "$HOME/.tmux.conf"
                            print_success "Configuración Tmux copiada a $HOME/.tmux.conf"
                        else
                            print_warning "Archivo de configuración Tmux no encontrado, creando configuración básica"
                            cat > "$HOME/.tmux.conf" << 'EOF'
# =============================================================================
# TMUX CONFIGURATION - Optimized for Neovim VimX
# =============================================================================

# =============================================================================
# BASIC SETTINGS
# =============================================================================

# Set prefix to Ctrl+a (easy to reach and doesn't conflict)
unbind C-b
set -g prefix C-a
bind a send-prefix

# Enable mouse support
set -g mouse on

# Start window numbering at 1
set -g base-index 1
set -g pane-base-index 1

# Automatically renumber windows
set -g renumber-windows on

# Increase scrollback buffer size
set -g history-limit 50000

# Increase message display time
set -g display-time 4000

# Set terminal colors
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# Enable focus events
set -g focus-events on

# =============================================================================
# PLUGIN MANAGER - TPM (Tmux Plugin Manager)
# =============================================================================

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Theme - Catppuccin
set -g @plugin 'catppuccin/tmux#v2.1.3'
set -g @catppuccin_flavor 'mocha' # latte, frappe, macchiato or mocha

# Theme and Status Bar
set -g @plugin 'tmux-plugins/tmux-pain-control'
set -g @plugin 'tmux-plugins/tmux-battery'
set -g @plugin 'tmux-plugins/tmux-cpu'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-open'
set -g @plugin 'tmux-plugins/tmux-copycat'
set -g @plugin 'tmux-plugins/tmux-urlview'

# Session Management
set -g @plugin 'tmux-plugins/tmux-sessionist'
set -g @plugin 'tmux-plugins/tmux-fpp'

# Navigation and Search
set -g @plugin 'tmux-plugins/tmux-fingers'
set -g @plugin 'tmux-plugins/tmux-logging'

# =============================================================================
# PLUGIN CONFIGURATION
# =============================================================================

# Resurrect - Save/Restore sessions
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-nvim 'session'
set -g @resurrect-dir '~/.tmux/resurrect'

# Continuum - Auto save every 15 minutes
set -g @continuum-restore 'on'
set -g @continuum-save-interval '15'

# Battery
set -g @batt_icon_charge_tier8 ' '
set -g @batt_icon_charge_tier7 ' '
set -g @batt_icon_charge_tier6 ' '
set -g @batt_icon_charge_tier5 ' '
set -g @batt_icon_charge_tier4 ' '
set -g @batt_icon_charge_tier3 ' '
set -g @batt_icon_charge_tier2 ' '
set -g @batt_icon_charge_tier1 ' '

# Catppuccin Theme Configuration
set -g @catppuccin_window_left_separator "█"
set -g @catppuccin_window_right_separator "█"
set -g @catppuccin_window_middle_separator "█"
set -g @catppuccin_window_number_position "right"
set -g @catppuccin_window_default_fill "number"
set -g @catppuccin_window_current_fill "number"
set -g @catppuccin_window_default_text "#W"
set -g @catppuccin_window_current_text "#W"
set -g @catppuccin_status_modules_right "directory session"
set -g @catppuccin_status_modules_left "session"
set -g @catppuccin_status_left_separator "█"
set -g @catppuccin_status_right_separator "█"
set -g @catppuccin_status_right_separator_inverse "no"
set -g @catppuccin_status_fill "icon"
set -g @catppuccin_status_connect_separator "yes"

# =============================================================================
# CATPPUCCIN MOCHA CUSTOM COLORS
# =============================================================================
# Add the colors from the palette. Check the themes/ directory for all options.

# Some basic mocha colors.
set -g @ctp_bg "#24273a"
set -g @ctp_surface_1 "#494d64"
set -g @ctp_fg "#cad3f5"
set -g @ctp_mauve "#c6a0f6"
set -g @ctp_crust "#181926"

# Status line
set -gF status-style "bg=#{@ctp_bg},fg=#{@ctp_fg}"

# Windows
set -gF window-status-format "#[bg=#{@ctp_surface_1},fg=#{@ctp_fg}] ##I ##T "
set -gF window-status-current-format "#[bg=#{@ctp_mauve},fg=#{@ctp_crust}] ##I ##T "

# =============================================================================
# STATUS BAR CONFIGURATION - Catppuccin Theme
# =============================================================================

# Status bar configuration is now handled by Catppuccin theme
# The theme will automatically apply beautiful Catppuccin colors
# and styling to the status bar

# Window status
set -g window-status-format " #I:#W#F "
set -g window-status-current-format " #I:#W#F "
set -g window-status-current-style bg=colour136,fg=colour235

# =============================================================================
# KEYBINDINGS - Optimized for Neovim VimX (Easy & Non-Conflicting)
# =============================================================================

# Reload config
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# =============================================================================
# PANE MANAGEMENT - Easy Splits & Navigation
# =============================================================================

# Split panes - More intuitive keys
bind v split-window -h -c "#{pane_current_path}"  # Vertical split (v for vertical)
bind s split-window -v -c "#{pane_current_path}"  # Horizontal split (s for split)
unbind '"'
unbind %

# Switch panes - Super easy navigation (no prefix needed)
bind -n C-h select-pane -L  # Ctrl+h (like vim)
bind -n C-j select-pane -D  # Ctrl+j (like vim)
bind -n C-k select-pane -U  # Ctrl+k (like vim)
bind -n C-l select-pane -R  # Ctrl+l (like vim)

# Resize panes - Easy resize with Ctrl+Shift
bind -n C-S-h resize-pane -L 5
bind -n C-S-j resize-pane -D 5
bind -n C-S-k resize-pane -U 5
bind -n C-S-l resize-pane -R 5

# =============================================================================
# WINDOW MANAGEMENT - Easy Window Control
# =============================================================================

# Switch windows - Easy number keys
bind -n C-1 select-window -t :1
bind -n C-2 select-window -t :2
bind -n C-3 select-window -t :3
bind -n C-4 select-window -t :4
bind -n C-5 select-window -t :5
bind -n C-6 select-window -t :6
bind -n C-7 select-window -t :7
bind -n C-8 select-window -t :8
bind -n C-9 select-window -t :9
bind -n C-0 select-window -t :10

# Quick window creation
bind n new-window -c "#{pane_current_path}"  # n for new
bind N new-window

# Kill pane/window
bind q kill-pane   # q for quit
bind Q kill-window # Q for quit window

# Toggle zoom
bind z resize-pane -Z  # z for zoom

# =============================================================================
# COPY MODE - Easy Copy/Paste
# =============================================================================

# Enter copy mode
bind -n C-b copy-mode  # Ctrl+b to enter copy mode

# Search in copy mode
bind -n C-f copy-mode \; send-keys -X search-forward
bind -n C-g copy-mode \; send-keys -X search-backward

# =============================================================================
# PLUGIN KEYBINDINGS - Easy Access
# =============================================================================

# Resurrect - Save/Restore sessions
bind S run-shell '~/.tmux/plugins/tmux-resurrect/scripts/save.sh'
bind R run-shell '~/.tmux/plugins/tmux-resurrect/scripts/restore.sh'

# Fingers - URL/file detection
bind F run-shell -b "~/.tmux/plugins/tmux-fingers/scripts/tmux-fingers.sh"

# URL View
bind u run-shell "~/.tmux/plugins/tmux-urlview/scripts/tmux-urlview.sh"

# Sessionist
bind C-S-f run-shell "~/.tmux/plugins/tmux-sessionist/scripts/kill_session.sh"
bind C-S-s run-shell "~/.tmux/plugins/tmux-sessionist/scripts/switch_session.sh"

# =============================================================================
# UTILITY KEYBINDINGS
# =============================================================================

# Synchronize panes
bind y set-window-option synchronize-panes

# Rename window
bind , command-prompt -I "#W" "rename-window '%%'"

# =============================================================================
# INITIALIZE TPM
# =============================================================================

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF
                        fi
                        
                        print_step "Instalando plugins de Tmux..."
                        # Crear script para instalar plugins después de la primera sesión
                        cat > "$HOME/.tmux/install-plugins.sh" << 'EOF'
#!/bin/bash
# Script para instalar plugins de tmux
echo "Instalando plugins de Tmux..."
tmux source-file ~/.tmux.conf
echo "Plugins instalados. Reinicia tmux para aplicar cambios."
EOF
                        chmod +x "$HOME/.tmux/install-plugins.sh"
                        
                        print_success "Tmux configurado con TPM y keybindings"
                        print_info "Para instalar plugins: tmux new-session, luego Ctrl+a + I"
                        ;;
                    *)
                        if [[ "$target_path" == /etc/* ]]; then
                            sudo cp -r "$item"/* "$target_path/" 2>/dev/null || sudo cp -r "$item" "$(dirname "$target_path")/"
                        else
                            cp -r "$item"/* "$target_path/" 2>/dev/null || cp -r "$item" "$(dirname "$target_path")/"
                        fi
                        print_success "$dirname copiado a $target_path"
                        ;;
                esac
            else
                print_step "Copiando $dirname a ~/.config/$dirname..."
                cp -r "$item" "$HOME/.config/"
                print_success "$dirname copiado a ~/.config/$dirname"
            fi
        fi
    done
    
    print_step "Haciendo scripts ejecutables..."
    find "$HOME/.config" -name "*.sh" -type f -exec chmod +x {} \; 2>/dev/null || true
    
    if [ -d "$DOTFILES_DIR/scripts" ]; then
        print_step "Copiando scripts..."
        mkdir -p "$HOME/.config/scripts"
        cp "$DOTFILES_DIR/scripts"/*.sh "$HOME/.config/scripts/"
        chmod +x "$HOME/.config/scripts"/*.sh
        print_success "Scripts copiados a ~/.config/scripts/"
    fi
    
    print_success "Todos los dotfiles copiados exitosamente."
}

# =============================================================================
#                           🔧 FUNCIONES DE CONFIGURACIÓN DEL SISTEMA
# =============================================================================

configure_fish_shell() {
    print_section "Configurando Fish shell..."
    
    print_step "Configurando Fish como shell por defecto..."
    if ! grep -q "/usr/bin/fish" /etc/shells; then
        echo "/usr/bin/fish" | sudo tee -a /etc/shells
    fi
    
    sudo chsh -s /usr/bin/fish "$USER"
    print_success "Fish shell configurado como por defecto"
    
    print_step "Configurando entorno Fish..."
    mkdir -p "$HOME/.config/fish"
    
    if [ -f "$HOME/.config/fish/config.fish" ]; then
        print_success "Configuración Fish encontrada"
    else
        print_warning "Configuración Fish no encontrada, creando configuración básica"
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
    
    print_success "Fish shell configurado"
}

configure_system() {
    print_section "Configurando sistema..."
    
    print_step "Configurando permisos y servicios..."
    sudo usermod -aG wheel "$USER" &
    sudo systemctl enable NetworkManager bluetooth gdm &
    wait
    
    print_step "Configurando GDM para Hyprland..."
    sudo mkdir -p /usr/share/wayland-sessions
    sudo tee /usr/share/wayland-sessions/hyprland.desktop > /dev/null << 'EOF'
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
    
    print_success "Sistema configurado."
}

# =============================================================================
#                           🛡️ FUNCIONES DE SEGURIDAD
# =============================================================================

configure_firewall() {
    print_section "Configurando firewall (UFW)..."
    
    print_step "Verificando instalación de UFW..."
    if ! command -v ufw >/dev/null 2>&1; then
        print_step "Instalando UFW..."
        sudo pacman -S ufw --noconfirm --needed
    fi
    
    print_step "Configurando reglas básicas de UFW..."
    
    # Habilitar UFW
    sudo ufw --force enable
    
    # Configurar políticas por defecto
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    
    # Permitir SSH (si está instalado)
    if systemctl is-active --quiet sshd; then
        sudo ufw allow ssh
        print_step "Regla SSH agregada"
    fi
    
    # Permitir conexiones locales
    sudo ufw allow from 127.0.0.1
    sudo ufw allow from ::1
    
    # Permitir DNS
    sudo ufw allow out 53/tcp
    sudo ufw allow out 53/udp
    
    # Permitir HTTP/HTTPS
    sudo ufw allow out 80/tcp
    sudo ufw allow out 443/tcp
    
    # Permitir NTP
    sudo ufw allow out 123/udp
    
    print_step "Configurando UFW para inicio automático..."
    sudo systemctl enable ufw
    sudo systemctl start ufw
    
    print_success "Firewall UFW configurado y habilitado"
    print_info "Estado del firewall: $(sudo ufw status | head -1)"
}

configure_vpn() {
    print_section "Configurando herramientas VPN..."
    
    print_step "Verificando instalación de WireGuard..."
    if ! command -v wg >/dev/null 2>&1; then
        print_step "Instalando WireGuard..."
        sudo pacman -S wireguard-tools --noconfirm --needed
    fi
    
    print_step "Creando directorio de configuración WireGuard..."
    sudo mkdir -p /etc/wireguard
    
    print_step "Generando claves WireGuard..."
    if [ ! -f /etc/wireguard/private.key ]; then
        sudo wg genkey | sudo tee /etc/wireguard/private.key > /dev/null
        sudo wg pubkey < /etc/wireguard/private.key | sudo tee /etc/wireguard/public.key > /dev/null
        sudo chmod 600 /etc/wireguard/private.key
        sudo chmod 644 /etc/wireguard/public.key
        print_success "Claves WireGuard generadas"
    else
        print_info "Claves WireGuard ya existen"
    fi
    
    print_step "Creando configuración de ejemplo WireGuard..."
    sudo tee /etc/wireguard/wg0.conf.example > /dev/null << 'EOF'
[Interface]
PrivateKey = <tu_clave_privada>
Address = 10.0.0.2/24
DNS = 1.1.1.1, 1.0.0.1

[Peer]
PublicKey = <clave_pública_del_servidor>
AllowedIPs = 0.0.0.0/0
Endpoint = <servidor_vpn>:51820
PersistentKeepalive = 25
EOF
    
    print_step "Configurando NetworkManager para VPN..."
    if command -v nmcli >/dev/null 2>&1; then
        # Habilitar plugins de VPN en NetworkManager
        sudo systemctl enable NetworkManager
        sudo systemctl start NetworkManager
        
        print_success "NetworkManager configurado para VPN"
    fi
    
    print_success "Herramientas VPN configuradas"
    print_info "Clave pública WireGuard: $(sudo cat /etc/wireguard/public.key)"
    print_info "Configuración de ejemplo en: /etc/wireguard/wg0.conf.example"
}

configure_security_tools() {
    print_section "Configurando herramientas de seguridad..."
    
    print_step "Configurando Fail2ban..."
    if command -v fail2ban-client >/dev/null 2>&1; then
        sudo systemctl enable fail2ban
        sudo systemctl start fail2ban
        
        # Crear configuración básica
        sudo tee /etc/fail2ban/jail.local > /dev/null << 'EOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3

[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
EOF
        
        print_success "Fail2ban configurado"
    fi
    
    print_step "Configurando ClamAV..."
    if command -v freshclam >/dev/null 2>&1; then
        sudo freshclam
        sudo systemctl enable clamav-daemon
        sudo systemctl start clamav-daemon
        
        print_success "ClamAV configurado"
    fi
    
    print_step "Configurando RKHunter..."
    if command -v rkhunter >/dev/null 2>&1; then
        sudo rkhunter --update
        sudo rkhunter --propupd
        
        # Crear tarea cron para escaneos diarios
        echo "0 2 * * * root /usr/bin/rkhunter --cronjob --update --quiet" | sudo tee -a /etc/crontab
        
        print_success "RKHunter configurado"
    fi
    
    print_success "Herramientas de seguridad configuradas"
}

configure_network_monitoring() {
    print_section "Configurando monitoreo de red..."
    
    print_step "Creando directorio de logs de red..."
    sudo mkdir -p /var/log/network
    sudo chmod 755 /var/log/network
    
    print_step "Configurando tcpdump para captura de paquetes..."
    sudo groupadd -f pcap
    sudo usermod -a -G pcap "$USER"
    
    print_step "Configurando herramientas de monitoreo..."
    
    # Crear script de monitoreo de red
    sudo tee /usr/local/bin/network-monitor.sh > /dev/null << 'EOF'
#!/bin/bash
# Script de monitoreo de red

echo "=== MONITOREO DE RED ==="
echo "Fecha: $(date)"
echo ""

echo "=== CONEXIONES ACTIVAS ==="
ss -tuln

echo ""
echo "=== PROCESOS DE RED ==="
ps aux | grep -E "(ssh|vpn|wireguard)" | grep -v grep

echo ""
echo "=== ESTADO DEL FIREWALL ==="
sudo ufw status

echo ""
echo "=== INTERFACES DE RED ==="
ip addr show

echo ""
echo "=== RUTAS ==="
ip route show
EOF
    
    sudo chmod +x /usr/local/bin/network-monitor.sh
    
    print_success "Monitoreo de red configurado"
    print_info "Usa: sudo /usr/local/bin/network-monitor.sh"
}

configure_tmux() {
    print_section "Configurando Tmux..."
    
    print_step "Verificando instalación de tmux..."
    if ! command -v tmux >/dev/null 2>&1; then
        print_step "Instalando tmux..."
        sudo pacman -S tmux --noconfirm --needed
    fi
    
    print_step "Creando directorios de configuración tmux..."
    mkdir -p "$HOME/.tmux"
    mkdir -p "$HOME/.tmux/plugins"
    
    print_step "Instalando TPM (Tmux Plugin Manager)..."
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        print_success "TPM instalado"
    else
        print_success "TPM ya está instalado"
    fi
    
    print_step "Creando script de diagnóstico tmux..."
    cat > "$HOME/.tmux/tmux-diagnostic.sh" << 'EOF'
#!/bin/bash

# =============================================================================
# TMUX DIAGNOSTIC SCRIPT - Troubleshoot Keybinding Issues
# =============================================================================

echo "🔍 TMUX DIAGNOSTIC TOOL"
echo "=========================="

# Check if tmux is installed
echo "1. Checking tmux installation..."
if command -v tmux &> /dev/null; then
    echo "✅ tmux is installed: $(tmux -V)"
else
    echo "❌ tmux is not installed"
    exit 1
fi

# Check tmux configuration
echo -e "\n2. Checking tmux configuration..."
if [ -f ~/.tmux.conf ]; then
    echo "✅ ~/.tmux.conf exists"
    echo "   Size: $(wc -l < ~/.tmux.conf) lines"
else
    echo "❌ ~/.tmux.conf not found"
fi

# Check TPM installation
echo -e "\n3. Checking TPM (Tmux Plugin Manager)..."
if [ -d ~/.tmux/plugins/tpm ]; then
    echo "✅ TPM is installed"
    echo "   Plugins directory: ~/.tmux/plugins/"
    echo "   Installed plugins:"
    ls -la ~/.tmux/plugins/ 2>/dev/null || echo "   No plugins found"
else
    echo "❌ TPM not found at ~/.tmux/plugins/tpm"
    echo "   Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Check current tmux sessions
echo -e "\n4. Checking tmux sessions..."
if tmux list-sessions &> /dev/null; then
    echo "✅ tmux sessions found:"
    tmux list-sessions
else
    echo "ℹ️  No active tmux sessions"
fi

# Test keybindings
echo -e "\n5. Testing keybindings..."
echo "   Starting a test tmux session..."
tmux new-session -d -s test_session
sleep 2

# Check if prefix is working
echo "   Testing prefix key (Ctrl+a)..."
tmux send-keys -t test_session "echo 'Testing prefix...'" Enter
sleep 1

# List all keybindings
echo -e "\n6. Current keybindings:"
tmux list-keys -t test_session | head -20

# Check for conflicts
echo -e "\n7. Checking for potential conflicts..."
echo "   Common issues:"
echo "   - Terminal emulator key conflicts"
echo "   - System-wide shortcuts"
echo "   - Other applications using Ctrl+Space"

# Cleanup
echo -e "\n8. Cleaning up test session..."
tmux kill-session -t test_session

echo -e "\n🔧 TROUBLESHOOTING TIPS:"
echo "=========================="
echo "1. Make sure you're pressing Ctrl+a (not Ctrl+b)"
echo "2. Try: tmux source-file ~/.tmux.conf"
echo "3. Check if your terminal supports the key combinations"
echo "4. Verify TPM plugins are installed: prefix + I"
echo "5. Test in a fresh tmux session: tmux new-session"

echo -e "\n📋 COMMON KEYBINDINGS:"
echo "========================"
echo "Ctrl+a + v        - Vertical split"
echo "Ctrl+a + s        - Horizontal split"
echo "Ctrl+h/j/k/l      - Navigate panes (no prefix needed)"
echo "Ctrl+1-9          - Switch windows (no prefix needed)"
echo "Ctrl+a + n        - New window"
echo "Ctrl+a + q        - Kill pane"
echo "Ctrl+a + Q        - Kill window"
echo "Ctrl+a + z        - Toggle zoom"
echo "Ctrl+a + I        - Install plugins"
echo "• ~/.tmux/tmux-diagnostic.sh - Diagnosticar problemas"
echo ""

echo -e "\n✅ Diagnostic complete!"
EOF
    chmod +x "$HOME/.tmux/tmux-diagnostic.sh"
    
    print_step "Creando script de instalación de plugins..."
    cat > "$HOME/.tmux/install-plugins.sh" << 'EOF'
#!/bin/bash
# Script para instalar plugins de tmux
echo "Instalando plugins de Tmux..."
tmux source-file ~/.tmux.conf
echo "Plugins instalados. Reinicia tmux para aplicar cambios."
EOF
    chmod +x "$HOME/.tmux/install-plugins.sh"
    
    print_success "Tmux configurado con TPM y herramientas de diagnóstico"
    print_info "Para diagnosticar problemas: ~/.tmux/tmux-diagnostic.sh"
    print_info "Para instalar plugins: tmux new-session, luego Ctrl+a + I"
}

# =============================================================================
#                           ✅ FUNCIONES DE VERIFICACIÓN
# =============================================================================

verify_installation() {
    print_section "Verificando instalación..."
    
    local errors=0
    
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
            print_success "✓ $dir existe"
        else
            print_error "✗ $dir falta"
            ((errors++))
        fi
    done
    
    local essential_files=(
        "$HOME/.config/hypr/hyprland.conf"
        "$HOME/.config/fish/config.fish"
        "$HOME/.config/kitty/kitty.conf"
    )
    
    for file in "${essential_files[@]}"; do
        if [ -f "$file" ]; then
            print_success "✓ $file existe"
        else
            print_error "✗ $file falta"
            ((errors++))
        fi
    done
    
    if [ "$SHELL" = "/usr/bin/fish" ]; then
        print_success "✓ Fish es shell por defecto"
    else
        print_warning "⚠ Fish no es shell por defecto (actual: $SHELL)"
    fi
    
    if [ $errors -eq 0 ]; then
        print_success "Todos los componentes esenciales verificados exitosamente"
    else
        print_error "Se encontraron $errors error(es) en la instalación"
    fi
}

verify_kitty_installation() {
    print_section "Verificando instalación de Kitty..."
    
    print_step "Verificando si Kitty está instalado..."
    if command -v kitty >/dev/null 2>&1; then
        print_success "Kitty está instalado: $(kitty --version)"
    else
        print_warning "Kitty no está instalado, intentando instalar..."
        sudo pacman -S kitty --noconfirm --needed
        if command -v kitty >/dev/null 2>&1; then
            print_success "Kitty instalado exitosamente"
        else
            print_error "Falló al instalar Kitty"
        fi
    fi
    
    print_step "Verificando configuración de Kitty..."
    if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
        print_success "Configuración de Kitty encontrada"
    else
        print_warning "Configuración de Kitty no encontrada"
    fi
    
    print_step "Verificando dependencias de Kitty..."
    local kitty_deps=("fontconfig" "libxkbcommon" "libxkbcommon-x11" "libxkbcommon-x11" "libxkbcommon-x11")
    for dep in "${kitty_deps[@]}"; do
        if pacman -Q "$dep" >/dev/null 2>&1; then
            print_success "Dependencia $dep instalada"
        else
            print_warning "Dependencia $dep faltante"
        fi
    done
}

verify_browser_and_notes() {
    print_section "Verificando navegador y aplicación de notas..."
    
    print_step "Verificando Brave..."
    if command -v brave >/dev/null 2>&1; then
        print_success "Brave está instalado: $(brave --version | head -1)"
    else
        print_warning "Brave no está instalado, intentando instalar..."
        sudo pacman -S brave --noconfirm --needed
        if command -v brave >/dev/null 2>&1; then
            print_success "Brave instalado exitosamente"
        else
            print_error "Falló al instalar Brave"
        fi
    fi
    
    print_step "Verificando AppFlowy..."
    if command -v appflowy >/dev/null 2>&1; then
        print_success "AppFlowy está instalado"
    else
        print_warning "AppFlowy no está instalado, intentando instalar desde AUR..."
        yay -S appflowy --noconfirm --needed
        if command -v appflowy >/dev/null 2>&1; then
            print_success "AppFlowy instalado exitosamente"
        else
            print_error "Falló al instalar AppFlowy"
        fi
    fi
    
    print_step "Verificando configuración de navegador por defecto..."
    if [ -f "$HOME/.config/mimeapps.list" ]; then
        if grep -q "x-scheme-handler/http=brave.desktop" "$HOME/.config/mimeapps.list"; then
            print_success "Brave configurado como navegador por defecto"
        else
            print_warning "Brave no está configurado como navegador por defecto"
        fi
    fi
}

install_sddm_and_theme() {
    print_section "Instalando y configurando SDDM con tema NetLogin..."

    # Instalar SDDM si no está instalado
    if ! pacman -Q sddm &>/dev/null; then
        print_step "Instalando SDDM..."
        sudo pacman -S sddm --noconfirm --needed
        print_success "SDDM instalado"
    else
        print_success "SDDM ya está instalado"
    fi

    # Crear directorio de temas si no existe
    local sddm_themes_dir="/usr/share/sddm/themes"
    sudo mkdir -p "$sddm_themes_dir"

    # Extraer y copiar el tema NetLogin
    local netlogin_tar="$DOTFILES_DIR/sddm/NetLogin.tar.gz"
    if [ -f "$netlogin_tar" ]; then
        print_step "Extrayendo tema NetLogin..."
        tmpdir=$(mktemp -d)
        tar -xzf "$netlogin_tar" -C "$tmpdir"
        sudo cp -r "$tmpdir/NetLogin" "$sddm_themes_dir/"
        rm -rf "$tmpdir"
        print_success "Tema NetLogin instalado en $sddm_themes_dir/NetLogin"
    else
        print_warning "No se encontró NetLogin.tar.gz en dotfiles/sddm"
    fi

    # Configurar SDDM para usar NetLogin
    local sddm_conf="/etc/sddm.conf.d/theme.conf"
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=NetLogin" | sudo tee "$sddm_conf" > /dev/null
    print_success "SDDM configurado para usar el tema NetLogin"

    # Habilitar el servicio SDDM
    print_step "Habilitando servicio SDDM..."
    sudo systemctl enable sddm.service
    print_success "Servicio SDDM habilitado"
}

# =====================
# Utilidades adicionales solicitadas por el usuario (sin duplicados, sin zsh ni upscayl)
# =====================
# Oficiales (pacman)
extra_official_packages=(
    xournalpp kubectl remmina bitwarden beekeeper-studio zeal nano figlet toilet fortune-mod cava jenkins lm-studio missioncenter ora hanabi parrot-terminal
)
# AUR (yay)
extra_aur_packages=(
    frog foliate ferdium zen cavalier helix cacher qownnotes zenkit pulsar-bin
)

# Limpiar duplicados de las listas existentes
# (Ejemplo: utility_packages, additional_packages, aur_packages, etc.)
# Eliminar zsh y upscayl de cualquier lista
utility_packages=( $(printf "%s\n" "${utility_packages[@]}" | grep -v -E '^zsh$|^upscayl$' | sort -u) )
additional_packages=( $(printf "%s\n" "${additional_packages[@]}" | grep -v -E '^zsh$|^upscayl$' | sort -u) )

# Instalar paquetes oficiales extra
print_step "Instalando utilidades extra (oficiales)..."
sudo pacman -S "${extra_official_packages[@]}" --noconfirm --needed || print_warning "Algunas utilidades extra fallaron"

# Instalar paquetes de AUR extra según la lista del usuario
if command -v yay >/dev/null; then
    print_step "Instalando utilidades extra de AUR..."
    yay -S --needed \
      kubectl \
      bitwarden \
      remmina \
      qownnotes \
      zeal \
      foliate \
      upscayl \
      mission-center \
      ferdium-bin \
      cavalier \
      cacher \
      beekeeper-studio \
     || print_warning "Algunas utilidades extra de AUR fallaron"
else
    print_warning "yay no está instalado, no se instalarán utilidades extra de AUR"
fi

# =============================================================================
#                           📋 FUNCIÓN PRINCIPAL
# =============================================================================

show_final_info() {
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                                   ║${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo "Próximos pasos:"
    echo "1. Reinicia tu sistema"
    echo "2. Inicia sesión con Hyprland"
    echo ""
    
    echo "Comandos básicos:"
    echo "• SUPER+N - Neovim (Editor por defecto)"
    echo "• SUPER+B - Navegador (Brave)"
    echo "• SUPER+O - AppFlowy (Notas)"
    echo "• SUPER+D - Lanzador de aplicaciones"
    echo "• SUPER+RETURN - Terminal"
    echo "• SUPER+Q - Cerrar ventana"
    echo "• SUPER+SHIFT+W - Wallpaper aleatorio"
    echo ""
    
    echo "📋 Comandos Tmux:"
    echo "• tmux new-session - Iniciar nueva sesión"
    echo "• Ctrl+a + v - División vertical"
    echo "• Ctrl+a + s - División horizontal"
    echo "• Ctrl+h/j/k/l - Navegar entre paneles (sin prefix)"
    echo "• Ctrl+1-9 - Cambiar ventanas (sin prefix)"
    echo "• Ctrl+a + n - Nueva ventana"
    echo "• Ctrl+a + q - Cerrar panel"
    echo "• Ctrl+a + Q - Cerrar ventana"
    echo "• Ctrl+a + z - Alternar zoom"
    echo "• Ctrl+a + I - Instalar plugins"
    echo "• ~/.tmux/tmux-diagnostic.sh - Diagnosticar problemas"
    echo ""
    
    echo "🛡️ Comandos de seguridad:"
    echo "• sudo ufw status - Estado del firewall"
    echo "• sudo ufw allow [puerto] - Permitir puerto"
    echo "• sudo wg-quick up wg0 - Activar WireGuard"
    echo "• sudo wg-quick down wg0 - Desactivar WireGuard"
    echo "• sudo /usr/local/bin/network-monitor.sh - Monitoreo de red"
    echo "• sudo fail2ban-client status - Estado de Fail2ban"
    echo "• sudo freshclam - Actualizar ClamAV"
    echo "• sudo rkhunter --check - Escanear con RKHunter"
    echo ""
    
    echo "Gestión de fuentes:"
    echo "• Coloca fuentes personalizadas en dotfiles/fonts/"
    echo "• Ejecuta ~/.config/scripts/change-font.sh para cambiar fuentes"
    echo "• Usa ~/.config/scripts/change-font.sh --list para ver opciones"
    echo ""
    
    echo "Para instalar más aplicaciones:"
    echo "• sudo pacman -S [paquete]"
    echo "• yay -S [paquete-aur]"
    echo ""
    
    echo "Aplicaciones principales instaladas:"
    echo "• Brave - Navegador web privado y rápido"
    echo "• AppFlowy - Aplicación de notas y productividad"
    echo "• Neovim - Editor de código avanzado"
    echo "• Kitty - Terminal GPU-accelerated"
    echo "• Hyprland - Compositor de ventanas moderno"
    echo ""
    
    echo "Herramientas multimedia instaladas:"
    echo "• LMMS - Linux MultiMedia Studio (producción musical)"
    echo "• Pixelorama - Editor de pixel art"
    echo "• Upscayl - Upscaler de imágenes con IA"
    echo ""
    
    echo "Soporte de imágenes instalado:"
    echo "• Visualización de imágenes en Neovim"
    echo "• Soporte para SVG"
    echo "• Vista previa de Markdown"
    echo ""
    
    echo "🛡️ Herramientas de seguridad instaladas:"
    echo "• UFW - Firewall simple y efectivo"
    echo "• WireGuard - VPN moderna y rápida"
    echo "• Fail2ban - Protección contra ataques"
    echo "• ClamAV - Antivirus"
    echo "• RKHunter - Detección de rootkits"
    echo "• Herramientas de monitoreo de red"
    echo ""
    
    if [ -n "$BACKUP_DIR" ]; then
        echo "Si tenías una configuración anterior, se respaldó en:"
        echo "$BACKUP_DIR"
        echo ""
    fi
}

copy_icons_to_pictures() {
    print_section "Copiando iconos a ~/Pictures/icons..."
    local icons_dir="$HOME/Pictures/icons"
    mkdir -p "$icons_dir"
    if [ -d "$DOTFILES_DIR/icons" ]; then
        cp -r "$DOTFILES_DIR/icons"/* "$icons_dir/"
        print_success "Iconos copiados a $icons_dir"
    else
        print_warning "No se encontró la carpeta de iconos en dotfiles."
    fi
}

# =============================================================================
#                           🖥️  CONFIGURAR BARRAS EN HYPHLAND
# =============================================================================
setup_hyprland_bars() {
    print_section "Configurando inicio automático de Waybar y Polybar en Hyprland..."
    local HYDE_CONFIG="$HOME/.config/hypr/hyde.conf"
    local POLYBAR_SCRIPT="$HOME/github/archriced-1/dotfiles/polybar/launch.sh"

    if [ ! -f "$HYDE_CONFIG" ]; then
        print_warning "No se encontró $HYDE_CONFIG. Saltando configuración de barras."
        return
    fi

    # Habilitar Waybar
    if grep -q "# \$start.BAR=waybar" "$HYDE_CONFIG"; then
        sed -i 's/# \$start.BAR=waybar/\$start.BAR=waybar/' "$HYDE_CONFIG"
        print_success "Waybar habilitado para inicio automático."
    else
        print_info "Waybar ya está habilitado."
    fi

    # Agregar Polybar si no está presente
    if ! grep -q "\$start.POLYBAR" "$HYDE_CONFIG"; then
        sed -i '/\$start.BAR=waybar/a \$start.POLYBAR=$HOME/github/archriced-1/dotfiles/polybar/launch.sh' "$HYDE_CONFIG"
        print_success "Polybar agregado para inicio automático."
    else
        print_info "Polybar ya está configurado."
    fi

    # Dar permisos de ejecución al script de Polybar
    if [ -f "$POLYBAR_SCRIPT" ]; then
        chmod +x "$POLYBAR_SCRIPT"
        print_success "Permisos de ejecución configurados para Polybar."
    else
        print_warning "No se encontró el script de Polybar en $POLYBAR_SCRIPT."
    fi
}

main() {
    print_header
    check_system
    check_dependencies
    update_system
    install_aur_helper
    install_compiler
    install_core_packages
    install_custom_icons_cursors
    install_aur_packages
    install_wayland_components
    install_custom_fonts
    copy_wallpapers
    copy_icons_to_pictures
    configure_hyprlock
    configure_clipboard
    configure_waypaper
    install_grub_theme
    copy_dotfiles
    install_sddm_and_theme
    configure_fish_shell
    configure_system
    configure_firewall
    configure_vpn
    configure_security_tools
    configure_network_monitoring
    configure_tmux
    verify_installation
    verify_kitty_installation
    verify_browser_and_notes
    show_final_info
    setup_hyprland_bars
}

# Ejecutar función principal
main "$@" 
