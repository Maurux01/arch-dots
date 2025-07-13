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

install_core_packages() {
    print_section "Instalando paquetes core..."
    
    local core_packages=(
        # Hyprland y componentes
        "hyprland" "waybar" "eww" "swww" "wofi" "mako" "swaylock"
        "swayidle" "grim" "slurp" "wl-clipboard" "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk"
        
        # Terminal y shell
        "kitty" "fish" "starship" "zoxide" "tmux"
        
        # Editores
        "neovim"
        
        # Utilidades del sistema
        "bat" "fd" "ripgrep" "fzf" "btop" "exa" "htop" "ncdu" "iotop" "nvtop"
        "pavucontrol" "blueman" "networkmanager" "network-manager-applet"
        "speedtest-cli" "nmtui" "playerctl" "pamixer" "brightnessctl"
        
        # Herramientas de desarrollo
        "nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk"
        "gcc" "cmake" "ninja" "meson" "valgrind" "gdb"
        "docker" "docker-compose" "podman" "buildah" "skopeo"
        
        # Herramientas de imagen y multimedia
        "imagemagick" "ffmpeg" "v4l-utils" "pulseaudio-alsa"
        "libpng" "libjpeg-turbo" "libwebp" "librsvg" "giflib"
        
        # Herramientas de captura de pantalla
        "flameshot" "grim" "slurp" "spectacle" "maim" "xclip"
        
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
        
        # Herramientas de seguridad y red
        "ufw" "wireguard-tools" "openvpn" "networkmanager-openvpn"
        "networkmanager-vpnc" "networkmanager-pptp" "networkmanager-l2tp"
        "nmap" "wireshark-qt" "tcpdump" "netcat" "nethogs" "iftop"
        "fail2ban" "rkhunter" "clamav" "clamav-unofficial-sigs"
    )
    
    print_step "Instalando paquetes oficiales..."
    sudo pacman -S "${core_packages[@]}" --noconfirm --needed
    
    print_success "Paquetes core instalados."
}

install_aur_packages() {
    print_section "Instalando paquetes AUR..."
    
    local aur_packages=(
        "hyperlock" "oss" "nerd-fonts-complete" "heroic-games-launcher"
        "pixelorama" "upscayl" "citra-git"
    )
    
    for pkg in "${aur_packages[@]}"; do
        print_step "Instalando $pkg..."
        yay -S "$pkg" --noconfirm --needed
    done
    
    print_success "Paquetes AUR instalados."
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
    print_section "Instalando tema GRUB Catppuccin..."
    
    print_step "Clonando repositorio Catppuccin GRUB..."
    cd /tmp
    git clone https://github.com/catppuccin/grub.git catppuccin-grub
    cd catppuccin-grub
    
    print_step "Instalando tema GRUB..."
    sudo cp -r src/catppuccin-grub-theme /usr/share/grub/themes/
    
    print_step "Configurando GRUB..."
    sudo cp /etc/default/grub /etc/default/grub.backup
    
    sudo sed -i 's/GRUB_THEME=.*/GRUB_THEME="\/usr\/share\/grub\/themes\/catppuccin-grub-theme\/theme.txt"/' /etc/default/grub
    
    print_step "Actualizando GRUB..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    print_step "Limpiando archivos temporales..."
    cd "$SCRIPT_DIR"
    rm -rf /tmp/catppuccin-grub
    
    print_success "Tema GRUB Catppuccin instalado"
    print_warning "Reinicia el sistema para ver el nuevo tema GRUB"
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
                        
                        if git clone https://github.com/Maurux01/NVimX.git "$HOME/.config/nvim" 2>/dev/null; then
                            print_success "NVimX clonado exitosamente"
                            rm -rf "$HOME/.config/nvim/.git"
                            print_step "Instalando plugins de Neovim..."
                            nvim --headless -c "Lazy! sync" -c "quit" 2>/dev/null || true
                            print_success "Plugins de Neovim instalados"
                        else
                            print_error "Falló al instalar NVimX"
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
                        print_step "Copiando configuración Tmux..."
                        if [ -f "$item/.tmux.conf" ]; then
                            cp "$item/.tmux.conf" "$HOME/.tmux.conf"
                            print_success "Configuración Tmux copiada a $HOME/.tmux.conf"
                            
                            mkdir -p "$HOME/.tmux"
                            
                            print_step "Instalando plugin Catppuccin tmux..."
                            mkdir -p ~/.config/tmux/plugins/catppuccin
                            if git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux 2>/dev/null; then
                                print_success "Plugin Catppuccin tmux instalado"
                            else
                                print_warning "Falló al instalar plugin Catppuccin tmux"
                            fi
                        else
                            print_error "Archivo de configuración Tmux no encontrado"
                        fi
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
    echo "• SUPER+D - Lanzador de aplicaciones"
    echo "• SUPER+RETURN - Terminal"
    echo "• SUPER+Q - Cerrar ventana"
    echo "• SUPER+SHIFT+W - Wallpaper aleatorio"
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

main() {
    print_header
    check_system
    check_dependencies
    update_system
    install_aur_helper
    install_core_packages
    install_aur_packages
    install_custom_fonts
    copy_wallpapers
    configure_hyprlock
    configure_clipboard
    configure_waypaper
    install_grub_theme
    copy_dotfiles
    configure_fish_shell
    configure_system
    configure_firewall
    configure_vpn
    configure_security_tools
    configure_network_monitoring
    verify_installation
    show_final_info
}

# Ejecutar función principal
main "$@" 
