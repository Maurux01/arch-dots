#!/bin/bash

# =============================================================================
#                           🐛 JS DEBUG INSTALLER
# =============================================================================
# Script para instalar herramientas de debugging de JavaScript para Neovim
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
    echo -e "${BLUE} ═════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}║                    🐛 JS DEBUG INSTALLER                   ║${NC}"
    echo -e "${BLUE}║                    JavaScript Debugging Tools               ║${NC}"
    echo -e "${BLUE} ════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_section() {
    echo -e "${CYAN}› $1${NC}"
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

print_info() {
    echo -e "${BLUE}  ℹ $1${NC}"
}

# Verificar Node.js
check_nodejs() {
    print_section "Verificando Node.js..."
    
    if ! command -v node >/dev/null 2>&1; then
        print_error "Node.js no está instalado."
        print_info "Instala Node.js antes de continuar:"
        print_info "  sudo pacman -S nodejs npm"
        exit 1
    fi
    
    NODE_VERSION=$(node --version)
    print_success "Node.js $NODE_VERSION encontrado."
}

# Instalar js-debug
install_js_debug() {
    print_section "Instalando js-debug..."
    
    local JS_DEBUG_DIR="$HOME/.local/share/nvim/dapinstall/jsnode_modules"
    
    print_step "Creando directorio para js-debug..."
    mkdir -p "$JS_DEBUG_DIR"
    
    print_step "Instalando js-debug..."
    cd "$JS_DEBUG_DIR"
    
    if [ ! -d "js-debug" ]; then
        git clone https://github.com/microsoft/vscode-js-debug.git js-debug
    else
        print_info "js-debug ya existe, actualizando..."
        cd js-debug
        git pull origin main
        cd ..
    fi
    
    print_step "Instalando dependencias de js-debug..."
    cd js-debug
    npm install
    npm run compile
    
    print_success "js-debug instalado correctamente."
}

# Instalar herramientas adicionales
install_additional_tools() {
    print_section "Instalando herramientas adicionales..."
    
    print_step "Instalando Chrome para debugging..."
    if ! command -v google-chrome >/dev/null 2>&1; then
        print_info "Instalando Google Chrome..."
        yay -S google-chrome --noconfirm --needed
    else
        print_success "Google Chrome ya está instalado."
    fi
    
    print_step "Instalando Firefox para debugging..."
    if ! command -v firefox >/dev/null 2>&1; then
        print_info "Instalando Firefox..."
        sudo pacman -S firefox --noconfirm --needed
    else
        print_success "Firefox ya está instalado."
    fi
    
    print_step "Instalando herramientas de desarrollo..."
    sudo pacman -S --noconfirm --needed \
        npm \
        yarn \
        pnpm \
        typescript \
        @types/node
}

# Crear configuración de ejemplo
create_example_config() {
    print_section "Creando configuración de ejemplo..."
    
    local EXAMPLE_DIR="$HOME/.config/nvim/examples"
    mkdir -p "$EXAMPLE_DIR"
    
    cat > "$EXAMPLE_DIR/debug-example.js" << 'EOF'
// Ejemplo de código JavaScript para debugging
function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

function factorial(n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

// Función principal
function main() {
    console.log("Iniciando debugging...");
    
    const num = 10;
    console.log(`Fibonacci de ${num}: ${fibonacci(num)}`);
    console.log(`Factorial de ${num}: ${factorial(num)}`);
    
    // Punto de parada para debugging
    debugger;
    
    console.log("Debugging completado.");
}

main();
EOF

    cat > "$EXAMPLE_DIR/debug-launch.json" << 'EOF'
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch Node.js",
            "type": "node2",
            "request": "launch",
            "program": "${file}",
            "cwd": "${workspaceFolder}",
            "sourceMaps": true,
            "protocol": "inspector",
            "console": "integratedTerminal"
        },
        {
            "name": "Attach to Node.js",
            "type": "node2",
            "request": "attach",
            "port": 9229,
            "sourceMaps": true,
            "localRoot": "${workspaceFolder}",
            "remoteRoot": "/"
        },
        {
            "name": "Launch Chrome",
            "type": "chrome",
            "request": "launch",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}",
            "sourceMaps": true
        }
    ]
}
EOF

    print_success "Configuración de ejemplo creada en $EXAMPLE_DIR"
}

# Verificar instalación
verify_installation() {
    print_section "Verificando instalación..."
    
    local JS_DEBUG_DIR="$HOME/.local/share/nvim/dapinstall/jsnode_modules/js-debug"
    
    if [ -d "$JS_DEBUG_DIR" ]; then
        print_success "js-debug instalado correctamente."
    else
        print_error "js-debug no se instaló correctamente."
        exit 1
    fi
    
    if [ -f "$JS_DEBUG_DIR/src/dapDebugServer.js" ]; then
        print_success "DAP Debug Server encontrado."
    else
        print_error "DAP Debug Server no encontrado."
        exit 1
    fi
    
    print_success "Instalación verificada correctamente."
}

# Mostrar instrucciones de uso
show_usage() {
    print_section "Instrucciones de uso:"
    
    echo ""
    echo -e "${CYAN}Para usar el debugging de JavaScript:${NC}"
    echo ""
    echo "1. Abre un archivo JavaScript en Neovim"
    echo "2. Coloca el cursor en la línea donde quieres un breakpoint"
    echo "3. Presiona <leader>db para crear un breakpoint"
    echo "4. Presiona <leader>dc para iniciar el debugging"
    echo ""
    echo -e "${CYAN}Comandos de debugging disponibles:${NC}"
    echo ""
    echo "  <leader>db  - Toggle breakpoint"
    echo "  <leader>dc  - Continue"
    echo "  <leader>di  - Step into"
    echo "  <leader>do  - Step over"
    echo "  <leader>dr  - Toggle REPL"
    echo "  <leader>dj  - Down"
    echo "  <leader>dk  - Up"
    echo "  <leader>dl  - Run last"
    echo "  <leader>dp  - Pause"
    echo ""
    echo -e "${CYAN}Para debugging en el navegador:${NC}"
    echo ""
    echo "1. Inicia tu aplicación en el puerto 3000"
    echo "2. Abre Chrome con debugging habilitado:"
    echo "   google-chrome --remote-debugging-port=9222"
    echo "3. En Neovim, usa la configuración 'Attach to Chrome'"
    echo ""
    echo -e "${CYAN}Ejemplo de código para probar:${NC}"
    echo ""
    echo "El archivo de ejemplo está en: ~/.config/nvim/examples/debug-example.js"
    echo ""
}

# Función principal
main() {
    print_header
    
    check_nodejs
    install_js_debug
    install_additional_tools
    create_example_config
    verify_installation
    show_usage
    
    echo ""
    print_success "¡Instalación completada! 🐛✨"
    echo ""
    print_info "Reinicia Neovim para aplicar los cambios."
    echo ""
}

# Ejecutar función principal
main "$@" 