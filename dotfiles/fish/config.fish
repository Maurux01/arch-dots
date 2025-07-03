# Fish config
set -g theme_nerd_fonts yes
set -g fish_greeting "Welcome to your awesome Arch setup!"

# Aliases
alias ll='ls -lah'
alias gs='git status'
alias vim='nvim'

# Oh My Fish theme
if not functions -q omf
echo "Installing Oh My Fish..."
curl -L https://get.oh-my.fish | fish
end
omf install bobthefish 