# Fish config - Modern & Beautiful
# Enhanced with Starship, better aliases, and modern features

# =============================================================================
# CONFIGURACIÓN BÁSICA
# =============================================================================

# Configuración de historial
set -g history_size 10000
set -g fish_escape_delay_ms 10
set -g fish_autosuggestion_enabled 1
set -g fish_autosuggestion_highlight_color 555

# Configuración de colores
set -g fish_color_normal normal
set -g fish_color_command 89b4fa
set -g fish_color_quote a6e3a1
set -g fish_color_redirection f5c2e7
set -g fish_color_end f38ba8
set -g fish_color_error f38ba8
set -g fish_color_param cdd6f4
set -g fish_color_comment 6c7086
set -g fish_color_match --background=313244
set -g fish_color_selection --background=313244
set -g fish_color_search_match --background=313244
set -g fish_color_operator f5c2e7
set -g fish_color_escape f5c2e7
set -g fish_color_cwd 89b4fa
set -g fish_color_cwd_root f38ba8
set -g fish_color_valid_path --underline
set -g fish_color_autosuggestion 6c7086
set -g fish_color_user a6e3a1
set -g fish_color_host 89b4fa
set -g fish_color_cancel f38ba8
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description 6c7086
set -g fish_pager_color_progress 89b4fa --background=313244
set -g fish_pager_color_secondary 6c7086

# Configuración de autocompletado
set -g fish_autosuggestion_enabled 1
set -g fish_autosuggestion_highlight_color 555
set -g fish_autosuggestion_highlight_force_color 1

# =============================================================================
# ALIASES MODERNOS
# =============================================================================

# Navegación mejorada
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias --='cd -'

# Listado de archivos mejorado (solo si exa está instalado)
if command -v exa >/dev/null 2>&1
    alias ll='exa -l --icons --group-directories-first'
    alias la='exa -la --icons --group-directories-first'
    alias lt='exa -T --icons --group-directories-first'
    alias l.='exa -ld .* --icons'
    alias lsize='exa -l --icons --sort=size'
    alias ldate='exa -l --icons --sort=modified'
else
    # Fallback a ls si exa no está disponible
    alias ll='ls -lah'
    alias la='ls -A'
    alias lt='tree'
    alias l.='ls -ld .*'
    alias lsize='ls -lahS'
    alias ldate='ls -laht'
end

# Git aliases mejorados
alias g='git'
alias gs='git status -s'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate --all'
alias gst='git stash'
alias gstp='git stash pop'
alias gaa='git add .'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gpl='git pull'
alias gps='git push'
alias gpsu='git push -u origin HEAD'

# Herramientas modernas (solo si están instaladas)
if command -v bat >/dev/null 2>&1
    alias cat='bat --style=full'
end

if command -v fd >/dev/null 2>&1
    alias find='fd'
end

if command -v rg >/dev/null 2>&1
    alias grep='rg'
end

if command -v btop >/dev/null 2>&1
    alias top='btop'
end

if command -v yazi >/dev/null 2>&1
    alias y='yazi'
end

if command -v zoxide >/dev/null 2>&1
    alias z='zoxide'
end

if command -v fzf >/dev/null 2>&1
    alias fz='fzf'
end

if command -v httpie >/dev/null 2>&1
    alias h='httpie'
end

if command -v just >/dev/null 2>&1
    alias j='just'
end

# Docker aliases
if command -v docker >/dev/null 2>&1
    alias d='docker'
    alias dc='docker-compose'
    alias dps='docker ps'
    alias dimg='docker images'
    alias dex='docker exec -it'
    alias dlogs='docker logs'
    alias dstop='docker stop'
    alias drm='docker rm'
    alias drmi='docker rmi'
end

# Lazydocker alias
if command -v lazydocker >/dev/null 2>&1
    alias ld='lazydocker'
end

# System monitoring aliases
if command -v ncdu >/dev/null 2>&1
    alias disk='ncdu'
