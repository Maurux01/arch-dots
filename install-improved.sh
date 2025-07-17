#!/bin/bash

# =============================================================================
#                           🚀 ARCH DOTS INSTALLER - MEJORADO
# =============================================================================
# Script de instalación unificado y modular para Arch Linux
# Autor: Mauro Infante (maurux1escripción: Configuración completa del entorno de usuario
# Componentes: Kitty, Neovim, Hyprland, Hyprlock, Tmux, SDDM, wallpapers, fuentes
# =============================================================================

set -e

# Colores para output
RED=undefined0330;31
GREEN='\033;32m'
YELLOW='\331;33mBLUE='\330;34mCYAN='\033;36m'
PURPLE=03305m'
NC='\033# Variables globales
SCRIPT_DIR="$(cd $(dirname $[object Object]BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
BACKUP_DIR="$HOME/.archriced-backup-$(date +%Y%m%d-%H%M%S)"
LOG_FILE="$HOME/.archriced-install.log"
CONFIG_DIR="$HOME/.config"
PICTURES_DIR=$HOME/Pictures"

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

# Función para mostrar ayuda
show_help() {
    echo -e${BLUE}Uso: $0 [OPCIONES]${NC}"
    echo ""
    echo "Opciones:"
    echo "  --all                    Instalar todos los componentes (predeterminado)"
    echo "  --kitty                  Instalar solo Kitty    echo "  --nvim                   Instalar solo Neovim    echo "  --hyprland              Instalar solo Hyprland    echo "  --hyprlock              Instalar solo Hyprlock    echo "  --tmux                  Instalar solo Tmux"
    echo "  --sddm                  Instalar solo SDDM"
    echo "  --fonts                 Instalar solo fuentes"
    echo "  --wallpapers            Instalar solo wallpapers"
    echo "  --help                  Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 --all                # Instalar todo"
    echo  $0 --kitty --nvim       # Instalar solo Kitty y Neovim"
    echo "  $0 --fonts --wallpapers # Instalar solo fuentes y wallpapers"
}

# Procesar argumentos
process_args() {
    if  $# -eq0hen
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
            --help)
                show_help
                exit0               ;;
            *)
                echo -e "${RED}Error: Opción desconocida $1${NC}"
                show_help
                exit1               ;;
        esac
    done
}

