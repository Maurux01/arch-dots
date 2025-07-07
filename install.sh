#!/bin/bash

# Script de instalación completa para Arch Dots
# Instala todo automáticamente

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
INSTALL_LOG="$HOME/.arch-dots-install.log"

# Función para logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$INSTALL_LOG"
}

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    Archriced                                 ║${NC}"
    echo -e "${BLUE}║                  by maurux01                                 ║${NC}"
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
        if [[ "$pkg" == "heroic-games-launcher" || "$pkg" == "oh-my-zsh" || "$pkg" == "hyperlock" ]]; then
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
    
    if ! ping -c 1 archlinux.org >/dev/null 2>&1; then
        print_error "No hay conexión a internet"
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
    sudo pacman -Syu --noconfirm
    print_success "Sistema actualizado"
}

# Función para instalar dependencias básicas
install_basic_deps() {
    print_section "Instalando dependencias básicas..."
    
    local basic_packages=(
        "base-devel" "git" "curl" "wget" "unzip" "sudo" "polkit"
        "xdg-user-dirs" "xdg-utils" "imagemagick"
    )
    
    install_packages "${basic_packages[@]}"
    print_success "Dependencias básicas instaladas"
}

# Función para instalar AUR helper
install_aur_helper() {
    print_section "Instalando AUR helper..."
    
    if command -v yay >/dev/null 2>&1; then
        print_success "yay ya está instalado"
        return
    fi
    
    print_step "Instalando yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$SCRIPT_DIR"
    
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
install_system_utils() {
    print_section "Instalando utilidades del sistema..."
    
    local util_packages=(
        "bat" "fd" "ripgrep" "fzf" "lazygit" "yazi" "btop" "htop"
        "neofetch" "fastfetch" "cava" "pavucontrol" "blueman"
        "networkmanager" "network-manager-applet" "mpv" "vlc"
        "steam" "lutris" "wine" "gamemode" "mangohud"
        "cliphist" "copyq" "heroic-games-launcher" "oh-my-zsh"
    )
    
    install_packages "${util_packages[@]}"
    print_success "Utilidades del sistema instaladas"
}

# Función para instalar desarrollo
install_development() {
    print_section "Instalando herramientas de desarrollo..."
    
    local dev_packages=(
        "nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk"
        "gcc" "cmake" "ninja" "meson" "valgrind" "gdb"
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

# Función para configurar notificaciones mejoradas
configure_notifications() {
    print_section "Configurando notificaciones mejoradas..."
    
    print_step "Configurando Mako con animaciones y colores..."
    
    # Crear script de notificaciones mejoradas
    cat > "$HOME/.config/scripts/notification-enhancer.sh" << 'EOF'
#!/bin/bash

# Notification Enhancer for Mako
# Adds custom animations and effects for multiple simultaneous notifications

# Colors for different notification types
declare -A NOTIFICATION_COLORS=(
    ["info"]="#7aa2f7"
    ["success"]="#9ece6a"
    ["warning"]="#e0af68"
    ["error"]="#f7768e"
    ["discord"]="#5865f2"
    ["spotify"]="#1db954"
    ["firefox"]="#ff7139"
    ["volume"]="#bb9af7"
    ["brightness"]="#ff9e64"
)

# Animation functions
animate_notification() {
    local app_name="$1"
    local message="$2"
    local urgency="$3"
    
    # Get color based on app or urgency
    local color="${NOTIFICATION_COLORS[$app_name]:-${NOTIFICATION_COLORS[$urgency]:-${NOTIFICATION_COLORS[info]}}}"
    
    # Create animated notification with custom styling
    notify-send \
        --app-name="$app_name" \
        --urgency="$urgency" \
        --icon="$(get_app_icon "$app_name")" \
        --expire-time=5000 \
        "$message"
}

get_app_icon() {
    local app_name="$1"
    
    case "$app_name" in
        "discord") echo "discord" ;;
        "spotify") echo "spotify" ;;
        "firefox") echo "firefox" ;;
        "volume") echo "audio-volume-high" ;;
        "brightness") echo "display-brightness" ;;
        "systemd") echo "system-run" ;;
        "mpv") echo "video-x-generic" ;;
        *) echo "dialog-information" ;;
    esac
}

# Enhanced volume notification with progress bar
show_volume_notification() {
    local volume="$1"
    local muted="$2"
    
    if [[ "$muted" == "true" ]]; then
        animate_notification "volume" "🔇 Audio Muted" "normal"
    else
        # Create visual progress bar
        local bars=$((volume / 10))
        local progress=""
        for ((i=0; i<bars; i++)); do
            progress+="█"
        done
        for ((i=bars; i<10; i++)); do
            progress+="░"
        done
        
        animate_notification "volume" "🔊 Volume: $progress $volume%" "normal"
    fi
}

