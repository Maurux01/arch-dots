# Fish config
set -g theme_nerd_fonts yes
set -g fish_greeting "Welcome to your awesome Arch setup!"

# Aliases
alias ll='ls -lah'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias lg='lazygit'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias top='btop'
alias y='yazi'
alias z='zoxide'
alias fz='fzf'

# Oh My Fish theme
if not functions -q omf
echo "Installing Oh My Fish..."
curl -L https://get.oh-my.fish | fish
end
omf install bobthefish 

# Función para backup rápido de dotfiles
dotbackup() {
  cd ~/github/arch-dots
  git add .
  git commit -m "Backup: $(date '+%Y-%m-%d %H:%M')"
  git push
  cd -
  echo "Backup subido a GitHub!"
} 