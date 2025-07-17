#!/bin/bash

# =============================================================================
#                           🚀 ARCH DOTS INSTALLER
# =============================================================================
# Script de instalación unificado y modular para Arch Linux
# Autor: Mauro Infante (maurux01)
# Descripción: Configuración completa del entorno de usuario
# Componentes: Kitty, Neovim, Hyprland, Hyprlock, Tmux, SDDM, wallpapers, fuentes
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
CONFIG_DIR="$HOME/.config"
PICTURES_DIR="$HOME/Pictures"

# Flags para instalación selectiva
INSTALL_ALL=true
INSTALL_KITTY=false
INSTALL_NVIM=false
INSTALL_HYPRLAND=false
INSTALL_HYPRLOCK=false
INSTALL_TMUX=false
INSTALL_SDDM=false
INSTALL_FONTS=false
INSTALL_WALLPAPERS=false
INSTALL_GRUB=false

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}Uso: $0 [OPCIONES]${NC}"
    echo ""
    echo "Opciones:"
    echo "  --all                    Instalar todos los componentes (predeterminado)"
    echo "  --kitty                  Instalar solo Kitty"
    echo "  --nvim                   Instalar solo Neovim"
    echo "  --hyprland              Instalar solo Hyprland"
    echo "  --hyprlock              Instalar solo Hyprlock"
    echo "  --tmux                  Instalar solo Tmux"
    echo "  --sddm                  Instalar solo SDDM"
    echo "  --fonts                 Instalar solo fuentes"
    echo "  --wallpapers            Instalar solo wallpapers"
    echo "  --grub                  Instalar solo GRUB"
    echo "  --help                  Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 --all                # Instalar todo"
    echo "  $0 --kitty --nvim       # Instalar solo Kitty y Neovim"
    echo "  $0 --fonts --wallpapers # Instalar solo fuentes y wallpapers"
}

# Procesar argumentos
process_args() {
    if [ $# -eq 0 ]; then
        return
    fi

    INSTALL_ALL=false
    
    while [ $# -gt 0 ]; do
        case $1 in
            --all)
                INSTALL_ALL=true
                shift
                ;;
            --kitty)
                INSTALL_KITTY=true
                shift
                ;;
            --nvim)
                INSTALL_NVIM=true
                shift
                ;;
            --hyprland)
                INSTALL_HYPRLAND=true
                shift
                ;;
            --hyprlock)
                INSTALL_HYPRLOCK=true
                shift
                ;;
            --tmux)
                INSTALL_TMUX=true
                shift
                ;;
            --sddm)
                INSTALL_SDDM=true
                shift
                ;;
            --fonts)
                INSTALL_FONTS=true
                shift
                ;;
            --wallpapers)
                INSTALL_WALLPAPERS=true
                shift
                ;;
            --grub)
                INSTALL_GRUB=true
                shift
                ;;
            --help)
                show_help
                exit 0
                ;;
            *)
                echo -e "${RED}Error: Opción desconocida $1${NC}"
                show_help
                exit 1
                ;;
        esac
    done
}

# Función para logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

