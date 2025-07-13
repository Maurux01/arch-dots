#!/bin/bash

# =============================================================================
#                           🛡️ SECURITY MANAGER
# =============================================================================
# Script de gestión de herramientas de seguridad
# Manejo fácil de firewall, VPN, antivirus y monitoreo
# =============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    🛡️ SECURITY MANAGER                       ║${NC}"
    echo -e "${BLUE}║                    Gestión de herramientas de seguridad      ║${NC}"
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

# =============================================================================
#                           🔥 FUNCIONES DE FIREWALL
# =============================================================================

firewall_status() {
    print_section "Estado del Firewall (UFW)"
    
    if command -v ufw >/dev/null 2>&1; then
        echo "Estado actual:"
        sudo ufw status verbose
    else
        print_error "UFW no está instalado"
    fi
}

firewall_rules() {
    print_section "Reglas del Firewall"
    
    if command -v ufw >/dev/null 2>&1; then
        echo "Reglas configuradas:"
        sudo ufw status numbered
    else
        print_error "UFW no está instalado"
    fi
}

firewall_allow() {
    local port="$1"
    local protocol="${2:-tcp}"
    
    if [ -z "$port" ]; then
        print_error "Debes especificar un puerto"
        echo "Uso: $0 firewall allow <puerto> [protocolo]"
        return 1
    fi
    
    print_section "Permitiendo puerto $port/$protocol"
    
    if command -v ufw >/dev/null 2>&1; then
        sudo ufw allow "$port/$protocol"
        print_success "Puerto $port/$protocol permitido"
    else
        print_error "UFW no está instalado"
    fi
}

firewall_deny() {
    local port="$1"
    local protocol="${2:-tcp}"
    
    if [ -z "$port" ]; then
        print_error "Debes especificar un puerto"
        echo "Uso: $0 firewall deny <puerto> [protocolo]"
        return 1
    fi
    
    print_section "Denegando puerto $port/$protocol"
    
    if command -v ufw >/dev/null 2>&1; then
        sudo ufw deny "$port/$protocol"
        print_success "Puerto $port/$protocol denegado"
    else
        print_error "UFW no está instalado"
    fi
}

# =============================================================================
#                           🌐 FUNCIONES DE VPN
# =============================================================================

vpn_status() {
    print_section "Estado de VPN (WireGuard)"
    
    if command -v wg >/dev/null 2>&1; then
        echo "Interfaces WireGuard activas:"
        sudo wg show
    else
        print_error "WireGuard no está instalado"
    fi
}

vpn_start() {
    local interface="${1:-wg0}"
    
    print_section "Iniciando VPN WireGuard ($interface)"
    
    if command -v wg-quick >/dev/null 2>&1; then
        if [ -f "/etc/wireguard/$interface.conf" ]; then
            sudo wg-quick up "$interface"
            print_success "VPN $interface iniciada"
        else
            print_error "Configuración $interface.conf no encontrada"
            print_info "Crea la configuración en /etc/wireguard/$interface.conf"
        fi
    else
        print_error "WireGuard no está instalado"
    fi
}

vpn_stop() {
    local interface="${1:-wg0}"
    
    print_section "Deteniendo VPN WireGuard ($interface)"
    
    if command -v wg-quick >/dev/null 2>&1; then
        sudo wg-quick down "$interface"
        print_success "VPN $interface detenida"
    else
        print_error "WireGuard no está instalado"
    fi
}

vpn_keys() {
    print_section "Gestión de claves WireGuard"
    
    if command -v wg >/dev/null 2>&1; then
        if [ -f "/etc/wireguard/public.key" ]; then
            echo "Clave pública:"
            sudo cat /etc/wireguard/public.key
            echo ""
            echo "Clave privada (solo para administradores):"
            sudo cat /etc/wireguard/private.key
        else
            print_warning "No se encontraron claves WireGuard"
            print_info "Ejecuta el instalador para generar claves"
        fi
    else
        print_error "WireGuard no está instalado"
    fi
}

# =============================================================================
#                           🛡️ FUNCIONES DE SEGURIDAD
# =============================================================================

fail2ban_status() {
    print_section "Estado de Fail2ban"
    
    if command -v fail2ban-client >/dev/null 2>&1; then
        echo "Estado de Fail2ban:"
        sudo fail2ban-client status
        echo ""
        echo "Jails activos:"
        sudo fail2ban-client status | grep "Jail list" | cut -d: -f2
    else
        print_error "Fail2ban no está instalado"
    fi
}

clamav_scan() {
    local path="${1:-/home}"
    
    print_section "Escaneo con ClamAV"
    
    if command -v clamscan >/dev/null 2>&1; then
        print_step "Escaneando $path..."
        sudo clamscan -r --infected "$path"
        print_success "Escaneo completado"
    else
        print_error "ClamAV no está instalado"
    fi
}

clamav_update() {
    print_section "Actualizando base de datos de ClamAV"
    
    if command -v freshclam >/dev/null 2>&1; then
        sudo freshclam
        print_success "Base de datos actualizada"
    else
        print_error "ClamAV no está instalado"
    fi
}

rkhunter_scan() {
    print_section "Escaneo con RKHunter"
    
    if command -v rkhunter >/dev/null 2>&1; then
        print_step "Ejecutando escaneo completo..."
        sudo rkhunter --check --skip-keypress
        print_success "Escaneo completado"
    else
        print_error "RKHunter no está instalado"
    fi
}