# Función para logging
log() {
    echo [$(date +%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

print_header() {
    echo -e ${BLUE} ═════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                    🚀 ARCH DOTS INSTALLER                   ║${NC}"
    echo -e "${BLUE}║                    by maurux01                              ║${NC}"
    echo -e "${BLUE}║                    Instalación unificada                    ║${NC}"
    echo -e ${BLUE} ════════════════════════════════════════════════════════════${NC}"
}

print_section() {
    echo -e "${CYAN}› $1${NC}"
    log "SECTION: $1"
}

print_step() {
    echo -e ${YELLOW}  → $1${NC}
    log "STEP: $1"
}

print_success() {
    echo -e${GREEN}  ✓ $1${NC}
    log "SUCCESS: $1"
}

print_error() {
    echo -e${RED}  ✗ $1${NC}"
    log "ERROR: $1"
}

print_warning() {
    echo -e ${YELLOW}  ⚠ $1
    log "WARNING: $1"
}

print_info() {
    echo -e ${BLUE}  ℹ $1${NC}
    log "INFO: $1"
}

# =============================================================================
#                           🔧 FUNCIONES DE VERIFICACIÓN
# =============================================================================

check_system() {
    print_section "Verificando sistema..."

    if [ ! -f /etc/arch-release" ]; then
        print_errorEste script está diseñado solo para Arch Linux."
        exit 1   fi

    if [ "$EUID" -eq0then
        print_errorNo ejecutes este script como root."
        exit 1
    fi

    print_success "Sistema verificado."
}

check_dependencies() {
    print_section "Verificando dependencias básicas..."

    local missing_deps=()

    for dep ingit sudo" "pacman; do      if ! command -v $dep >/dev/null 2>&1; then
            missing_deps+=($dep")
        fi
    done

    if ${#missing_deps@]} -gt0then
        print_error Dependencias faltantes: ${missing_deps[*]}"
        print_info "Instala las dependencias básicas antes de continuar."
        exit 1
    fi

    print_successDependencias básicas verificadas.}

create_backup() {
    if -d $CONFIG_DIR" ] && [$(ls -A$CONFIG_DIR 2>/dev/null)" ]; then
        print_sectionCreando respaldo de configuración existente...       mkdir -p "$BACKUP_DIR       cp -r $CONFIG_DIR/* $BACKUP_DIR/" 2>/dev/null || true
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

    if command -v yay >/dev/null 2then
        print_success "yay ya está instalado."
        return
    fi

    print_step "Instalando yay..."
    cd /tmp
    git clone --depth 1ps://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --skippgpcheck
    cd$SCRIPT_DIR"
    rm -rf /tmp/yay

    print_success AUR helper instalado."
}

install_compiler() {
    print_section Instalando compilador C..."

    print_stepVerificando compilador existente...
    if command -v gcc >/dev/null 2then
        print_success "gcc ya está instalado: $(gcc --version | head -1)"
        return
    elif command -v clang >/dev/null 2then
        print_success "clang ya está instalado: $(clang --version | head -1)"
        return
    fi

    print_step "Instalando base-devel (incluye gcc)..."
    sudo pacman -S base-devel --noconfirm --needed

    print_step "Verificando instalación...
    if command -v gcc >/dev/null 2then
        print_success "Compilador C instalado: $(gcc --version | head -1)else
        print_error Falló al instalar compilador C"
    fi
}

# =============================================================================
#                           🐱 CONFIGURACIÓN DE KITTY
# =============================================================================

install_kitty() {
    print_section "Instalando y configurando Kitty..."
    
    # Verificar si kitty ya está instalado
    if ! command -v kitty >/dev/null 2then
        print_stepInstalando Kitty...       sudo pacman -S kitty --noconfirm --needed
    else
        print_success "Kitty ya está instalado."
    fi

    # Crear directorios de configuración
    print_stepCreando directorios de configuración..."
    mkdir -p $CONFIG_DIR/kitty"
    mkdir -p $CONFIG_DIR/kitty/kitten-scripts"

    # Copiar configuración de Kitty
    if [ -f $DOTFILES_DIR/kitty/kitty.conf" ]; then
        print_step "Copiando configuración de Kitty...
        cp $DOTFILES_DIR/kitty/kitty.conf$CONFIG_DIR/kitty/"
        print_successConfiguración de Kitty copiada.else
        print_warning "No se encontró kitty.conf en dotfiles."
    fi

    # Copiar scripts de kitten
    if [ -d $DOTFILES_DIR/kitty/kitten-scripts" ]; then
        print_stepCopiando scripts de kitten...
        cp -r $DOTFILES_DIR/kitty/kitten-scripts"/* $CONFIG_DIR/kitty/kitten-scripts/       chmod +x $CONFIG_DIR/kitty/kitten-scripts"/*.sh
        print_success Scripts de kitten copiados y permisos configurados.else
        print_warning No se encontró la carpeta kitten-scripts en dotfiles."
    fi

    # Copiar theme-switcher si existe
    if [ -f $DOTFILES_DIR/kitty/theme-switcher.sh" ]; then
        print_step Copiando theme-switcher...
        cp $DOTFILES_DIR/kitty/theme-switcher.sh$CONFIG_DIR/kitty/       chmod +x $CONFIG_DIR/kitty/theme-switcher.sh"
        print_success "Theme-switcher copiado."
    fi

    print_success Kitty configurado exitosamente."
}

# =============================================================================
#                           📝 CONFIGURACIÓN DE NEOVIM
# =============================================================================

install_nvim() {
    print_section "Instalando y configurando Neovim..."
    
    # Verificar si neovim ya está instalado
    if ! command -v nvim >/dev/null 2then
        print_step Instalando Neovim...       sudo pacman -S neovim --noconfirm --needed
    else
        print_success "Neovim ya está instalado."
    fi

    # Crear directorios de configuración
    print_stepCreando directorios de configuración..."
    mkdir -p$CONFIG_DIR/nvim"
    mkdir -p$CONFIG_DIR/nvim/lua"
    mkdir -p$CONFIG_DIR/nvim/lua/config"
    mkdir -p$CONFIG_DIR/nvim/lua/plugins"

    # Copiar configuración de Neovim
    if [ -d "$DOTFILES_DIR/nvim" ]; then
        print_step "Copiando configuración de Neovim...
        cp -r "$DOTFILES_DIR/nvim/*$CONFIG_DIR/nvim/"
        print_successConfiguración de Neovim copiada.else
        print_warning No se encontró la carpeta nvim en dotfiles."
    fi

    # Instalar plugins de Neovim
    print_step "Instalando plugins de Neovim..."
    nvim --headless -cLazy! sync" -c "qa" 2>/dev/null || print_warning "No se pudieron instalar los plugins automáticamente."

    print_success "Neovim configurado exitosamente."
}

# =============================================================================
#                           🖥️ CONFIGURACIÓN DE HYPRLAND
# =============================================================================

install_hyprland() {
    print_section "Instalando y configurando Hyprland..."
    
    # Verificar si hyprland ya está instalado
    if ! command -v Hyprland >/dev/null 2then
        print_step "Instalando Hyprland...       sudo pacman -S hyprland --noconfirm --needed
    else
        print_successHyprland ya está instalado."
    fi

    # Crear directorios de configuración
    print_stepCreando directorios de configuración..."
    mkdir -p$CONFIG_DIR/hypr"
    mkdir -p$CONFIG_DIR/hypr/assets"
    mkdir -p$CONFIG_DIR/hypr/shaders"
    mkdir -p$CONFIG_DIR/hypr/themes"
    mkdir -p $CONFIG_DIR/hypr/animations"
    mkdir -p$CONFIG_DIR/hypr/workflows"

    # Copiar configuración de Hyprland
    if [ -d$DOTFILES_DIR/hypr" ]; then
        print_step "Copiando configuración de Hyprland...
        cp -r$DOTFILES_DIR/hypr/*$CONFIG_DIR/hypr/"
        print_successConfiguración de Hyprland copiada.else
        print_warning No se encontró la carpeta hypr en dotfiles."
    fi

    print_successHyprland configurado exitosamente."
}

# =============================================================================
#                           🔒 CONFIGURACIÓN DE HYPRLOCK
# =============================================================================

install_hyprlock() {
    print_section "Instalando y configurando Hyprlock..."
    
    # Verificar si hyprlock ya está instalado
    if ! command -v hyprlock >/dev/null 2then
        print_step "Instalando Hyprlock...       sudo pacman -S hyprlock --noconfirm --needed
    else
        print_successHyprlock ya está instalado."
    fi

    # Crear directorios de configuración
    print_stepCreando directorios de configuración..."
    mkdir -p$CONFIG_DIR/hyprlock"
    mkdir -p$CONFIG_DIR/hyprlock/assets"

    # Copiar configuración de Hyprlock
    if [ -d$DOTFILES_DIR/hyprlock" ]; then
        print_step "Copiando configuración de Hyprlock...
        cp -r$DOTFILES_DIR/hyprlock/*$CONFIG_DIR/hyprlock/"
        print_successConfiguración de Hyprlock copiada.else
        print_warning No se encontró la carpeta hyprlock en dotfiles."
    fi

    print_successHyprlock configurado exitosamente."
}

# =============================================================================
#                           🎭 CONFIGURACIÓN DE TMUX
# =============================================================================

install_tmux() {
    print_section "Instalando y configurando Tmux..."
    
    # Verificar si tmux ya está instalado
    if ! command -v tmux >/dev/null 2then
        print_step "Instalando Tmux...       sudo pacman -S tmux --noconfirm --needed
    else
        print_success "Tmux ya está instalado."
    fi

    # Crear directorios de configuración
    print_stepCreando directorios de configuración..."
    mkdir -p$HOME/.tmux"
    mkdir -p "$HOME/.tmux/plugins"
    mkdir -p "$HOME/.tmux/scripts"

    # Instalar TPM si no está instalado
    if ! -d "$HOME/.tmux/plugins/tpm" ]; then
        print_stepInstalando TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        print_successTPM instalado.else
        print_success "TPM ya está instalado."
    fi

    # Copiar configuración de Tmux
    if [ -d$DOTFILES_DIR/tmux" ]; then
        print_step "Copiando configuración de Tmux..."
        if [ -f$DOTFILES_DIR/tmux/tmux.conf" ]; then
            cp$DOTFILES_DIR/tmux/tmux.conf"$HOME/.tmux.conf"
        fi
        if [ -d$DOTFILES_DIR/tmux/plugins" ]; then
            cp -r$DOTFILES_DIR/tmux/plugins"/* "$HOME/.tmux/plugins/"
        fi
        if [ -d$DOTFILES_DIR/tmux/scripts" ]; then
            cp -r$DOTFILES_DIR/tmux/scripts"/* "$HOME/.tmux/scripts/"
            chmod +x "$HOME/.tmux/scripts/*.sh        fi
        print_successConfiguración de Tmux copiada.else
        print_warning No se encontró la carpeta tmux en dotfiles."
    fi

    print_successTmux configurado exitosamente."
}

# =============================================================================
#                           🖼️ CONFIGURACIÓN DE SDDM
# =============================================================================

install_sddm() {
    print_section "Instalando y configurando SDDM..."
    
    # Verificar si sddm ya está instalado
    if ! command -v sddm >/dev/null 2then
        print_step "Instalando SDDM...       sudo pacman -S sddm --noconfirm --needed
    else
        print_success "SDDM ya está instalado."
    fi

    # Habilitar SDDM
    print_stepHabilitando SDDM..."
    sudo systemctl enable sddm

    # Crear directorios de configuración
    print_stepCreando directorios de configuración...
    sudo mkdir -p /etc/sddm.conf.d
    sudo mkdir -p /usr/share/sddm/themes

    # Copiar configuración de SDDM
    if [ -d $DOTFILES_DIR/sddm" ]; then
        print_step "Copiando configuración de SDDM..."
        sudo cp -r $DOTFILES_DIR/sddm/* /etc/sddm.conf.d/ 2>/dev/null || true
        print_successConfiguración de SDDM copiada.else
        print_warning No se encontró la carpeta sddm en dotfiles."
    fi

    print_successSDDM configurado exitosamente."
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
    print_stepCreando directorios de fuentes..."
    mkdir -p "$HOME/.local/share/fonts"
    mkdir -p "$HOME/.fonts  # Copiar fuentes personalizadas
    if [ -d "$DOTFILES_DIR/fonts" ]; then
        print_stepCopiando fuentes personalizadas...
        cp -r "$DOTFILES_DIR/fonts"/* "$HOME/.local/share/fonts/        fc-cache -fv
        print_successFuentes personalizadas copiadas y cache actualizado.else
        print_warning No se encontró la carpeta fonts en dotfiles."
    fi

    print_success "Fuentes configuradas exitosamente."
}

# =============================================================================
#                           🖼️ CONFIGURACIÓN DE WALLPAPERS
# =============================================================================

install_wallpapers() {
    print_sectionInstalando wallpapers..."

    # Crear directorio de wallpapers
    print_stepCreando directorio de wallpapers...   mkdir -p "$PICTURES_DIR/wallpapers"

    # Copiar wallpapers
    if [ -d "$DOTFILES_DIR/wallpapers" ]; then
        print_step "Copiando wallpapers...
        cp -r "$DOTFILES_DIR/wallpapers/* "$PICTURES_DIR/wallpapers/"
        print_success "Wallpapers copiados a $PICTURES_DIR/wallpaperselse
        print_warning No se encontró la carpeta wallpapers en dotfiles."
    fi

    print_success Wallpapers instalados exitosamente."
}

# =============================================================================
#                           🔧 CONFIGURACIONES ADICIONALES
# =============================================================================

install_core_packages() {
    print_section Instalando paquetes core..."

    local terminal_packages=("fish" starship" "zoxide")
    local system_packages=("batfd"ripgrep fzfbtop"exahtop)
    local media_packages=(pavucontrol" bluemannetworkmanager etwork-manager-applet)local dev_packages=("nodejspython" python-pip t" "go")
    local utility_packages=(lazygit yazi" feh"imv" "pcmanfm")
    local additional_packages=(jq url tuin"justhttpieswappywaybar-hyprland"eww-wayland" wofimako" waypaper"libnotify)

    print_step Instalando paquetes del sistema..."
    sudo pacman -S "${terminal_packages[@]}" $[object Object]system_packages[@]}"${media_packages[@]}" ${dev_packages[@]}" "${utility_packages[@]}" "${additional_packages[@]} --noconfirm --needed || print_warningAlgunos paquetes fallaron"

    print_success "Paquetes core instalados."
}

configure_fish_shell() {
    print_section Configurando Fish shell..."
    
    # Verificar si fish está instalado
    if ! command -v fish >/dev/null 2then
        print_step "Instalando Fish...       sudo pacman -S fish --noconfirm --needed
    fi

    # Copiar configuración de Fish
    if [ -f "$DOTFILES_DIR/fish/config.fish" ]; then
        print_step "Copiando configuración de Fish...       mkdir -p$CONFIG_DIR/fish
        cp "$DOTFILES_DIR/fish/config.fish"$CONFIG_DIR/fish/"
        print_successConfiguración de Fish copiada."
    fi

    # Cambiar shell por defecto a fish
    if [$SHELL" != /usr/bin/fish" ]; then
        print_step "Cambiando shell por defecto a Fish..."
        chsh -s /usr/bin/fish
        print_successShell cambiado a Fish."
    fi

    print_success Fish shell configurado exitosamente."
}

configure_system() {
    print_section "Configurando sistema..."

    # Configurar permisos de audio
    print_step "Configurando permisos de audio...    sudo usermod -a -G audio "$USER"

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
        if [ -f $CONFIG_DIR/kitty/kitty.conf" ]; then
            print_success "✓ Kitty configurado"
            components+=("Kitty")
        else
            print_error ✗ Kitty no configurado"
            ((errors++))
        fi
    fi

    if $INSTALL_NVIM || $INSTALL_ALL; then
        if -f $CONFIG_DIR/nvim/init.lua" ]; then
            print_success✓Neovim configurado"
            components+=("Neovim")
        else
            print_error "✗ Neovim no configurado"
            ((errors++))
        fi
    fi

    if $INSTALL_HYPRLAND || $INSTALL_ALL; then
        if -d $CONFIG_DIR/hypr" ]; then
            print_success ✓ Hyprland configurado"
            components+=("Hyprland")
        else
            print_error "✗ Hyprland no configurado"
            ((errors++))
        fi
    fi

    if $INSTALL_TMUX || $INSTALL_ALL; then
        if [ -f $HOME/.tmux.conf" ]; then
            print_success "✓ Tmux configurado"
            components+=("Tmux")
        else
            print_error ✗ Tmux no configurado"
            ((errors++))
        fi
    fi

    if $INSTALL_FONTS || $INSTALL_ALL; then
        if fc-list | grep -q "JetBrainsMono"; then
            print_success✓Fuentes instaladas"
            components+=(Fuentes")
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

    if [ $errors -eq0then
        print_success "Todos los componentes verificados exitosamente   echo   echo "Componentes instalados: ${components[*]}else
        print_errorSe encontraron $errors error(es) en la instalación  fi
}

show_final_info() {
    echo -e${GREEN}══════════════════════════════════════════════════════════════════════════════${NC}  echo -e "${GREEN}║                    INSTALACIÓN COMPLETADA                                   ║${NC}  echo -e${GREEN}══════════════════════════════════════════════════════════════════════════════${NC} echo

    echo Próximos pasos:"
    echo "1. Reinicia tu sistema"
    echo2. Inicia sesión con Hyprland echo

    echoComandos útiles:"
    echo• kitty --config ~/.config/kitty/kitty.conf   echo• nvim --version  echo "• tmux new-session   echo "• hyprctl monitors   echo     if [ -n "$BACKUP_DIR" ]; then
        echo "Respaldo de configuración anterior:"
        echo "$BACKUP_DIR       echo ""
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
    
    # Configuraciones adicionales
    configure_fish_shell
    configure_system
    
    # Verificación final
    verify_installation
    show_final_info
}

# Ejecutar función principal
main "$@" 