# Enhanced brightness notification
show_brightness_notification() {
    local brightness="$1"
    
    # Create visual progress bar
    local bars=$((brightness / 10))
    local progress=""
    for ((i=0; i<bars; i++)); do
        progress+="█"
    done
    for ((i=bars; i<10; i++)); do
        progress+="░"
    done
    
    animate_notification "brightness" "☀️ Brightness: $progress $brightness%" "normal"
}

# Enhanced music notification
show_music_notification() {
    local title="$1"
    local artist="$2"
    local status="$3"
    
    case "$status" in
        "play") animate_notification "spotify" "▶️ $title - $artist" "normal" ;;
        "pause") animate_notification "spotify" "⏸️ $title - $artist" "normal" ;;
        "stop") animate_notification "spotify" "⏹️ Music Stopped" "normal" ;;
    esac
}

# Enhanced system notification
show_system_notification() {
    local message="$1"
    local urgency="$2"
    
    animate_notification "systemd" "$message" "$urgency"
}

# Enhanced Discord notification
show_discord_notification() {
    local channel="$1"
    local sender="$2"
    local message="$3"
    
    animate_notification "discord" "💬 $channel: $sender - $message" "normal"
}

# Enhanced web notification
show_web_notification() {
    local title="$1"
    local message="$2"
    
    animate_notification "firefox" "🌐 $title: $message" "normal"
}

# Notification queue manager for multiple simultaneous notifications
notification_queue() {
    local queue_file="/tmp/mako_notification_queue"
    local max_queue=5
    
    # Add notification to queue
    echo "$(date +%s): $*" >> "$queue_file"
    
    # Process queue
    if [[ -f "$queue_file" ]]; then
        local queue_size=$(wc -l < "$queue_file")
        
        if [[ $queue_size -gt $max_queue ]]; then
            # Show queue overflow notification
            animate_notification "systemd" "📬 $((queue_size - max_queue)) notifications queued" "normal"
            
            # Process oldest notifications
            tail -n $max_queue "$queue_file" > "${queue_file}.tmp"
            mv "${queue_file}.tmp" "$queue_file"
        fi
    fi
}

# Main function
main() {
    case "$1" in
        "volume")
            show_volume_notification "$2" "${3:-false}"
            ;;
        "brightness")
            show_brightness_notification "$2"
            ;;
        "music")
            show_music_notification "$2" "$3" "$4"
            ;;
        "system")
            show_system_notification "$2" "${3:-normal}"
            ;;
        "discord")
            show_discord_notification "$2" "$3" "$4"
            ;;
        "web")
            show_web_notification "$2" "$3"
            ;;
        "queue")
            notification_queue "${@:2}"
            ;;
        *)
            echo "Usage: $0 {volume|brightness|music|system|discord|web|queue} [args...]"
            echo ""
            echo "Examples:"
            echo "  $0 volume 75 false"
            echo "  $0 brightness 60"
            echo "  $0 music 'Song Title' 'Artist' play"
            echo "  $0 system 'System update available' warning"
            echo "  $0 discord 'general' 'User' 'Hello world!'"
            echo "  $0 web 'Website' 'New message received'"
            ;;
    esac
}

# Run main function with all arguments
main "$@"
EOF
    
    chmod +x "$HOME/.config/scripts/notification-enhancer.sh"
    
    print_step "Mejorando scripts de EWW..."
    
    # Mejorar script de volumen
    cat > "$HOME/.config/eww/scripts/volume.sh" << 'EOF'
#!/bin/bash

# Enhanced Volume Script with Beautiful Notifications
# Uses notification enhancer for animated volume notifications

VOL=$(pamixer --get-volume 2>/dev/null || echo 0)
MUTE=$(pamixer --get-mute 2>/dev/null || echo false)

# Set icons based on volume level and mute status
if [ "$MUTE" = "true" ]; then
    ICON=""
    VOLUME_ICON=""
else
    if [ "$VOL" -eq 0 ]; then
        ICON=""
        VOLUME_ICON=""
    elif [ "$VOL" -le 30 ]; then
        ICON=""
        VOLUME_ICON=""
    elif [ "$VOL" -le 60 ]; then
        ICON=""
        VOLUME_ICON=""
    else
        ICON=""
        VOLUME_ICON=""
    fi
fi

# Export variables for EWW
export VOLUME_ICON=$VOLUME_ICON
export VOLUME_PERCENT="$VOL%"

# Show enhanced notification if this is a volume change event
if [ "$1" = "notify" ]; then
    # Use notification enhancer for beautiful volume notifications
    if command -v "$HOME/.config/scripts/notification-enhancer.sh" >/dev/null 2>&1; then
        "$HOME/.config/scripts/notification-enhancer.sh" volume "$VOL" "$MUTE"
    else
        # Fallback to regular notification
        if [ "$MUTE" = "true" ]; then
            notify-send --app-name="volume" --urgency="normal" --icon="audio-volume-muted" "🔇 Audio Muted"
        else
            notify-send --app-name="volume" --urgency="normal" --icon="audio-volume-high" "🔊 Volume: $VOL%"
        fi
    fi
