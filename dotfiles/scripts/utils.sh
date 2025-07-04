#!/bin/bash
# Script de utilidades para Arch Dots

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para imprimir mensajes con colores
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}=== $1 ===${NC}"
}

# Función para actualizar sistema
update_system() {
    print_header "Actualizando sistema"
    print_status "Sincronizando repositorios..."
    sudo pacman -Sy
    
    print_status "Actualizando paquetes..."
    sudo pacman -Syu --noconfirm
    
    print_status "Limpiando caché..."
    sudo pacman -Sc --noconfirm
    
    print_status "Eliminando paquetes huérfanos..."
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || true
    
    print_status "Sistema actualizado correctamente!"
}

# Función para instalar paquetes AUR
install_aur() {
    print_header "Instalando paquetes AUR"
    
    local packages=("$@")
    
    for package in "${packages[@]}"; do
        print_status "Instalando $package..."
        if command -v yay >/dev/null 2>&1; then
            yay -S "$package" --noconfirm
        elif command -v pamac >/dev/null 2>&1; then
            pamac build "$package" --no-confirm
        else
            print_error "No se encontró yay ni pamac. Instala uno de ellos primero."
            return 1
        fi
    done
}

# Función para limpiar sistema
clean_system() {
    print_header "Limpiando sistema"
    
    print_status "Limpiando caché de pacman..."
    sudo pacman -Sc --noconfirm
    
    print_status "Eliminando paquetes huérfanos..."
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || true
    
    print_status "Limpiando caché de yay..."
    yay -Sc --noconfirm 2>/dev/null || true
    
    print_status "Limpiando logs antiguos..."
    sudo journalctl --vacuum-time=7d
    
    print_status "Limpieza completada!"
}

# Función para verificar estado del sistema
check_system() {
    print_header "Verificando estado del sistema"
    
    print_status "Verificando paquetes rotos..."
    if pacman -Qk 2>/dev/null | grep -q "error"; then
        print_warning "Se encontraron paquetes rotos"
    else
        print_status "No se encontraron paquetes rotos"
    fi
    
    print_status "Verificando espacio en disco..."
    df -h | grep -E '^/dev/'
    
    print_status "Verificando memoria..."
    free -h
    
    print_status "Verificando temperatura (si está disponible)..."
    if command -v sensors >/dev/null 2>&1; then
        sensors | head -10
    else
        print_warning "sensors no está instalado"
    fi
}

# Función para configurar firewall
setup_firewall() {
    print_header "Configurando firewall"
    
    print_status "Habilitando UFW..."
    sudo ufw --force enable
    
    print_status "Configurando reglas básicas..."
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    
    print_status "Estado del firewall:"
    sudo ufw status verbose
}

# Función para optimizar sistema
optimize_system() {
    print_header "Optimizando sistema"
    
    print_status "Optimizando SSD (si aplica)..."
    if lsblk -d -o name,rota | grep -q "0"; then
        print_status "SSD detectado, aplicando optimizaciones..."
        # Aquí puedes agregar optimizaciones específicas para SSD
    fi
    
    print_status "Ajustando swappiness..."
    echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
    
    print_status "Optimización completada!"
}

# Función para mostrar información del sistema
system_info() {
    print_header "Información del sistema"
    
    echo -e "${CYAN}Distribución:${NC}"
    cat /etc/os-release | grep PRETTY_NAME
    
    echo -e "\n${CYAN}Kernel:${NC}"
    uname -r
    
    echo -e "\n${CYAN}Arquitectura:${NC}"
    uname -m
    
    echo -e "\n${CYAN}CPU:${NC}"
    lscpu | grep "Model name" | head -1
    
    echo -e "\n${CYAN}Memoria:${NC}"
    free -h
    
    echo -e "\n${CYAN}Almacenamiento:${NC}"
    df -h /
    
    echo -e "\n${CYAN}Paquetes instalados:${NC}"
    pacman -Q | wc -l
}

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}Arch Dots - Script de Utilidades${NC}"
    echo ""
    echo "Uso: $0 [comando]"
    echo ""
    echo "Comandos disponibles:"
    echo "  update      - Actualizar sistema completo"
    echo "  clean       - Limpiar sistema"
    echo "  check       - Verificar estado del sistema"
    echo "  firewall    - Configurar firewall básico"
    echo "  optimize    - Optimizar sistema"
    echo "  info        - Mostrar información del sistema"
    echo "  aur [pkgs]  - Instalar paquetes AUR"
    echo "  help        - Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 update"
    echo "  $0 aur discord spotify"
    echo "  $0 clean"
}

# Función principal
main() {
    case "${1:-help}" in
        "update")
            update_system
            ;;
        "clean")
            clean_system
            ;;
        "check")
            check_system
            ;;
        "firewall")
            setup_firewall
            ;;
        "optimize")
            optimize_system
            ;;
        "info")
            system_info
            ;;
        "aur")
            shift
            install_aur "$@"
            ;;
        "help"|*)
            show_help
            ;;
    esac
}

# Ejecutar función principal
main "$@" 