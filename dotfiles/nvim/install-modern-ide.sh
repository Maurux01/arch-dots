#!/bin/bash

# Modern Neovim IDE Installation Script
# Enhanced with all necessary dependencies and modern features

set -e

echo "🚀 Installing Modern Neovim IDE Configuration..."

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
   print_error "This script should not be run as root"
   exit 1
fi

# Detect package manager
detect_package_manager() [object Object]
    if command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman       PKG_INSTALL=sudo pacman -S --noconfirm    elif command -v apt &> /dev/null; then
        PKG_MANAGER="apt       PKG_INSTALL="sudo apt update && sudo apt install -y    elif command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf       PKG_INSTALL="sudo dnf install -y    elif command -v brew &> /dev/null; then
        PKG_MANAGER=brew       PKG_INSTALL=brew installelse
        print_error "Unsupported package manager. Please install dependencies manually."
        exit 1
    fi
}

# Install system dependencies
install_system_deps() [object Object]    print_header Installing System Dependencies"
    
    case $PKG_MANAGER in
pacman)
            $PKG_INSTALL neovim git ripgrep fd fzf nodejs npm python python-pip
            ;;
        apt)
            $PKG_INSTALL neovim git ripgrep fd-find fzf nodejs npm python3 python3-pip
            ;;
        dnf)
            $PKG_INSTALL neovim git ripgrep fd-find fzf nodejs npm python3 python3-pip
            ;;
        "brew)
            $PKG_INSTALL neovim git ripgrep fd fzf node
            ;;
    esac
    
    print_status "System dependencies installed successfully"
}

# Install language servers
install_language_servers() [object Object]    print_header "Installing Language Servers"
    
    # Node.js based LSPs
    npm install -g typescript typescript-language-server
    npm install -g @tailwindcss/language-server
    npm install -g @astrojs/language-server
    npm install -g svelte-language-server
    npm install -g vscode-langservers-extracted
    npm install -g @volar/vue-language-server
    
    # Python LSP
    pip3install python-lsp-server[all]
    pip3nstall black isort flake8 mypy
    
    # Rust LSP
    if command -v rustup &> /dev/null; then
        rustup component add rust-analyzer
    else
        print_warning "Rust not found. Install rustup for Rust support."
    fi
    
    # Go LSP
    if command -v go &> /dev/null; then
        go install golang.org/x/tools/gopls@latest
    else
        print_warning "Go not found. Install Go for Go language support."
    fi
    
    # Lua LSP
    if command -v luarocks &> /dev/null; then
        luarocks install lua-lsp
    else
        print_warning "LuaRocks not found. Install for Lua language support."
    fi
    
    print_statusLanguage servers installed successfully"
}

# Install additional tools
install_additional_tools() [object Object]    print_header "Installing Additional Tools"
    
    # LazyGit for Git integration
    if command -v go &> /dev/null; then
        go install github.com/jesseduffield/lazygit@latest
    else
        print_warning "Go not found. Install Go to get LazyGit."
    fi
    
    # Tree-sitter for better syntax highlighting
    if command -v npm &> /dev/null; then
        npm install -g tree-sitter-cli
    fi
    
    # Additional development tools
    case $PKG_MANAGER in
pacman)
            $PKG_INSTALL lazygit tree-sitter
            ;;
        apt)
            $PKG_INSTALL lazygit
            ;;
        dnf)
            $PKG_INSTALL lazygit
            ;;
        "brew)
            $PKG_INSTALL lazygit tree-sitter
            ;;
    esac
    
    print_statusAdditional tools installed successfully"
}