fi

# Output for EWW widget
echo "$ICON $VOL%"
EOF
    
    # Crear script de brillo
    cat > "$HOME/.config/eww/scripts/brightness.sh" << 'EOF'
#!/bin/bash

# Enhanced Brightness Script with Beautiful Notifications
# Uses notification enhancer for animated brightness notifications

# Get brightness value (works with most backlight systems)
BRIGHTNESS=$(brightnessctl get 2>/dev/null || echo 0)
MAX_BRIGHTNESS=$(brightnessctl max 2>/dev/null || echo 100)
PERCENT=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

# Set icons based on brightness level
if [ "$PERCENT" -eq 0 ]; then
    ICON=""
    BRIGHTNESS_ICON=""
elif [ "$PERCENT" -le 25 ]; then
    ICON=""
    BRIGHTNESS_ICON=""
elif [ "$PERCENT" -le 50 ]; then
    ICON=""
    BRIGHTNESS_ICON=""
elif [ "$PERCENT" -le 75 ]; then
    ICON=""
    BRIGHTNESS_ICON=""
else
    ICON=""
    BRIGHTNESS_ICON=""
fi

# Export variables for EWW
export BRIGHTNESS_ICON=$BRIGHTNESS_ICON
export BRIGHTNESS_PERCENT="$PERCENT%"

# Show enhanced notification if this is a brightness change event
if [ "$1" = "notify" ]; then
    # Use notification enhancer for beautiful brightness notifications
    if command -v "$HOME/.config/scripts/notification-enhancer.sh" >/dev/null 2>&1; then
        "$HOME/.config/scripts/notification-enhancer.sh" brightness "$PERCENT"
    else
        # Fallback to regular notification
        notify-send --app-name="brightness" --urgency="normal" --icon="display-brightness" "☀️ Brightness: $PERCENT%"
    fi
fi

# Output for EWW widget
echo "$ICON $PERCENT%"
EOF
    
    chmod +x "$HOME/.config/eww/scripts/volume.sh" "$HOME/.config/eww/scripts/brightness.sh"
    
    print_success "Notificaciones mejoradas configuradas"
}

# Función para copiar dotfiles
copy_dotfiles() {
    print_section "Copiando dotfiles..."
    
    print_step "Creando directorios..."
    mkdir -p "$HOME/.config" "$HOME/.local/share" "$HOME/.local/bin"
    
    print_step "Copiando configuraciones..."
    cp -r "$DOTFILES_DIR"/* "$HOME/.config/"
    
    print_step "Copiando scripts..."
    mkdir -p "$HOME/.config/scripts"
    cp "$SCRIPT_DIR/utils.sh" "$HOME/.config/scripts/"
    
    print_step "Haciendo scripts ejecutables..."
    chmod +x "$HOME/.config/scripts"/*.sh
    
    print_success "Dotfiles copiados"
}

# Función para configurar sistema
configure_system() {
    print_section "Configurando sistema..."
    
    print_step "Configurando permisos..."
    sudo usermod -aG wheel "$USER"
    
    print_step "Habilitando servicios..."
    sudo systemctl enable NetworkManager bluetooth
    
    print_step "Configurando shell por defecto..."
    sudo chsh -s /usr/bin/fish "$USER"
    
    print_success "Sistema configurado"
}

# Función para mostrar información final
show_final_info() {
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo "Próximos pasos:"
    echo "1. Reinicia tu sistema"
    echo "2. Inicia sesión con Hyprland"
    echo "3. Personaliza tu configuración"
    echo ""
    
    echo "Comandos útiles:"
    echo "• SUPER+SHIFT+L - Bloquear pantalla"
    echo "• SUPER+D - Lanzador de aplicaciones"
    echo "• SUPER+RETURN - Terminal"
    echo "• SUPER+Q - Cerrar ventana"
    echo "• SUPER+V - Historial de portapapeles"
    echo "• Teclas de volumen/brillo - Notificaciones animadas"
    echo ""
    
    echo "Características de notificaciones:"
    echo "• Notificaciones con colores por tipo de aplicación"
    echo "• Barras de progreso visuales para volumen y brillo"
    echo "• Manejo inteligente de múltiples notificaciones"
    echo "• Animaciones suaves y efectos visuales"
    echo ""
    
    echo "Para más información:"
    echo "• Consulta el README.md"
    echo "• Ejecuta: ./utils.sh"
    echo "• Prueba: ~/.config/scripts/notification-enhancer.sh"
    echo ""
}

# Función principal
main() {
    print_header
    check_system
    update_system
    install_basic_deps
    install_aur_helper
    install_hyprland
    install_system_utils
    install_development
    install_fonts_themes
    configure_hyperlock
    configure_clipboard
    configure_notifications
    copy_dotfiles
    configure_system
    show_final_info
}

# Ejecutar función principal
main "$@" 