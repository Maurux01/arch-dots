#!/bin/bash

# Script consolidado de utilidades para Arch Dots
# Incluye: wallpaper management, clipboard, system maintenance

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
CACHE_DIR="$HOME/.cache/wallpaper-colors"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Función para imprimir mensajes
print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    UTILIDADES ARCH DOTS                      ║${NC}"
    echo -e "${BLUE}║                    Script consolidado                       ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo -e "${CYAN}▸ $1${NC}"
}

print_step() {
    echo -e "${YELLOW}  → $1${NC}"
}

print_success() {
    echo -e "${GREEN}  ✓ $1${NC}"
}

print_error() {
    echo -e "${RED}  ✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}  ⚠ $1${NC}"
}

# ============================================================================
# FUNCIONES DE WALLPAPER
# ============================================================================

# Función para obtener wallpaper actual
get_current_wallpaper() {
    if command -v swww >/dev/null 2>&1; then
        swww query | grep -oP 'image: \K.*' | head -1
    elif [ -f "$CACHE_DIR/current_wallpaper" ]; then
        cat "$CACHE_DIR/current_wallpaper"
    fi
}

# Función para extraer colores dominantes
extract_colors() {
    local wallpaper="$1"
    local cache_file="$CACHE_DIR/$(basename "$wallpaper" | sed 's/\.[^.]*$//').colors"
    
    if [ -f "$cache_file" ] && [ "$wallpaper" -ot "$cache_file" ]; then
        cat "$cache_file"
        return
    fi
    
    if command -v convert >/dev/null 2>&1; then
        convert "$wallpaper" -resize 100x100 -colors 8 -unique-colors txt:- | \
        tail -n +2 | \
        sed 's/.*srgb(\([0-9,]*\)).*/\1/' | \
        while IFS=',' read -r r g b; do
            printf "#%02x%02x%02x\n" "$r" "$g" "$b"
        done | head -8 > "$cache_file"
        
        cat "$cache_file"
    else
        echo "#1e1e2e" "#cdd6f4" "#89b4fa" "#f38ba8" "#a6e3a1" "#f9e2af" "#fab387" "#cba6f7"
    fi
}

# Función para cambiar wallpaper
change_wallpaper() {
    local wallpaper="$1"
    
    if [ ! -f "$wallpaper" ]; then
        print_error "Wallpaper no encontrado: $wallpaper"
        return 1
    fi
    
    print_step "Cambiando wallpaper a: $(basename "$wallpaper")"
    
    if command -v swww >/dev/null 2>&1; then
        swww img "$wallpaper" --transition-type wipe --transition-angle 30 --transition-step 90
    fi
    
    echo "$wallpaper" > "$CACHE_DIR/current_wallpaper"
    print_success "Wallpaper cambiado exitosamente"
}

# Función para obtener lista de wallpapers
get_wallpapers() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" \) 2>/dev/null | sort
}