end

if command -v iotop >/dev/null 2>&1
    alias io='iotop'
end

if command -v nvtop >/dev/null 2>&1
    alias gpu='nvtop'
end

# Network aliases
if command -v speedtest-cli >/dev/null 2>&1
    alias speed='speedtest-cli'
end

if command -v nmtui >/dev/null 2>&1
    alias net='nmtui'
end

# Waypaper aliases
if command -v waypaper >/dev/null 2>&1
    alias wp='waypaper'
    alias wpr='waypaper --random'
    alias wps='waypaper --restore'
    alias wpd='waypaper --daemon'
    alias wpg='waypaper --gui'
    alias wpn='waypaper --next'
    alias wpp='waypaper --previous'
    alias wpl='waypaper --list'
end

# Sistema mejorado
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias ports='ss -tulanp'
alias mem='free -h | grep "Mem" | awk "{print \$3\"/\"\$2}"'
alias cpu='top -bn1 | grep "Cpu(s)" | awk "{print \$2}" | cut -d"%" -f1'

# Aplicaciones
alias nv='nvim'
alias vim='nvim'
alias vi='nvim'
alias e='eww'
alias hc='hyprctl'
alias w='wofi'

# =============================================================================
# FUNCIONES ÚTILES
# =============================================================================

# Función para backup rápido de dotfiles
function dotbackup
    echo "🔄 Haciendo backup de dotfiles..."
    cd ~/github/archriced
    git add .
    git commit -m "Backup: $(date '+%Y-%m-%d %H:%M:%S')"
    git push
    cd -
    echo "✅ Backup subido a GitHub!"
end

# Función para actualizar sistema
function update
    echo "🔄 Actualizando sistema..."
    sudo pacman -Syu
    echo "🧹 Limpiando caché..."
    sudo pacman -Sc
    echo "✅ Sistema actualizado!"
end

# Función para buscar paquetes
function search
    pacman -Ss $argv
end

# Función para instalar paquetes
function install
    sudo pacman -S $argv
end

# Función para desinstalar paquetes
function remove
    sudo pacman -R $argv
end

# Función para ver información del sistema
function sysinfo
    fastfetch
end

# Función para alternar entre Neofetch y Fastfetch
function sysinfo-alt
    if command -v fastfetch >/dev/null 2>&1; then
        fastfetch
    else
        neofetch
    end
end

# Función para ver el clima
function weather
    curl wttr.in/$argv
end

# Función para crear directorio y entrar
function mkcd
    mkdir -p $argv && cd $argv
end

# Función para extraer cualquier archivo
function extract
    if test -f $argv[1]
        switch $argv[1]
            case "*.tar.gz" "*.tgz"
                tar -xzf $argv[1]
            case "*.tar.bz2" "*.tbz"
                tar -xjf $argv[1]
            case "*.tar.xz" "*.txz"
                tar -xJf $argv[1]
            case "*.tar"
                tar -xf $argv[1]
            case "*.zip"
                unzip $argv[1]
            case "*.rar"
                unrar x $argv[1]
            case "*.7z"
                7z x $argv[1]
            case "*"
                echo "No se puede extraer $argv[1]"
        end
    else
        echo "El archivo $argv[1] no existe"
    end
end