# Setup Neovim configuration
setup_neovim_config() [object Object]    print_header Setting up Neovim Configuration"
    
    # Create Neovim config directory
    NVIM_CONFIG_DIR="$HOME/.config/nvim"
    mkdir -p$NVIM_CONFIG_DIR"
    
    # Backup existing configuration
    if [ -d $NVIM_CONFIG_DIR" ] && [ "$(ls -A $NVIM_CONFIG_DIR)" ]; then
        print_warning "Existing Neovim configuration found. Creating backup..."
        mv $NVIM_CONFIG_DIR" ${NVIM_CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Copy configuration files
    print_status "Copying configuration files..."
    cp -r dotfiles/nvim/*$NVIM_CONFIG_DIR/"
    
    # Set proper permissions
    chmod -R755$NVIM_CONFIG_DIR"
    
    print_status "Neovim configuration setup completed"
}

# Install fonts (optional)
install_fonts() [object Object]    print_header "Installing Recommended Fonts"
    
    FONT_DIR="$HOME/.local/share/fonts   mkdir -p$FONT_DIR"
    
    # Download and install JetBrains Mono (recommended font)
    if ! fc-list | grep -qJetBrains Mono"; then
        print_status Installing JetBrains Mono font...   cd /tmp
        wget -O jetbrains-mono.zip "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304etBrainsMono-2.34zip      unzip -q jetbrains-mono.zip
        cp -r fonts/ttf/* "$FONT_DIR/        fc-cache -fv
        cd - > /dev/null
        print_status "JetBrains Mono font installedelse
        print_status "JetBrains Mono font already installed"
    fi
    
    # Download and install Nerd Fonts (for icons)
    if ! fc-list | grep -q Nerd Font"; then
        print_status "Installing Nerd Fonts...   cd /tmp
        wget -O nerd-fonts.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v30.1/JetBrainsMono.zip        unzip -q nerd-fonts.zip
        cp -r *.ttf "$FONT_DIR/        fc-cache -fv
        cd - > /dev/null
        print_status "Nerd Fonts installedelse
        print_status "Nerd Fonts already installed"
    fi
}

# Create desktop entry
create_desktop_entry() [object Object]    print_headerCreating Desktop Entry  
    DESKTOP_DIR="$HOME/.local/share/applications"
    mkdir -p "$DESKTOP_DIR"
    
    cat > $DESKTOP_DIR/neovim-ide.desktop" << EOF
[Desktop Entry]
Name=Neovim IDE
Comment=Modern Neovim IDE
Exec=nvim
Terminal=true
Type=Application
Categories=Development;TextEditor;
Icon=text-editor
EOF
    
    print_status "Desktop entry created"
}

# Post-installation instructions
show_post_install_info() [object Object]    print_header "Installation Complete!  
    echo -e ${GREEN}🎉 Modern Neovim IDE has been installed successfully!${NC}"
    echo
    echoNext steps:"
    echo "1. Restart your terminal or run: source ~/.bashrc"
    echo2.Launch Neovim with: nvimecho "3. The first launch will install all plugins automatically  echo "4. Use the dashboard to navigate and explore features"
    echo
    echo "Key features:"
    echo "• Beautiful dashboard with quick actions"
    echo • Multiple modern themes (use <leader>1/3 to switch)"
    echo "• Integrated terminal (<C-\\> to open)"
    echo "• Smart autocompletion and snippets"
    echo • Enhanced syntax highlighting"
    echo
    echo "For more information, see: MODERN_IDE_README.md"
    echo
    echoHappy coding! 🚀"
}

# Main installation function
main() [object Object]    print_header Modern Neovim IDE Installation"
    
    # Detect package manager
    detect_package_manager
    print_status "Using package manager: $PKG_MANAGER"
    
    # Install dependencies
    install_system_deps
    install_language_servers
    install_additional_tools
    
    # Setup configuration
    setup_neovim_config
    
    # Install fonts (optional)
    read -p "Do you want to install recommended fonts? (y/n):  -n1-r
    echo
    if[ $REPLY =~ ^[Yy]$ ]]; then
        install_fonts
    fi
    
    # Create desktop entry
    read -p "Do you want to create a desktop entry? (y/n):  -n1-r
    echo
    if[ $REPLY =~ ^[Yy]$ ]]; then
        create_desktop_entry
    fi
    
    # Show post-installation info
    show_post_install_info
}

# Run main function
main "$@" 