# Función para cambiar wallpaper aleatorio
change_random_wallpaper() {
    local wallpapers=($(get_wallpapers))
    
    if [ ${#wallpapers[@]} -eq 0 ]; then
        print_error "No se encontraron wallpapers en $WALLPAPER_DIR"
        return 1
    fi
    
    local random_index=$((RANDOM % ${#wallpapers[@]}))
    change_wallpaper "${wallpapers[$random_index]}"
}

# Función para navegar wallpapers
change_next_wallpaper() {
    local wallpapers=($(get_wallpapers))
    local current_wallpaper=$(get_current_wallpaper)
    
    if [ ${#wallpapers[@]} -eq 0 ]; then
        print_error "No se encontraron wallpapers en $WALLPAPER_DIR"
        return 1
    fi
    
    local current_index=0
    for i in "${!wallpapers[@]}"; do
        if [ "${wallpapers[$i]}" = "$current_wallpaper" ]; then
            current_index=$i
            break
        fi
    done
    
    local next_index=$(((current_index + 1) % ${#wallpapers[@]}))
    change_wallpaper "${wallpapers[$next_index]}"
}

change_prev_wallpaper() {
    local wallpapers=($(get_wallpapers))
    local current_wallpaper=$(get_current_wallpaper)
    
    if [ ${#wallpapers[@]} -eq 0 ]; then
        print_error "No se encontraron wallpapers en $WALLPAPER_DIR"
        return 1
    fi
    
    local current_index=0
    for i in "${!wallpapers[@]}"; do
        if [ "${wallpapers[$i]}" = "$current_wallpaper" ]; then
            current_index=$i
            break
        fi
    done
    
    local prev_index=$(((current_index - 1 + ${#wallpapers[@]}) % ${#wallpapers[@]}))
    change_wallpaper "${wallpapers[$prev_index]}"
}

# Función para listar wallpapers
list_wallpapers() {
    local wallpapers=($(get_wallpapers))
    local current=$(get_current_wallpaper)
    
    echo "Wallpapers disponibles en $WALLPAPER_DIR:"
    echo ""
    
    for i in "${!wallpapers[@]}"; do
        local marker=""
        if [ "${wallpapers[$i]}" = "$current" ]; then
            marker="* "
        else
            marker="  "
        fi
        echo "$marker$((i+1)). $(basename "${wallpapers[$i]}")"
    done
    
    echo ""
    echo "Total: ${#wallpapers[@]} wallpapers"
    if [ -n "$current" ]; then
        echo "Actual: $(basename "$current")"
    fi
}

# Función para mostrar información del wallpaper
show_wallpaper_info() {
    print_section "Información del wallpaper actual..."
    
    local wallpaper=$(get_current_wallpaper)
    if [ -n "$wallpaper" ] && [ -f "$wallpaper" ]; then
        echo "Archivo: $wallpaper"
        echo "Nombre: $(basename "$wallpaper")"
        echo "Tamaño: $(du -h "$wallpaper" | cut -f1)"
        
        echo ""
        echo "Colores dominantes:"
        local colors=($(extract_colors "$wallpaper"))
        for i in "${!colors[@]}"; do
            echo "  $((i+1)). ${colors[$i]}"
        done
    else
        print_error "No hay wallpaper actual configurado"
    fi
}

# ============================================================================
# FUNCIONES DE PORTAPAPELES
# ============================================================================

# Función para mostrar historial de cliphist
show_cliphist_history() {
    print_section "Historial de portapapeles (cliphist)..."
    
    if ! command -v cliphist >/dev/null 2>&1; then
        print_error "cliphist no está instalado"
        return 1
    fi
    
    print_step "Mostrando historial..."
    cliphist list | head -20
}

# Función para limpiar historial de cliphist
clear_cliphist_history() {
    print_section "Limpiando historial de portapapeles..."
    
    if ! command -v cliphist >/dev/null 2>&1; then
        print_error "cliphist no está instalado"
        return 1
    fi
    
    print_step "Limpiando historial..."
    cliphist wipe
    print_success "Historial limpiado"
}

# Función para mostrar información de CopyQ
show_copyq_info() {
    print_section "Información de CopyQ..."
    
    if ! command -v copyq >/dev/null 2>&1; then
        print_error "CopyQ no está instalado"
        return 1
    fi
    
    print_step "Información de CopyQ:"
    copyq info
}

# Función para abrir CopyQ
open_copyq() {
    print_section "Abriendo CopyQ..."
    
    if ! command -v copyq >/dev/null 2>&1; then
        print_error "CopyQ no está instalado"
        return 1
    fi
    
    print_step "Abriendo interfaz de CopyQ..."
    copyq show
}

# ============================================================================
# FUNCIONES DE LOCK
# ============================================================================

# Función para bloquear pantalla con Hyperlock
lock_screen() {
    print_section "Bloqueando pantalla..."
    
    if ! command -v hyperlock >/dev/null 2>&1; then
        print_error "Hyperlock no está instalado"
        print_info "Instalando Hyperlock..."
        yay -S hyperlock --noconfirm --needed
    fi
    
    print_step "Ejecutando Hyperlock..."
    hyperlock
}

# ============================================================================
# FUNCIONES DE SISTEMA
# ============================================================================

# Función para actualizar sistema
update_system() {
    print_section "Actualizando sistema..."
    
    print_step "Sincronizando repositorios..."
    sudo pacman -Sy
    
    print_step "Actualizando paquetes..."
    sudo pacman -Syu --noconfirm
    
    print_step "Actualizando AUR..."
    yay -Sua --noconfirm
    
    print_success "Sistema actualizado"
}

# Función para limpiar sistema
cleanup_system() {
    print_section "Limpiando sistema..."
    
    print_step "Limpiando caché de pacman..."
    sudo pacman -Sc --noconfirm
    
    print_step "Limpiando caché de AUR..."
    yay -Sc --noconfirm
    
    print_step "Limpiando archivos temporales..."
    sudo rm -rf /tmp/*
    rm -rf "$HOME/.cache"
    
    print_step "Limpiando logs..."
    sudo journalctl --vacuum-time=1d
    
    print_success "Sistema limpiado"
}

# Función para verificar estado del sistema
check_system() {
    print_section "Verificando estado del sistema..."
    
    print_step "Verificando paquetes huérfanos..."
    sudo pacman -Qtdq | wc -l | xargs -I {} echo "Paquetes huérfanos: {}"
    
    print_step "Verificando espacio en disco..."
    df -h / | tail -1 | awk '{print "Espacio libre: " $4}'
    
    print_step "Verificando memoria..."
    free -h | grep Mem | awk '{print "Memoria libre: " $7}'
    
    print_success "Verificación completada"
}

# Función para optimizar sistema
optimize_system() {
    print_section "Optimizando sistema..."
    
    print_step "Optimizando base de datos de pacman..."
    sudo pacman-optimize
    
    print_step "Limpiando caché..."
    sudo pacman -Sc --noconfirm
    
    print_step "Verificando integridad del sistema..."
    sudo pacman -Qkk
    
    print_success "Optimización completada"
}

# Función para mostrar información del sistema
show_system_info() {
    print_section "Información del sistema..."
    
    echo "Sistema: $(uname -s)"
    echo "Distribución: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2 2>/dev/null || echo "Desconocida")"
    echo "Usuario: $USER"
    echo "Home: $HOME"
    echo "Shell: $SHELL"
    
    if command -v hyprctl >/dev/null 2>&1; then
        echo "Hyprland: $(hyprctl version | head -1)"
    fi
    
    if command -v hyperlock >/dev/null 2>&1; then
        echo "Hyperlock: Instalado"
    else
        echo "Hyperlock: No instalado"
    fi
    
    echo ""
}

# Función para instalar tema GRUB Catppuccin
install_grub_theme() {
    print_section "Instalando tema GRUB Catppuccin..."
    
    if [ -f "$HOME/.config/scripts/install-grub-theme.sh" ]; then
        print_step "Ejecutando script de instalación..."
        "$HOME/.config/scripts/install-grub-theme.sh"
    else
        print_error "Script de instalación no encontrado"
        print_step "Instalando manualmente..."
        
        print_step "Clonando repositorio..."
        cd /tmp
        git clone https://github.com/catppuccin/grub.git catppuccin-grub
        cd catppuccin-grub
        
        print_step "Instalando tema..."
        sudo mkdir -p /usr/share/grub/themes/
        sudo cp -r src/catppuccin-grub-theme /usr/share/grub/themes/
        
        print_step "Configurando GRUB..."
        sudo cp /etc/default/grub /etc/default/grub.backup
        sudo sed -i 's|GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/catppuccin-grub-theme/theme.txt"|' /etc/default/grub
        
        print_step "Actualizando GRUB..."
        sudo grub-mkconfig -o /boot/grub/grub.cfg
        
        print_step "Limpiando..."
        cd "$SCRIPT_DIR"
        rm -rf /tmp/catppuccin-grub
        
        print_success "Tema GRUB instalado"
        print_warning "Reinicia el sistema para ver el nuevo tema"
    fi
}

# ============================================================================
# MENÚ PRINCIPAL
# ============================================================================

# Función para mostrar menú principal
show_menu() {
    echo -e "${CYAN}Selecciona una opción:${NC}"
    echo ""
    echo "=== WALLPAPER Y LOGIN ==="
    echo "1) Cambiar wallpaper aleatorio"
    echo "2) Siguiente wallpaper"
    echo "3) Anterior wallpaper"
    echo "4) Listar wallpapers"
    echo "5) Bloquear pantalla (Hyperlock)"
    echo "6) Información del wallpaper"
    echo ""
    echo "=== PORTAPAPELES ==="
    echo "7) Mostrar historial cliphist"
    echo "8) Limpiar historial cliphist"
    echo "9) Abrir CopyQ"
    echo "10) Información CopyQ"
    echo ""
    echo "=== SISTEMA ==="
    echo "11) Actualizar sistema"
    echo "12) Limpiar sistema"
    echo "13) Verificar estado"
    echo "14) Optimizar sistema"
    echo ""
    echo "=== INFORMACIÓN ==="
    echo "15) Información del sistema"
    echo ""
    echo "16) Salir"
    echo ""
}

# Función principal
main() {
    print_header
    
    # Crear directorios necesarios
    mkdir -p "$CACHE_DIR" "$WALLPAPER_DIR"
    
    while true; do
        show_menu
        read -p "Selecciona una opción (1-16): " choice
        
        case "$choice" in
            1) change_random_wallpaper ;;
            2) change_next_wallpaper ;;
            3) change_prev_wallpaper ;;
            4) list_wallpapers ;;
            5) lock_screen ;;
            6) show_wallpaper_info ;;
            7) show_cliphist_history ;;
            8) clear_cliphist_history ;;
            9) open_copyq ;;
            10) show_copyq_info ;;
            11) update_system ;;
            12) cleanup_system ;;
            13) check_system ;;
            14) optimize_system ;;
            15) show_system_info ;;
            16) echo "¡Hasta luego!"; exit 0 ;;
            *) print_error "Opción inválida" ;;
        esac
        
        echo ""
        read -p "Presiona Enter para continuar..."
        echo ""
    done
}

# Ejecutar función principal
main "$@" 