rkhunter_update() {
    print_section "Actualizando RKHunter"
    
    if command -v rkhunter >/dev/null 2>&1; then
        sudo rkhunter --update
        sudo rkhunter --propupd
        print_success "RKHunter actualizado"
    else
        print_error "RKHunter no está instalado"
    fi
}

# =============================================================================
#                           📊 FUNCIONES DE MONITOREO
# =============================================================================

network_monitor() {
    print_section "Monitoreo de Red"
    
    if [ -f "/usr/local/bin/network-monitor.sh" ]; then
        sudo /usr/local/bin/network-monitor.sh
    else
        print_warning "Script de monitoreo no encontrado"
        echo "=== CONEXIONES ACTIVAS ==="
        ss -tuln
        echo ""
        echo "=== INTERFACES DE RED ==="
        ip addr show
    fi
}

port_scan() {
    local target="${1:-localhost}"
    
    print_section "Escaneo de puertos en $target"
    
    if command -v nmap >/dev/null 2>&1; then
        print_step "Escaneando puertos abiertos..."
        sudo nmap -sS -sV -O "$target"
    else
        print_error "nmap no está instalado"
    fi
}

traffic_monitor() {
    print_section "Monitoreo de Tráfico"
    
    if command -v iftop >/dev/null 2>&1; then
        print_step "Iniciando monitoreo de tráfico..."
        sudo iftop
    elif command -v nethogs >/dev/null 2>&1; then
        print_step "Mostrando uso de ancho de banda por proceso..."
        sudo nethogs
    else
        print_error "Herramientas de monitoreo no instaladas"
    fi
}

# =============================================================================
#                           📋 FUNCIÓN PRINCIPAL
# =============================================================================

show_help() {
    echo "Uso: $0 [COMANDO] [OPCIONES]"
    echo ""
    echo "Comandos de Firewall:"
    echo "  firewall status                    # Estado del firewall"
    echo "  firewall rules                     # Listar reglas"
    echo "  firewall allow <puerto> [proto]   # Permitir puerto"
    echo "  firewall deny <puerto> [proto]    # Denegar puerto"
    echo ""
    echo "Comandos de VPN:"
    echo "  vpn status                         # Estado de VPN"
    echo "  vpn start [interface]              # Iniciar VPN"
    echo "  vpn stop [interface]               # Detener VPN"
    echo "  vpn keys                           # Mostrar claves"
    echo ""
    echo "Comandos de Seguridad:"
    echo "  fail2ban status                    # Estado de Fail2ban"
    echo "  clamav scan [path]                 # Escanear con ClamAV"
    echo "  clamav update                      # Actualizar ClamAV"
    echo "  rkhunter scan                      # Escanear con RKHunter"
    echo "  rkhunter update                    # Actualizar RKHunter"
    echo ""
    echo "Comandos de Monitoreo:"
    echo "  network monitor                    # Monitoreo de red"
    echo "  port scan [target]                 # Escanear puertos"
    echo "  traffic monitor                    # Monitoreo de tráfico"
    echo ""
    echo "Ejemplos:"
    echo "  $0 firewall allow 8080            # Permitir puerto 8080"
    echo "  $0 vpn start wg0                  # Iniciar VPN wg0"
    echo "  $0 clamav scan /home              # Escanear /home"
    echo "  $0 port scan 192.168.1.1         # Escanear IP"
}

main() {
    print_header
    
    if [ $# -eq 0 ]; then
        show_help
        exit 0
    fi
    
    case "$1" in
        "firewall")
            case "$2" in
                "status") firewall_status ;;
                "rules") firewall_rules ;;
                "allow") firewall_allow "$3" "$4" ;;
                "deny") firewall_deny "$3" "$4" ;;
                *) echo "Comando firewall desconocido: $2"; show_help ;;
            esac
            ;;
        "vpn")
            case "$2" in
                "status") vpn_status ;;
                "start") vpn_start "$3" ;;
                "stop") vpn_stop "$3" ;;
                "keys") vpn_keys ;;
                *) echo "Comando VPN desconocido: $2"; show_help ;;
            esac
            ;;
        "fail2ban")
            case "$2" in
                "status") fail2ban_status ;;
                *) echo "Comando Fail2ban desconocido: $2"; show_help ;;
            esac
            ;;
        "clamav")
            case "$2" in
                "scan") clamav_scan "$3" ;;
                "update") clamav_update ;;
                *) echo "Comando ClamAV desconocido: $2"; show_help ;;
            esac
            ;;
        "rkhunter")
            case "$2" in
                "scan") rkhunter_scan ;;
                "update") rkhunter_update ;;
                *) echo "Comando RKHunter desconocido: $2"; show_help ;;
            esac
            ;;
        "network")
            case "$2" in
                "monitor") network_monitor ;;
                *) echo "Comando de red desconocido: $2"; show_help ;;
            esac
            ;;
        "port")
            case "$2" in
                "scan") port_scan "$3" ;;
                *) echo "Comando de puerto desconocido: $2"; show_help ;;
            esac
            ;;
        "traffic")
            case "$2" in
                "monitor") traffic_monitor ;;
                *) echo "Comando de tráfico desconocido: $2"; show_help ;;
            esac
            ;;
        "help"|"--help"|"-h")
            show_help
            ;;
        *)
            echo "Comando desconocido: $1"
            show_help
            exit 1
            ;;
    esac
}

# Ejecutar función principal
main "$@" 