# File: config.fish
# Fish config - Optimized for Gruvbox theme

# --- General Settings ---
set fish_greeting "" # Hide the default greeting message
set -g fish_escape_delay_ms 10
set -g fish_autosuggestion_enabled 1
set -g fish_autosuggestion_highlight_color 555
set -g history_size 10000

# Disable welcome messages but keep history
set -g fish_greeting ""
set -g fish_initialized 1

# --- Gruvbox Color Scheme ---
# Set Gruvbox colors for Fish
set -g fish_color_normal normal
set -g fish_color_command 928374
set -g fish_color_param 83a598
set -g fish_color_redirection 83a598
set -g fish_color_comment 928374
set -g fish_color_error fb4934
set -g fish_color_escape 83a598
set -g fish_color_operator 83a598
set -g fish_color_end 83a598
set -g fish_color_quote b8bb26
set -g fish_color_autosuggestion 928374
set -g fish_color_user 83a598
set -g fish_color_host 83a598
set -g fish_color_host_remote 83a598
set -g fish_color_valid_path 83a598
set -g fish_color_match 83a598
set -g fish_color_search_match 83a598
set -g fish_color_selection 83a598
set -g fish_color_cwd 83a598
set -g fish_color_cwd_root 83a598
set -g fish_color_status fb4934

# --- Aliases ---

# Basic navigation
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias c='cd'
alias d='rf-rm'
alias s='sudo'
# Eliminar alias p si existe
# alias p='pacman'

# Definir función p para llamar a pacman con todos los argumentos
function p
    pacman $argv
end

# Terminal management
alias q='exit'  # Quick exit from terminal
alias t='tmux-session'  # Quick tmux session
alias tm='tmux-session main'
alias tdev='tmux-session dev'
alias twork='tmux-session work'
alias e='exit'  # Alias para salir rápido con 'e'

# Git
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate'

# Alias adicionales para git
alias gcl='git clone'
alias gca='git commit --amend'
alias gsta='git stash'
alias gstp='git stash pop'
alias gss='git status -s'
alias gundo='git reset --soft HEAD~1'
alias gfix='git commit --fixup'
alias gpr='git pull --rebase'
alias glogg='git log --graph --decorate --oneline --all'

# Modern tools replacements
alias lg='lazygit'
alias cat='bat --paging=never' # Use bat instead of cat
alias find='fd'
alias grep='rg'
alias top='btop'
alias y='yazi'
alias fz='fzf'

# System utilities
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias ports='netstat -tulanp'
alias meminfo='free -h | grep "Mem" | awk "{printf \"Memoria: %s / %s (%.2f%%)\n\", \$3, \$2, \$3/\$2*100.0}"'
alias cpuinfo='top -bn1 | grep "Cpu(s)" | awk "{printf \"CPU: %.2f%%\n\", \$2}"'

# Applications
alias nv='nvim'
alias vim='nvim'
alias vi='nvim'
alias e='eww'
alias h='hyprctl'
alias mp='mpd'
alias rmpc='rmpc'
alias spot='spotify-cli'
alias gem='gemini-cli'
alias yt='ytui-music'

# GRUB theme
alias grub-theme='~/.config/scripts/install-grub-theme.sh'

# Utilities
alias speedtest='speedtest-cli'
alias myip='curl -s https://ipinfo.io/ip'

# --- Functions ---

# Backup dotfiles to a git repository
function dotbackup
    # IMPORTANT: Change this path to your dotfiles repository
    cd ~/github/arch-dots
    git add .
    git commit -m "Backup: $(date '+%Y-%m-%d %H:%M:%S')"
    git push
    cd -
    echo "✅ Backup subido a GitHub!"
end

# Update Arch Linux system
function update
    echo "🔄 Actualizando sistema (Pacman)..."
    s pacman -Syu --noconfirm
    echo "🧹 Limpiando caché de paquetes..."
    s pacman -Sc --noconfirm
    echo "✅ Sistema actualizado!"
end

# Alias para actualizar el sistema rápidamente
alias update="sudo pacman -Syu"

# Pacman wrappers
function search
    pacman -Ss $argv
end

function install
    s pacman -S $argv
end

function remove
    s pacman -Rns $argv
end

# Show system info
function sysinfo
    neofetch
end

# Get weather
function weather
    curl wttr.in/$argv
end

# Extract any archive
function extract --argument-names file
    if not test -f "$file"
        echo "Error: Archivo no encontrado en '$file'"
        return 1
    end

    switch "$file"
        case "*.tar.gz" "*.tgz"
            tar -xzf "$file"
        case "*.tar.bz2" "*.tbz"
            tar -xjf "$file"
        case "*.tar.xz" "*.txz"
            tar -xJf "$file"
        case "*.zip"
            unzip "$file"
        case "*.rar"
            unrar x "$file"
        case "*.7z"
            7z x "$file"
        case "*"
            echo "Error: Formato de archivo no soportado."
            return 1
    end
    echo "✅ Archivo extraído: $file"
end

# Create a directory and cd into it
function mkcd --argument-names dir
    if test -z "$dir"
        echo "Uso: mkcd <nombre_directorio>"
        return 1
    end
    mkdir -p "$dir" && cd "$dir"