print_header() {
    echo -e "${BLUE} ═════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                 Achriced installer by maurux01             ║${NC}"
    echo -e "${BLUE} ═════════════════════════════════════════════════════════════${NC}"
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

create_backup() {
    if [ -d "$CONFIG_DIR" ] && [ "$(ls -A $CONFIG_DIR 2>/dev/null)" ]; then
        print_section "Creando respaldo de configuración existente..."
        mkdir -p "$BACKUP_DIR"
        cp -r "$CONFIG_DIR"/* "$BACKUP_DIR/" 2>/dev/null || true
        print_success "Respaldo creado en: $BACKUP_DIR"
    fi
}

# =============================================================================
#                           📦 FUNCIONES DE INSTALACIÓN BASE
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

# =============================================================================
#                           🐱 CONFIGURACIÓN DE KITTY
# =============================================================================

install_kitty() {
    print_section "Instalando y configurando Kitty..."

    # Verificar si kitty ya está instalado
    if ! command -v kitty >/dev/null 2>&1; then
        print_step "Instalando Kitty..."
        sudo pacman -S kitty --noconfirm --needed
    else
        print_success "Kitty ya está instalado."
    fi

    # Crear directorios de configuración
    print_step "Creando directorios de configuración..."
    mkdir -p "$CONFIG_DIR/kitty"
    mkdir -p "$CONFIG_DIR/kitty/kitten-scripts"

    # Copiar configuración de Kitty
    if [ -f "$DOTFILES_DIR/kitty/kitty.conf" ]; then
        print_step "Copiando configuración de Kitty..."
        cp "$DOTFILES_DIR/kitty/kitty.conf" "$CONFIG_DIR/kitty/"
        print_success "Configuración de Kitty copiada."
    else
        print_warning "No se encontró kitty.conf en dotfiles."
    fi

    # Copiar scripts de kitten
    if [ -d "$DOTFILES_DIR/kitty/kitten-scripts" ]; then
        print_step "Copiando scripts de kitten..."
        cp -r "$DOTFILES_DIR/kitty/kitten-scripts"/* "$CONFIG_DIR/kitty/kitten-scripts/"
        chmod +x "$CONFIG_DIR/kitty/kitten-scripts"/*.sh
        print_success "Scripts de kitten copiados y permisos configurados."
    else
        print_warning "No se encontró la carpeta kitten-scripts en dotfiles."
    fi

    # Copiar theme-switcher si existe
    if [ -f "$DOTFILES_DIR/kitty/theme-switcher.sh" ]; then
        print_step "Copiando theme-switcher..."
        cp "$DOTFILES_DIR/kitty/theme-switcher.sh" "$CONFIG_DIR/kitty/"
        chmod +x "$CONFIG_DIR/kitty/theme-switcher.sh"
        print_success "Theme-switcher copiado."
    fi

    print_success "Kitty configurado exitosamente."
}

# =============================================================================
#                           📝 CONFIGURACIÓN DE NEOVIM
# =============================================================================

install_nvim() {
    print_section "Instalando y configurando Neovim..."

    # Verificar si neovim ya está instalado
    if ! command -v nvim >/dev/null 2>&1; then
        print_step "Instalando Neovim..."
        sudo pacman -S neovim --noconfirm --needed
    else
        print_success "Neovim ya está instalado."
    fi

    # Crear directorios de configuración
    print_step "Creando directorios de configuración..."
    mkdir -p "$CONFIG_DIR/nvim"
    mkdir -p "$CONFIG_DIR/nvim/lua"
    mkdir -p "$CONFIG_DIR/nvim/lua/config"
    mkdir -p "$CONFIG_DIR/nvim/lua/plugins"

    # Copiar configuración de Neovim
    if [ -d "$DOTFILES_DIR/nvim" ]; then
        print_step "Copiando configuración de Neovim..."
        cp -r "$DOTFILES_DIR/nvim"/* "$CONFIG_DIR/nvim/"
        print_success "Configuración de Neovim copiada."
    else
        print_warning "No se encontró la carpeta nvim en dotfiles."
    fi

    # Instalar plugins de Neovim
    print_step "Instalando plugins de Neovim..."
    nvim --headless -c "Lazy! sync" -c "qa" 2>/dev/null || print_warning "No se pudieron instalar los plugins automáticamente."

    print_success "Neovim configurado exitosamente."
}

# =============================================================================
#                           🖥️ CONFIGURACIÓN DE HYPRLAND
# =============================================================================

install_hyprland() {
    print_section "Instalando y configurando Hyprland..."

    # Verificar si hyprland ya está instalado
    if ! command -v Hyprland >/dev/null 2>&1; then
        print_step "Instalando Hyprland..."
        sudo pacman -S hyprland --noconfirm --needed
    else
        print_success "Hyprland ya está instalado."
    fi

    # Crear directorios de configuración
    print_step "Creando directorios de configuración..."
    mkdir -p "$CONFIG_DIR/hypr"
    mkdir -p "$CONFIG_DIR/hypr/assets"
    mkdir -p "$CONFIG_DIR/hypr/shaders"
    mkdir -p "$CONFIG_DIR/hypr/themes"
    mkdir -p "$CONFIG_DIR/hypr/animations"
    mkdir -p "$CONFIG_DIR/hypr/workflows"

    # Copiar configuración de Hyprland
    if [ -d "$DOTFILES_DIR/hypr" ]; then
        print_step "Copiando configuración de Hyprland..."
        cp -r "$DOTFILES_DIR/hypr"/* "$CONFIG_DIR/hypr/"
        print_success "Configuración de Hyprland copiada."
    else
        print_warning "No se encontró la carpeta hypr en dotfiles."
    fi

    print_success "Hyprland configurado exitosamente."
}

# =============================================================================
#                           🔒 CONFIGURACIÓN DE HYPRLOCK
# =============================================================================

install_hyprlock() {
    print_section "Instalando y configurando Hyprlock Enhanced..."

    # Verificar si hyprlock ya está instalado
    if ! command -v hyprlock >/dev/null 2>&1; then
        print_step "Instalando Hyprlock..."
        sudo pacman -S hyprlock --noconfirm --needed
    else
        print_success "Hyprlock ya está instalado."
    fi

    # Usar el script de instalación mejorado
    if [ -f "$DOTFILES_DIR/scripts/install-hyprlock-enhanced.sh" ]; then
        print_step "Ejecutando instalación mejorada de Hyprlock..."
        "$DOTFILES_DIR/scripts/install-hyprlock-enhanced.sh"
        print_success "Hyprlock Enhanced instalado exitosamente."
    else
        print_warning "Script de instalación mejorada no encontrado, usando instalación básica..."
        
        # Crear directorios de configuración
        print_step "Creando directorios de configuración..."
        mkdir -p "$CONFIG_DIR/hyprlock"
        mkdir -p "$CONFIG_DIR/hyprlock/assets"
        mkdir -p "$CONFIG_DIR/hyprlock/wallpapers"

        # Copiar configuración de Hyprlock
        if [ -d "$DOTFILES_DIR/hyprlock" ]; then
            print_step "Copiando configuración de Hyprlock..."
            cp -r "$DOTFILES_DIR/hyprlock"/* "$CONFIG_DIR/hyprlock/"
            print_success "Configuración de Hyprlock copiada."
        else
            print_warning "No se encontró la carpeta hyprlock en dotfiles."
        fi

        # Copiar scripts de cambio de fondo
        if [ -f "$DOTFILES_DIR/scripts/hyprlock-background.sh" ]; then
            print_step "Instalando script de cambio de fondo..."
            cp "$DOTFILES_DIR/scripts/hyprlock-background.sh" "$CONFIG_DIR/hyprlock/"
            chmod +x "$CONFIG_DIR/hyprlock/hyprlock-background.sh"
            print_success "Script de cambio de fondo instalado."
        fi

        if [ -f "$DOTFILES_DIR/scripts/hyprlock-wallpaper-sync.sh" ]; then
            print_step "Instalando script de sincronización de wallpaper..."
            cp "$DOTFILES_DIR/scripts/hyprlock-wallpaper-sync.sh" "$CONFIG_DIR/hyprlock/"
            chmod +x "$CONFIG_DIR/hyprlock/hyprlock-wallpaper-sync.sh"
            print_success "Script de sincronización instalado."
        fi

        print_success "Hyprlock configurado exitosamente."
    fi
}

# =============================================================================
#                           🎭 CONFIGURACIÓN DE TMUX
# =============================================================================

install_tmux() {
    print_section "Instalando y configurando Tmux..."

    # Verificar si tmux ya está instalado
    if ! command -v tmux >/dev/null 2>&1; then
        print_step "Instalando Tmux..."
        sudo pacman -S tmux --noconfirm --needed
    else
        print_success "Tmux ya está instalado."
    fi

    # Crear directorios de configuración
    print_step "Creando directorios de configuración..."
    mkdir -p "$HOME/.tmux"
    mkdir -p "$HOME/.tmux/plugins"
    mkdir -p "$HOME/.tmux/scripts"

    # Instalar TPM si no está instalado
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        print_step "Instalando TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        print_success "TPM instalado."
    else
        print_success "TPM ya está instalado."
    fi

    # Copiar configuración de Tmux
    if [ -d "$DOTFILES_DIR/tmux" ]; then
        print_step "Copiando configuración de Tmux..."
        if [ -f "$DOTFILES_DIR/tmux/tmux.conf" ]; then
            cp "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
        fi
        if [ -d "$DOTFILES_DIR/tmux/plugins" ]; then
            cp -r "$DOTFILES_DIR/tmux/plugins"/* "$HOME/.tmux/plugins/"
        fi
        if [ -d "$DOTFILES_DIR/tmux/scripts" ]; then
            cp -r "$DOTFILES_DIR/tmux/scripts"/* "$HOME/.tmux/scripts/"
            chmod +x "$HOME/.tmux/scripts/*.sh"
        fi
        print_success "Configuración de Tmux copiada."
    else
        print_warning "No se encontró la carpeta tmux en dotfiles."
        print_step "Creando configuración básica..."
        # Crear configuración básica si no existe
        cat > "$HOME/.tmux.conf" << 'EOF'
# =============================================================================
#                           🎭 TMUX CONFIGURATION
# =============================================================================
# Modern Tmux configuration with TPM plugin management
# =============================================================================

# Plugin manager
set -g @plugintmux-plugins/tpmset -g @plugin tmux-plugins/tmux-sensible'

# Status bar plugins
set -g @plugin tmux-plugins/tmux-batteryset -g @plugin tmux-plugins/tmux-cpuset -g @plugin tmux-plugins/tmux-online-status'

# Navigation plugins
set -g @plugin tmux-plugins/tmux-yankset -g @plugin tmux-plugins/tmux-pain-control'

# Theme
set -g @plugin tmux-plugins/tmux-resurrectset -g @plugin tmux-plugins/tmux-continuum'

# Initialize TPM
run ~/.tmux/plugins/tpm/tpm'
EOF
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
    print_info "Para aplicar configuración: tmux source-file ~/.tmux.conf"
}

# =============================================================================
#                           🖼️ CONFIGURACIÓN DE SDDM
# =============================================================================

install_sddm() {
    print_section "Instalando y configurando SDDM..."

    # Verificar si sddm ya está instalado
    if ! command -v sddm >/dev/null 2>&1; then
        print_step "Instalando SDDM..."
        sudo pacman -S sddm --noconfirm --needed
    else
        print_success "SDDM ya está instalado."
    fi

    # Habilitar SDDM
    print_step "Habilitando SDDM..."
    sudo systemctl enable sddm

    # Crear directorios de configuración
    print_step "Creando directorios de configuración..."
    sudo mkdir -p /etc/sddm.conf.d
    sudo mkdir -p /usr/share/sddm/themes

    # Copiar configuración de SDDM
    if [ -d "$DOTFILES_DIR/sddm" ]; then
        print_step "Copiando configuración de SDDM..."
        sudo cp -r "$DOTFILES_DIR/sddm"/* /etc/sddm.conf.d/ 2>/dev/null || true
        print_success "Configuración de SDDM copiada."
    else
        print_warning "No se encontró la carpeta sddm en dotfiles."
    fi

    print_success "SDDM configurado exitosamente."
}

# =============================================================================
#                           🔤 CONFIGURACIÓN DE FUENTES
# =============================================================================

install_fonts() {
    print_section "Instalando y configurando fuentes..."

    # Instalar fuentes Nerd Font
    print_step "Instalando fuentes Nerd Font..."
    sudo pacman -S nerd-fonts-jetbrains-mono nerd-fonts-complete --noconfirm --needed

    # Crear directorios de fuentes
    print_step "Creando directorios de fuentes..."
    mkdir -p "$HOME/.local/share/fonts"
    mkdir -p "$HOME/.fonts"

    # Copiar fuentes personalizadas
    if [ -d "$DOTFILES_DIR/fonts" ]; then
        print_step "Copiando fuentes personalizadas..."
        cp -r "$DOTFILES_DIR/fonts"/* "$HOME/.local/share/fonts/"
        fc-cache -fv
        print_success "Fuentes personalizadas copiadas y cache actualizado."
    else
        print_warning "No se encontró la carpeta fonts en dotfiles."
    fi

    print_success "Fuentes configuradas exitosamente."
}

# =============================================================================
#                           🖼️ CONFIGURACIÓN DE WALLPAPERS
# =============================================================================

install_wallpapers() {
    print_section "Instalando wallpapers..."

    # Crear directorio de wallpapers
    print_step "Creando directorio de wallpapers..."
    mkdir -p "$PICTURES_DIR/wallpapers"

    # Copiar wallpapers
    if [ -d "$DOTFILES_DIR/wallpapers" ]; then
        print_step "Copiando wallpapers..."
        cp -r "$DOTFILES_DIR/wallpapers"/* "$PICTURES_DIR/wallpapers/"
        print_success "Wallpapers copiados a $PICTURES_DIR/wallpapers"
    else
        print_warning "No se encontró la carpeta wallpapers en dotfiles."
    fi

    print_success "Wallpapers instalados exitosamente."
}

# =============================================================================
#                           🖥️ CONFIGURACIÓN DE GRUB
# =============================================================================

install_grub() {
    print_section "Instalando y configurando GRUB..."

    # Verificar si grub ya está instalado
    if ! command -v grub-install >/dev/null 2>&1; then
        print_step "Instalando GRUB..."
        sudo pacman -S grub efibootmgr --noconfirm --needed
    else
        print_success "GRUB ya está instalado."
    fi

    # Crear backup de configuración original de GRUB
    print_step "Creando backup de configuración original de GRUB..."
    if [ -f /etc/default/grub ]; then
        sudo cp /etc/default/grub /etc/default/grub.backup.$(date +%Y%m%d-%H%M%S)
        print_success "Backup de GRUB creado."
    fi

    # Detectar tipo de sistema (BIOS/UEFI)
    print_step "Detectando tipo de sistema..."
    if [ -d /sys/firmware/efi ]; then
        print_info "Sistema UEFI detectado."
        SYSTEM_TYPE="UEFI"
    else
        print_info "Sistema BIOS detectado."
        SYSTEM_TYPE="BIOS"
    fi

    # Copiar configuración de GRUB desde dotfiles
    if [ -d "$DOTFILES_DIR/grub-themes" ]; then
        print_step "Copiando configuración de GRUB..."
        # Copiar tema de GRUB si existe
        if [ -d "$DOTFILES_DIR/grub-themes/arch-silence-master" ]; then
            print_step "Instalando tema de GRUB..."
            sudo cp -r "$DOTFILES_DIR/grub-themes/arch-silence-master/theme" /boot/grub/themes/arch-silence
            print_success "Tema de GRUB instalado."
        fi

        # Copiar configuración de GRUB
        if [ -f "$DOTFILES_DIR/grub-themes/grub" ]; then
            print_step "Aplicando configuración de GRUB..."
            sudo cp "$DOTFILES_DIR/grub-themes/grub" /etc/default/grub
            print_success "Configuración de GRUB aplicada."
        fi
    else
        print_warning "No se encontró la carpeta grub-themes en dotfiles."
    fi

    # Instalar GRUB según el tipo de sistema
    print_step "Instalando GRUB en el sistema..."
    if [ "$SYSTEM_TYPE" = "UEFI" ]; then
        print_info "Instalando GRUB para UEFI..."
        # Detectar dispositivo EFI
        EFI_PARTITION=$(findmnt -n -o SOURCE /boot/efi 2>/dev/null || echo )
        if [ -n "$EFI_PARTITION" ]; then
            EFI_DEVICE=$(echo $EFI_PARTITION| sed 's/[0-9]*$//')
            print_info "Dispositivo EFI detectado: $EFI_DEVICE"
            sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
        else
            print_warning "No se pudo detectar la partición EFI automáticamente."
            print_info "Instalando GRUB en /boot/efi..."
            sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
        fi
    else
        print_info "Instalando GRUB para BIOS..."
        # Detectar dispositivo de arranque principal
        BOOT_DEVICE=$(lsblk -n -o NAME,MOUNTPOINT | grep "/boot" | head -1awk '{print $1}')
        if [ -n "$BOOT_DEVICE" ]; then
            BOOT_DEVICE=/dev/$BOOT_DEVICE
            print_info "Dispositivo de arranque detectado: $BOOT_DEVICE"
            sudo grub-install --target=i386-pc "$BOOT_DEVICE"
        else
            print_warning "No se pudo detectar el dispositivo de arranque automáticamente."
            print_info "Instalando GRUB en el dispositivo por defecto..."
            sudo grub-install --target=i386-pc /dev/sda
        fi
    fi

    # Generar configuración de GRUB
    print_step "Generando configuración de GRUB..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    if [ $? -eq 0 ]; then
        print_success "Configuración de GRUB generada exitosamente."
    else
        print_error "Error al generar configuración de GRUB."
        return 1
    fi

    print_success "GRUB configurado exitosamente."
    print_info "Tipo de sistema: $SYSTEM_TYPE"
    print_info "Backup de configuración original guardado."
}

# =============================================================================
#                           🔧 CONFIGURACIONES ADICIONALES
# =============================================================================

install_core_packages() {
    print_section "Instalando paquetes core..."

    local terminal_packages=("fish" "starship" "zoxide")
    local system_packages=("bat" "fd" "ripgrep" "fzf" "btop" "exa" "htop" "ncdu" "iotop" "nvtop")
    local media_packages=("pavucontrol" "blueman" "networkmanager" "network-manager-applet" "speedtest-cli" "nmtui" "playerctl" "pamixer" "brightnessctl")
    local dev_packages=("nodejs" "npm" "python" "python-pip" "rust" "go" "jdk-openjdk" "gcc" "cmake" "ninja" "meson" "valgrind" "gdb")
    local docker_packages=("docker" "docker-compose" "podman" "buildah" "skopeo")
    local image_packages=("imagemagick" "ffmpeg" "v4l-utils" "pulseaudio-alsa" "libpng" "libjpeg-turbo" "libwebp" "librsvg" "giflib")
    local capture_packages=("flameshot" "grim" "slurp" "spectacle" "maim" "xclip" "wl-screenshot" "wl-copy" "hyprpicker" "wf-recorder")
    local utility_packages=("lazygit" "lazydocker" "yazi" "feh" "imv" "pcmanfm" "dolphin" "korganizer" "pamac" "polybar" "qalculate-gtk" "gnome-clocks" "w3m" "w3m-img")
    local media_player_packages=("mpv" "vlc" "cava" "oss" "discord" "telegram-desktop" "mpd" "mpc")
    local creation_packages=("obs-studio" "krita" "gimp" "inkscape" "lmms" "pixelorama" "upscayl" "scribus")
    local clipboard_packages=("cliphist" "copyq" "libreoffice" "brave" "vscodium")
    local font_packages=("nerd-fonts-complete" "noto-fonts" "noto-fonts-emoji" "ttf-dejavu" "ttf-liberation" "ttf-jetbrains-mono" "papirus-icon-theme" "bibata-cursor-theme")
    local gaming_packages=("steam" "lutris" "wine" "gamemode" "heroic-games-launcher" "mgba" "snes9x" "fceux")
    local additional_packages=("jq" "curl" "gdm" "atuin" "just" "httpie" "swappy" "swaylock-effects" "hyperlock" "waybar-hyprland" "eww-wayland" "wofi" "mako" "waypaper" "libnotify" "bc")
    local security_packages=("ufw" "wireguard-tools" "openvpn" "networkmanager-openvpn" "networkmanager-vpnc" "networkmanager-pptp" "networkmanager-l2tp" "nmap" "wireshark-qt" "tcpdump" "netcat" "nethogs" "iftop" "fail2ban" "rkhunter" "clamav" "clamav-unofficial-sigs")

    print_step "Instalando paquetes del sistema..."
    sudo pacman -S "${terminal_packages[@]}" "${system_packages[@]}" "${media_packages[@]}" "${dev_packages[@]}" "${utility_packages[@]}" "${additional_packages[@]}" "${security_packages[@]}" "${docker_packages[@]}" "${image_packages[@]}" "${media_player_packages[@]}" "${creation_packages[@]}" "${clipboard_packages[@]}" "${font_packages[@]}" "${gaming_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes fallaron"
    print_step "Instalando paquetes oficiales adicionales..."
    local extra_official_packages=(
        "xournalpp" "kubectl" "remmina" "bitwarden" "beekeeper-studio" "zeal" "nano" "figlet" "toilet" "fortune-mod" "cava" "enkins" "lm-studio" "missioncenter" "ora" "parrot-terminal"
    )
    sudo pacman -S "${extra_official_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes oficiales adicionales fallaron"

    print_step "Instalando paquetes AUR adicionales..."
    local extra_aur_packages=(
        "frog" "foliate" "ferdium" "zen" "cavalier" "helix" "cacher" "qownnotes" "enkit" "pulsar-bin" "spotify"
    )
    if command -v yay >/dev/null 2>&1; then
        yay -S "${extra_aur_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes AUR adicionales fallaron"
    else
        print_warning "yay no está instalado, no se instalarán paquetes AUR adicionales"
    fi

    # Paquetes adicionales solicitados por el usuario
    print_step "Instalando paquetes extra del usuario..."
    local user_extra_packages=(
        "hyprland" "waybar" "eww" "swww" "mako" "swaylock" "grim" "slurp" "xdg-desktop-portal-hyprland" "xdg-desktop-portal-gtk"
    )
    sudo pacman -S "${user_extra_packages[@]}" --noconfirm --needed || print_warning "Algunos paquetes extra del usuario fallaron"

    print_success "Paquetes core instalados."
}

install_aur_packages() {
    print_section "Instalando paquetes AUR..."
    local aur_packages=(
        hyperlockoss" "nerd-fonts-complete oic-games-launcher       pixelorama" upscayl"appflowy"figma-linux"zeal rello"betterdiscord" opentabletdriver" rmpc" spotify-cligemini-cli" "ytui-music    ferdium-bin" "cacher" beekeeper-studio qownnotes enkit" "pulsar-bin       frog" foliatezen"cavalier" helix )

    print_step "Instalando paquetes AUR..."
    for pkg in "${aur_packages[@]}"; do
        print_step "Instalando $pkg..."
        yay -S $pkg --noconfirm --needed || print_warning "$pkg no se pudo instalar"
    done

    print_success "Paquetes AUR instalados."
}

configure_fish_shell() {
    print_section "Configurando Fish shell..."

    # Verificar si fish está instalado
    if ! command -v fish >/dev/null 2>&1; then
        print_step "Instalando Fish..."
        sudo pacman -S fish --noconfirm --needed
    fi

    # Copiar configuración de Fish
    if [ -f "$DOTFILES_DIR/fish/config.fish" ]; then
        print_step "Copiando configuración de Fish..."
        mkdir -p "$CONFIG_DIR/fish"
        cp "$DOTFILES_DIR/fish/config.fish" "$CONFIG_DIR/fish/"
        print_success "Configuración de Fish copiada."
    fi

    # Cambiar shell por defecto a fish
    if [ "$SHELL" != "/usr/bin/fish" ]; then
        print_step "Cambiando shell por defecto a Fish..."
        chsh -s /usr/bin/fish
        print_success "Shell cambiado a Fish."
    fi

    print_success "Fish shell configurado exitosamente."
}

configure_system() {
    print_section "Configurando sistema..."

    # Configurar permisos de audio
    print_step "Configurando permisos de audio..."
    sudo usermod -a -G audio "$USER"

    # Configurar NetworkManager
    print_step "Configurando NetworkManager..."
    sudo systemctl enable NetworkManager

    print_success "Sistema configurado exitosamente."
}

# =============================================================================
#                           ✅ VERIFICACIÓN FINAL
# =============================================================================

verify_installation() {
    print_section "Verificando instalación..."

    local errors=0
    local components=()

    # Verificar componentes instalados
    if $INSTALL_KITTY || $INSTALL_ALL; then
        if [ -f "$CONFIG_DIR/kitty/kitty.conf" ]; then
            print_success "✓ Kitty configurado"
            components+=("Kitty")
        else
            print_error "✗ Kitty no configurado"
            ((errors++))
        fi
    fi

    if $INSTALL_NVIM || $INSTALL_ALL; then
        if [ -f "$CONFIG_DIR/nvim/init.lua" ]; then
            print_success "✓ Neovim configurado"
            components+=("Neovim")
        else
            print_error "✗ Neovim no configurado"
            ((errors++))
        fi
    fi

    if $INSTALL_HYPRLAND || $INSTALL_ALL; then
        if [ -d "$CONFIG_DIR/hypr" ]; then
            print_success "✓ Hyprland configurado"
            components+=("Hyprland")
        else
            print_error "✗ Hyprland no configurado"
            ((errors++))
        fi
    fi

    if $INSTALL_TMUX || $INSTALL_ALL; then
        if [ -f "$HOME/.tmux.conf" ]; then
            print_success "✓ Tmux configurado"
            components+=("Tmux")
        else
            print_error "✗ Tmux no configurado"
            ((errors++))
        fi
    fi

    if $INSTALL_FONTS || $INSTALL_ALL; then
        if fc-list | grep -q "JetBrainsMono"; then
            print_success "✓ Fuentes instaladas"
            components+=("Fuentes")
        else
            print_error "✗ Fuentes no instaladas"
            ((errors++))
        fi
    fi

    if $INSTALL_WALLPAPERS || $INSTALL_ALL; then
        if [ -d "$PICTURES_DIR/wallpapers" ]; then
            print_success "✓ Wallpapers instalados"
            components+=("Wallpapers")
        else
            print_error "✗ Wallpapers no instalados"
            ((errors++))
        fi
    fi

    if [ $errors -eq 0 ]; then
        print_success "Todos los componentes verificados exitosamente"
    else
        print_error "Se encontraron $errors error(es) en la instalación"
    fi
}

show_final_info() {
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                                   ║${NC}"
    echo -e "${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo "Próximos pasos:"
    echo "1. Reinicia tu sistema"
    echo "2. Inicia sesión con Hyprland"
    echo ""

    echo "Comandos útiles:"
    echo "• kitty --config ~/.config/kitty/kitty.conf"
    echo "• nvim --version"
    echo "• tmux new-session"
    echo "• hyprctl monitors"
    echo "• Configuración: ~/.tmux.conf"
    echo "• Scripts: ~/.tmux/scripts/"
    echo "• Plugins: ~/.tmux/plugins/"
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
    echo "• Neovim - Editor de código avanzado"
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

    echo "🔒 Hyprlock Enhanced (Pantalla de bloqueo):"
    echo "• SUPER+L - Bloquear pantalla"
    echo "• SUPER+SHIFT+B - Selector de imágenes interactivo"
    echo "• SUPER+SHIFT+W - Usar wallpaper del sistema"
    echo "• SUPER+SHIFT+A - Habilitar auto-sync"
    echo "• SUPER+SHIFT+P - Selector de imágenes interactivo"
    echo "• SUPER+SHIFT+R - Imagen aleatoria desde Pictures"
    echo "• SUPER+SHIFT+T - Tema predefinido aleatorio"
    echo "• ~/.config/hyprlock/hyprlock-image-manager.sh --picker - Selector interactivo"
    echo "• ~/.config/hyprlock/hyprlock-image-manager.sh --random - Imagen aleatoria"
    echo "• ~/.config/hyprlock/hyprlock-image-manager.sh --search term - Buscar imágenes"
    echo "• ~/.config/hyprlock/hyprlock-image-manager.sh --theme mocha - Usar tema específico"
    echo "• ~/.config/hyprlock/hyprlock-image-manager.sh --wallpaper - Usar wallpaper del sistema"
    echo "• ~/.config/hyprlock/hyprlock-image-manager.sh --auto-sync - Habilitar auto-sync"
    echo "• ~/.config/hyprlock/hyprlock-image-manager.sh --list - Listar todas las imágenes"
    echo "• Configuración: ~/.config/hyprlock/hyprlock.conf"
    echo "• Fondos disponibles: ~/.config/hyprlock/assets/"
    echo "• Wallpapers personalizados: ~/.config/hyprlock/wallpapers/"
    echo "• Script de prueba: ~/.config/hyprlock/test-hyprlock-enhanced.sh"
    echo "• Demo del gestor: ./dotfiles/scripts/demo-image-manager.sh"
    echo ""

    if [ -n "$BACKUP_DIR" ]; then
        echo "Respaldo de configuración anterior:"
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

# =============================================================================
#                           🚀 FUNCIÓN PRINCIPAL
# =============================================================================

main() {
    print_header
    
    # Procesar argumentos
    process_args "$@"
    
    # Verificaciones iniciales
    check_system
    check_dependencies
    
    # Crear respaldo si es necesario
    create_backup
    
    # Instalación base
    update_system
    install_aur_helper
    install_compiler
    install_core_packages
    install_aur_packages
    
    # Crear carpetas de imágenes e íconos si no existen
    echo "✔️ Creando carpeta wallpapers..."
    mkdir -p "$HOME/Pictures/wallpapers"
    echo "✔️ Creando carpeta icons..."
    mkdir -p "$HOME/Pictures/icons"

    # Copiar íconos desde dotfiles/icons a ~/Pictures/icons (sobrescribe todo)
    if [ -d "$DOTFILES_DIR/icons" ]; then
        echo "📁 Copiando íconos..."
        cp -rf "$DOTFILES_DIR/icons/"* "$HOME/Pictures/icons/"
        print_success "✅ Archivos de íconos reemplazados correctamente en $HOME/Pictures/icons"
    else
        print_warning "No se encontró la carpeta de íconos en $DOTFILES_DIR/icons."
    fi

    # Copiar íconos desde dotfiles/neofetch/Icons a ~/Pictures/icons (sobrescribe todo)
    if [ -d "$DOTFILES_DIR/neofetch/Icons" ]; then
        echo "📁 Copiando íconos de Neofetch..."
        cp -rf "$DOTFILES_DIR/neofetch/Icons/"* "$HOME/Pictures/icons/"
        print_success "✅ Archivos de íconos de Neofetch reemplazados correctamente en $HOME/Pictures/icons"
    else
        print_warning "No se encontró la carpeta de íconos de Neofetch en $DOTFILES_DIR/neofetch/Icons."
    fi

    # Copiar wallpapers desde dotfiles/wallpapers a ~/Pictures/wallpapers (sobrescribe todo)
    if [ -d "$DOTFILES_DIR/wallpapers" ]; then
        echo "📁 Copiando wallpapers..."
        cp -rf "$DOTFILES_DIR/wallpapers/"* "$HOME/Pictures/wallpapers/"
        print_success "✅ Archivos de wallpapers reemplazados correctamente en $HOME/Pictures/wallpapers"
    else
        print_warning "No se encontró la carpeta de wallpapers en $DOTFILES_DIR/wallpapers."
    fi

    # Dar permisos de ejecución al script de fetch con icono
    chmod +x dotfiles/scripts/fetch_with_icon.sh

    # Instalación de componentes específicos
    if $INSTALL_KITTY || $INSTALL_ALL; then
        install_kitty
    fi
    
    if $INSTALL_NVIM || $INSTALL_ALL; then
        install_nvim
    fi
    
    if $INSTALL_HYPRLAND || $INSTALL_ALL; then
        install_hyprland
    fi
    
    if $INSTALL_HYPRLOCK || $INSTALL_ALL; then
        install_hyprlock
    fi
    
    if $INSTALL_TMUX || $INSTALL_ALL; then
        install_tmux
    fi
    
    if $INSTALL_SDDM || $INSTALL_ALL; then
        install_sddm
    fi
    
    if $INSTALL_FONTS || $INSTALL_ALL; then
        install_fonts
    fi
    
    if $INSTALL_WALLPAPERS || $INSTALL_ALL; then
        install_wallpapers
    fi
    
    # Instalar GRUB (solo si se solicita explícitamente o en instalación completa)
    if $INSTALL_GRUB || $INSTALL_ALL; then
        install_grub
    fi
    
    # Configuraciones adicionales
    configure_fish_shell
    configure_system
    
    # Verificación final
    verify_installation
    show_final_info
    setup_hyprland_bars
}

# Ejecutar función principal
main "$@"
