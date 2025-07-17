#!/bin/bash

# Modern Tmux Configuration Installation Script
# Installs all dependencies and configuration files

set -e

echo "🚀 Installing Modern Tmux Configuration..."

# Colors for output
RED=undefined0330;31
GREEN='\033;32m'
YELLOW='\331;33mBLUE=0330;34
NC='\33[0m' # No Color

# Function to print colored output
print_status() [object Object]  echo -e${GREEN}[INFO]${NC} $1}

print_warning() [object Object]   echo -e ${YELLOW}[WARNING]${NC} $1
}

print_error()[object Object]    echo -e ${RED}[ERROR]${NC} $1
}

print_header()[object Object]
    echo -e ${BLUE}=== $1 ===${NC}"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    print_error "This script should not be run as root
    exit 1
fi

# Install dependencies
install_dependencies() [object Object]    print_header "Installing Dependencies   # Check package manager
    if command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman       PKG_INSTALL=sudo pacman -S --noconfirm    elif command -v apt &> /dev/null; then
        PKG_MANAGER="apt       PKG_INSTALL="sudo apt update && sudo apt install -y    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf       PKG_INSTALL="sudo dnf install -y    elif command -v brew &> /dev/null; then
        PKG_MANAGER=brew       PKG_INSTALL=brew installelse
        print_error "Unsupported package manager. Please install dependencies manually."
        exit1 fi
    
    print_status "Using package manager: $PKG_MANAGER"
    
    # Install Tmux and dependencies
    $PKG_INSTALL tmux fzf git lazygit
    
    # Install clipboard tools (choose one based on display server)
    if [ $XDG_SESSION_TYPE" = wayland" ]; then
        $PKG_INSTALL wl-clipboard
    else
        $PKG_INSTALL xclip
    fi
    
    # Install Nerd Fonts (if not already installed)
    if command -v pacman &> /dev/null; then
        $PKG_INSTALL nerd-fonts-jetbrains-mono
    fi
    
    print_status "Dependencies installed successfully}

# Install TPM (Tmux Plugin Manager)
install_tpm() [object Object]    print_headerInstalling TPM    
    # Clone TPM if it doesn't exist
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        print_status "TPM installed successfullyelse
        print_status "TPM already installed"
    fi
}

# Install configuration files
install_config() [object Object]    print_header "Installing Configuration Files"
    
    # Create config directory
    mkdir -p ~/.config/tmux
    
    # Copy configuration files
    cp -r dotfiles/tmux/* ~/.config/tmux/
    
    # Create symlink for tmux config
    ln -sf ~/.config/tmux/tmux.conf ~/.tmux.conf
    
    # Make scripts executable
    chmod +x ~/.config/tmux/scripts/*.sh
    
    print_status "Configuration files installed successfully"
}

# Install plugins
install_plugins() [object Object]    print_header "Installing Plugins   
    # Start tmux and install plugins
    tmux start-server
    tmux source-file ~/.tmux.conf
    
    # Install plugins using TPM
    ~/.tmux/plugins/tpm/bin/install_plugins
    
    print_status Plugins installed successfully"
}

# Create desktop entry
create_desktop_entry() [object Object]    print_headerCreating Desktop Entry  
    DESKTOP_DIR="$HOME/.local/share/applications"
    mkdir -p "$DESKTOP_DIR"
    
    cat > $DESKTOP_DIR/tmux-ide.desktop" << EOF
[Desktop Entry]
Name=Tmux IDE
Comment=Modern Tmux IDE
Exec=tmux
Terminal=true
Type=Application
Categories=Development;System;TerminalEmulator;
Icon=terminal
StartupNotify=false
EOF
    
    print_status "Desktop entry created"
}

# Post-installation instructions
show_post_install_info() [object Object]    print_header "Installation Complete!  echo -e ${GREEN}🎉 Modern Tmux configuration has been installed successfully!${NC}"
    echo
    echoNext steps:"
    echo "1. Restart your terminal or run: source ~/.bashrc"
    echo "2. Launch Tmux with: tmux"
    echo "3Install plugins by pressing: <prefix> + I (capital i)    echo 4. Use <prefix> + ? to see all keybindings"
    echo
    echo "Key features:"
    echo "• Modern status bar with system information"
    echo "• Vim-style navigation (h/j/k/l for panes) echo • Easy copy/paste with clipboard integration"
    echo • FZF integration for fuzzy finding   echo• LazyGit and Neovim integration"
    echo • Multiple themes (T=Catppuccin, G=Gruvbox)"
    echo
    echo "For more information, see: ~/.config/tmux/README.md"
    echo
    echoHappy coding! 🚀"
}

# Main installation function
main() [object Object]    print_header "Modern Tmux Configuration Installation"
    
    # Install dependencies
    install_dependencies
    
    # Install TPM
    install_tpm
    
    # Install configuration files
    install_config
    
    # Install plugins
    install_plugins
    
    # Create desktop entry
    read -p "Do you want to create a desktop entry? (y/n):  -n1 -r
    echo
    if[ $REPLY =~ ^[Yy]$ ]]; then
        create_desktop_entry
    fi
    
    # Show post-installation info
    show_post_install_info
}

# Run main function
main "$@" 