end
# Create a timestamped backup of a file
function backup --argument-names file
    if not test -f "$file"
        echo "Error: Archivo no encontrado en '$file'"
        return 1
    end
    set -l backup_name "$file.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$file" "$backup_name"
    echo "✅ Backup creado: $backup_name"
end

# Start a simple web server in the current directory
function serve --argument-names port
    set -l server_port (or $port 8000)
    echo "🌐 Sirviendo en http://localhost:$server_port"
    python3 -m http.server $server_port
end

# Easy tmux integration
function tmux-session --argument-names session_name
    if test -z "$session_name"
        set session_name "main"
    end
    
    if tmux has-session -t "$session_name" 2>/dev/null
        echo "🔗 Conectando a sesión tmux existente: $session_name"
        tmux attach-session -t "$session_name"
    else
        echo "🆕 Creando nueva sesión tmux: $session_name"
        tmux new-session -s "$session_name"
    end
end

# Get cheat sheets from cheat.sh
function cheat
    curl cheat.sh/$argv
end

# Install Catppuccin GRUB theme
function install-grub-theme
    echo "🎨 Instalando tema GRUB Catppuccin..."
    if test -f ~/.config/scripts/install-grub-theme.sh
        ~/.config/scripts/install-grub-theme.sh
    else
        echo "❌ Script de instalación no encontrado"
        echo "💡 Ejecuta el instalador principal para obtener el script"
    end
end

# Alias para copiar y pegar en terminal (detecta entorno)
function cpr --description 'Copiar al portapapeles universal'
    if type -q wl-copy
        wl-copy
    else if type -q xclip
        xclip -selection clipboard
    else
        echo 'No se encontró wl-copy ni xclip'
        return 1
    end
end

function ppr --description 'Pegar desde el portapapeles universal'
    if type -q wl-paste
        wl-paste
    else if type -q xclip
        xclip -selection clipboard -o
    else
        echo 'No se encontró wl-paste ni xclip'
        return 1
    end
end

# --- Tools Initialization ---

# fzf (Fuzzy Finder)
set -g FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
set -g FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

# zoxide (Smarter cd)
if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source
end

# atuin (Magical shell history)
if command -v atuin >/dev/null 2>&1
    atuin init fish | source
end

# starship (The cross-shell prompt)
if command -v starship >/dev/null 2>&1
    starship init fish | source
end

# direnv (Environment switcher)
if command -v direnv >/dev/null 2>&1
    direnv hook fish | source
end

# --- Version Managers ---

# asdf (Universal version manager)
if command -v asdf >/dev/null 2>&1
    source (brew --prefix asdf)/libexec/asdf.fish
end

# nvm (Node Version Manager)
if command -v nvm >/dev/null 2>&1
    nvm use default >/dev/null 2>&1
end

# pyenv (Python Version Manager)
if command -v pyenv >/dev/null 2>&1
    pyenv init - | source
end

# rbenv (Ruby Version Manager)
if command -v rbenv >/dev/null 2>&1
    rbenv init - | source
end

# --- Completions ---

# Note for Terraform: Run `terraform -install-autocomplete` ONCE in your shell.
# Do not run it on every shell startup.
for tool in kubectl docker helm az
    if command -v $tool >/dev/null 2>&1
        $tool completion fish | source
    end
end

# --- PATH Configuration ---

# Optimized function to add directories to PATH if they exist and are not already there
function add_path --argument-names path
    if test -d "$path"
        if not contains "$path" $PATH
            set -gx PATH "$path" $PATH
        end
    end
end

# Add user-specific and system-wide binary paths
add_path $HOME/.local/bin
add_path $HOME/.local/scripts
add_path $HOME/bin
add_path $HOME/.cargo/bin
add_path $HOME/go/bin
add_path $HOME/flutter/bin
add_path $HOME/.deno/bin
add_path $HOME/.bun/bin
add_path $HOME/.npm-global/bin
add_path $HOME/.local/share/pnpm
add_path $HOME/.yarn/bin
add_path $HOME/.composer/vendor/bin
add_path /usr/local/bin
add_path /snap/bin
add_path /var/lib/flatpak/exports/bin

# --- End of config.fish ---

alias r='reset'

# Alias para reiniciar rápidamente
alias re='reboot'
alias sn='shutdown now'

# Alias útiles añadidos por solicitud (solo si no existen ya)
if not alias | grep -q "alias cp="
    alias cp='cp -i'
end
if not alias | grep -q "alias mv="
    alias mv='mv -i'
end
if not alias | grep -q "alias mkd="
    alias mkd='mkdir -p'
end
if not alias | grep -q "alias mkf="
    alias mkf='touch'
end
if not alias | grep -q "alias copy="
    alias copy='wl-copy'
end
if not alias | grep -q "alias paste="
    alias paste='wl-paste'
end

# Greeting personalizado: ícono + fetch
function fish_greeting --description 'Show random icon and fetch info'
    if type -q neofetch
        ~/dotfiles/scripts/fetch_with_icon.sh neofetch
    else if type -q fastfetch
        ~/dotfiles/scripts/fetch_with_icon.sh fastfetch
    end
end