# Función para limpiar archivos temporales
function cleanup
    echo "🧹 Limpiando archivos temporales..."
    sudo pacman -Sc --noconfirm
    sudo rm -rf /tmp/*
    sudo rm -rf /var/tmp/*
    echo "✅ Limpieza completada!"
end

# Función para mostrar puertos en uso
function ports
    echo "🔍 Puertos en uso:"
    ss -tulanp
end

# Función para mostrar procesos
function procs
    ps aux | grep -i $argv
end

# Función para Docker
function docker-clean
    echo "🧹 Limpiando Docker..."
    docker system prune -f
    docker volume prune -f
    docker network prune -f
    echo "✅ Docker limpiado!"
end

# Función para monitorear sistema
function monitor
    echo "📊 Monitoreo del sistema:"
    echo "CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1)%"
    echo "Memoria: $(free -h | grep Mem | awk '{print $3"/"$2}')"
    echo "Disco: $(df -h / | tail -1 | awk '{print $5}')"
    echo "Red: $(ss -tulanp | wc -l) conexiones activas"
end

# Función para test de velocidad
function speedtest
    if command -v speedtest-cli >/dev/null 2>&1
        echo "🌐 Ejecutando test de velocidad..."
        speedtest-cli --simple
    else
        echo "❌ speedtest-cli no está instalado"
    end
end

# Función para análisis de disco
function disk-usage
    if command -v ncdu >/dev/null 2>&1
        echo "💾 Analizando uso de disco..."
        ncdu
    else
        echo "❌ ncdu no está instalado"
    end
end

# Función para gestionar wallpapers con waypaper
function wallpaper-manager
    if command -v waypaper >/dev/null 2>&1
        echo "🎨 Gestor de wallpapers con Waypaper:"
        echo "  wp        - Abrir waypaper"
        echo "  wpr       - Wallpaper aleatorio"
        echo "  wps       - Restaurar wallpaper"
        echo "  wpd       - Iniciar daemon"
        echo "  wpg       - Interfaz gráfica"
        echo "  wpn       - Siguiente wallpaper"
        echo "  wpp       - Wallpaper anterior"
        echo "  wpl       - Listar wallpapers"
        echo ""
        echo "Atajos de teclado:"
        echo "  SUPER+SHIFT+W - Wallpaper aleatorio"
        echo "  SUPER+CTRL+W  - Restaurar wallpaper"
        echo "  SUPER+ALT+W   - Iniciar daemon"
        echo "  SUPER+CTRL+ALT+W - Interfaz gráfica"
        echo "  SUPER+SHIFT+ALT+W - Siguiente wallpaper"
        echo "  SUPER+CTRL+SHIFT+W - Wallpaper anterior"
        echo ""
        echo "Configuración:"
        echo "  • Archivo: ~/.config/waypaper/waypaper.json"
        echo "  • Wallpapers: ~/Pictures/wallpapers/"
        echo "  • Auto-inicio: ~/.config/autostart/waypaper.desktop"
    else
        echo "❌ waypaper no está instalado"
    end
end

# =============================================================================
# CONFIGURACIÓN DE HERRAMIENTAS
# =============================================================================

# Configuración de fzf (solo si está instalado)
if command -v fzf >/dev/null 2>&1
    set -g FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --preview "bat --style=numbers --color=always --line-range :500 {}"'
    set -g FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
    set -g FZF_CTRL_T_COMMAND 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
    set -g FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git --exclude node_modules'
end

# Configuración de zoxide (solo si está instalado)
if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source
end

# Configuración de atuin (historial mejorado)
if command -v atuin >/dev/null 2>&1
    atuin init fish | source
end

# =============================================================================
# CONFIGURACIÓN DE STARSHIP
# =============================================================================

# Instalar Starship si no está instalado
if not command -v starship >/dev/null 2>&1
    # Sin mensaje de bienvenida
else
    # Inicializar Starship
    starship init fish | source
end

# =============================================================================
# CONFIGURACIÓN DE PLUGINS
# =============================================================================

# Fisher plugin manager (opcional)
if not functions -q fisher
    # Sin mensaje de bienvenida
end

# Plugins útiles (solo si fisher está disponible)
if command -v fisher >/dev/null 2>&1
    fisher install PatrickF1/fzf.fish
    fisher install PatrickF1/colored_man_pages.fish
    fisher install jethrokuan/z
    fisher install IlanCosman/tide@v5
    fisher install IlanCosman/fish-gpt
end

# =============================================================================
# CONFIGURACIÓN DE FISH GPT
# =============================================================================

# Configuración de Fish GPT (solo si está instalado)
if functions -q gpt
    # Configurar API key (opcional - descomenta y agrega tu key)
    # set -g fish_gpt_api_key "tu-api-key-aqui"
    
    # Configuración de Fish GPT
    set -g fish_gpt_model "gpt-3.5-turbo"
    set -g fish_gpt_max_tokens 150
    set -g fish_gpt_temperature 0.7
    
    # Función para explicar comandos con IA
    function explain
        gpt "Explica qué hace este comando: $argv"
    end
    
    # Función para generar comandos con IA
    function generate
        gpt "Genera un comando para: $argv"
    end
    
    # Función para optimizar comandos con IA
    function optimize
        gpt "Optimiza este comando: $argv"
    end
    
    # Función para debugging con IA
    function debug
        gpt "Ayúdame a debuggear este problema: $argv"
    end
    
    # Sin mensaje de bienvenida
end

# =============================================================================
# CONFIGURACIÓN FINAL
# =============================================================================

# Mensaje de bienvenida personalizado (deshabilitado)
function fish_greeting
    # Sin mensaje de bienvenida
end

# Función de ayuda personalizada
function help
    echo "📚 Comandos útiles:"
    echo ""
    echo "🔄 Sistema:"
    echo "  update    - Actualizar sistema"
    echo "  cleanup   - Limpiar archivos temporales"
    echo "  sysinfo   - Información del sistema (Fastfetch)"
    echo "  sysinfo-alt - Alternar entre Neofetch/Fastfetch"
    echo ""
    echo "📁 Navegación:"
    echo "  ll        - Listar archivos (exa)"
    echo "  lt        - Árbol de directorios"
    echo "  mkcd      - Crear directorio y entrar"
    echo ""
    echo "🐙 Git:"
    echo "  gs        - Status git"
    echo "  glog      - Log git con gráfico"
    echo "  dotbackup - Backup de dotfiles"
    echo ""
    echo "🔍 Búsqueda:"
    echo "  fz        - FZF"
    echo "  search    - Buscar paquetes"
    echo "  procs     - Buscar procesos"
    echo ""
    echo "🐳 Docker:"
    echo "  d         - Docker"
    echo "  dc        - Docker Compose"
    echo "  dps       - Docker containers"
    echo "  dimg      - Docker images"
    echo "  ld        - Lazydocker"
    echo "  docker-clean - Limpiar Docker"
    echo ""
    echo "📊 Monitoreo:"
    echo "  monitor   - Estado del sistema"
    echo "  speedtest - Test de velocidad"
    echo "  disk-usage - Análisis de disco"
    echo "  disk      - ncdu"
    echo "  io        - iotop"
    echo "  gpu       - nvtop"
    echo "  net       - nmtui"
    echo ""
    echo "🎨 Wallpapers:"
    echo "  wp        - Waypaper"
    echo "  wpr       - Wallpaper aleatorio"
    echo "  wps       - Restaurar wallpaper"
    echo "  wpd       - Iniciar daemon"
    echo "  wpg       - Interfaz gráfica"
    echo "  wpn       - Siguiente wallpaper"
    echo "  wpp       - Wallpaper anterior"
    echo "  wpl       - Listar wallpapers"
    echo "  wallpaper-manager - Ayuda de wallpapers"
    echo ""
    echo "🌤️  Utilidades:"
    echo "  weather   - Clima"
    echo "  extract   - Extraer archivos"
    echo "  ports     - Puertos en uso"
    echo ""
    if functions -q gpt
        echo "🤖 IA (Fish GPT):"
        echo "  gpt      - Chat con IA"
        echo "  explain  - Explicar comando"
        echo "  generate - Generar comando"
        echo "  optimize - Optimizar comando"
        echo "  debug    - Ayuda con debugging"
    end
end

# Configuración de variables de entorno
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER firefox
set -gx TERM xterm-256color

# Configuración de PATH
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

# Sin mensaje de bienvenida 