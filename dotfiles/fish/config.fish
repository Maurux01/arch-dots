# Fish config - Enhanced version
set -g theme_nerd_fonts yes
set -g fish_greeting "🐟 Welcome to your awesome Arch setup!"

# Configuración de historial
set -g history_size 10000
set -g fish_escape_delay_ms 10

# Configuración de autocompletado
set -g fish_autosuggestion_enabled 1
set -g fish_autosuggestion_highlight_color 555

# Aliases básicos
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
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

# Herramientas de desarrollo
alias lg='lazygit'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias top='btop'
alias y='yazi'
alias z='zoxide'
alias fz='fzf'

# Sistema
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias ports='netstat -tulanp'

# Configuración de aplicaciones
alias nv='nvim'
alias vim='nvim'
alias vi='nvim'
alias e='eww'
alias h='hyprctl'

# Función para backup rápido de dotfiles
function dotbackup
  cd ~/github/arch-dots
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
  neofetch
end

# Función para ver el clima
function weather
  curl wttr.in/$argv
end

# Configuración de Oh My Fish
if not functions -q omf
  echo "🐟 Instalando Oh My Fish..."
  curl -L https://get.oh-my.fish | fish
end

# Instalar tema si no está instalado
if not omf theme | grep -q bobthefish
  omf install bobthefish
end

# Configuración del tema
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_default_branch yes
set -g theme_git_default_branches master main
set -g theme_git_worktree_support yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine yes
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_nix yes
set -g theme_display_ruby yes
set -g theme_display_node yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_jobs_verbose yes
set -g default_user your_normal_user
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '

# Configuración de fzf
set -g FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
set -g FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'

# Configuración de zoxide
zoxide init fish | source

# Configuración de atuin (historial mejorado)
if command -v atuin >/dev/null 2>&1
  atuin init fish | source
end

echo "🐟 Fish configurado con éxito!" 