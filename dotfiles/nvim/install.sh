#!/bin/bash

# NVimX-1 Installation Script
# This script installs the Neovim configuration to ~/.config/nvim/

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

print_status "Starting NVimX-1 installation..."

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    print_error "Neovim is not installed. Please install Neovim first."
    print_status "You can install it with: sudo pacman -S neovim"
    exit 1
fi

print_success "Neovim is installed"

# Create backup of existing config if it exists
if [ -d "$NVIM_CONFIG_DIR" ]; then
    BACKUP_DIR="$NVIM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
    print_warning "Existing Neovim configuration found at $NVIM_CONFIG_DIR"
    print_status "Creating backup at $BACKUP_DIR"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    print_success "Backup created successfully"
fi

# Create the nvim config directory
print_status "Creating Neovim configuration directory..."
mkdir -p "$NVIM_CONFIG_DIR"

# Copy all files from the repository to the nvim config directory
print_status "Copying configuration files..."
cp -r "$SCRIPT_DIR"/* "$NVIM_CONFIG_DIR/"

# Remove the install script from the destination
rm -f "$NVIM_CONFIG_DIR/install.sh"

# Set proper permissions
print_status "Setting proper permissions..."
chmod -R 755 "$NVIM_CONFIG_DIR"

print_success "Configuration files copied successfully!"

# Install dependencies
print_status "Checking for dependencies..."

# Check for ripgrep
if ! command -v rg &> /dev/null; then
    print_warning "ripgrep not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S ripgrep --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install ripgrep -y
    elif command -v yum &> /dev/null; then
        sudo yum install ripgrep -y
    else
        print_error "Could not install ripgrep automatically. Please install it manually."
    fi
fi

# Check for fd
if ! command -v fd &> /dev/null; then
    print_warning "fd not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S fd --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install fd-find -y
    elif command -v yum &> /dev/null; then
        sudo yum install fd-find -y
    else
        print_error "Could not install fd automatically. Please install it manually."
    fi
fi

# Check for Node.js
if ! command -v node &> /dev/null; then
    print_warning "Node.js not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S nodejs npm --noconfirm
    elif command -v apt &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        sudo apt-get install -y nodejs
    elif command -v yum &> /dev/null; then
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
        sudo yum install nodejs -y
    else
        print_error "Could not install Node.js automatically. Please install it manually."
    fi
fi

# Install capture tools
print_status "Installing capture tools..."

# Check for screenshot tools
if ! command -v wl-screenshot &> /dev/null && ! command -v import &> /dev/null; then
    print_warning "Screenshot tools not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S wl-screenshot imagemagick --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install wl-screenshot imagemagick -y
    elif command -v yum &> /dev/null; then
        sudo yum install wl-screenshot ImageMagick -y
    else
        print_error "Could not install screenshot tools automatically. Please install them manually."
    fi
fi

# Check for screen recording tools
if ! command -v wf-recorder &> /dev/null && ! command -v ffmpeg &> /dev/null; then
    print_warning "Screen recording tools not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S wf-recorder ffmpeg --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install wf-recorder ffmpeg -y
    elif command -v yum &> /dev/null; then
        sudo yum install wf-recorder ffmpeg -y
    else
        print_error "Could not install screen recording tools automatically. Please install them manually."
    fi
fi

# Check for syntax highlighting tools
if ! command -v bat &> /dev/null && ! command -v highlight &> /dev/null; then
    print_warning "Syntax highlighting tools not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S bat highlight --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install bat highlight -y
    elif command -v yum &> /dev/null; then
        sudo yum install bat highlight -y
    else
        print_error "Could not install syntax highlighting tools automatically. Please install them manually."
    fi
fi

# Install open source AI assistant tools
print_status "Installing open source AI assistant tools..."

# Check for cmake (for some AI tools)
if ! command -v cmake &> /dev/null; then
    print_warning "cmake not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S cmake --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install cmake -y
    elif command -v yum &> /dev/null; then
        sudo yum install cmake -y
    else
        print_error "Could not install cmake automatically. Please install it manually."
    fi
fi

# Check for ninja-build (for some AI tools)
if ! command -v ninja &> /dev/null; then
    print_warning "ninja-build not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S ninja --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install ninja-build -y
    elif command -v yum &> /dev/null; then
        sudo yum install ninja-build -y
    else
        print_error "Could not install ninja-build automatically. Please install it manually."
    fi
fi

# Check for pkg-config (for some AI tools)
if ! command -v pkg-config &> /dev/null; then
    print_warning "pkg-config not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S pkg-config --noconfirm
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install pkg-config -y
    elif command -v yum &> /dev/null; then
        sudo yum install pkg-config -y
    else
        print_error "Could not install pkg-config automatically. Please install it manually."
    fi
fi

# Install LazyGit and LazyDocker
print_status "Installing LazyGit and LazyDocker..."

# Check for LazyGit
if ! command -v lazygit &> /dev/null; then
    print_warning "LazyGit not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S lazygit --noconfirm
    elif command -v apt &> /dev/null; then
        # Add LazyGit repository for Ubuntu/Debian
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit lazygit.tar.gz
    elif command -v yum &> /dev/null; then
        # Add LazyGit repository for CentOS/RHEL
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit lazygit.tar.gz
    else
        print_error "Could not install LazyGit automatically. Please install it manually."
    fi
fi

# Check for LazyDocker
if ! command -v lazydocker &> /dev/null; then
    print_warning "LazyDocker not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S lazydocker --noconfirm
    elif command -v apt &> /dev/null; then
        # Add LazyDocker repository for Ubuntu/Debian
        LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazydocker.tar.gz lazydocker
        sudo install lazydocker /usr/local/bin
        rm lazydocker lazydocker.tar.gz
    elif command -v yum &> /dev/null; then
        # Add LazyDocker repository for CentOS/RHEL
        LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazydocker.tar.gz lazydocker
        sudo install lazydocker /usr/local/bin
        rm lazydocker lazydocker.tar.gz
    else
        print_error "Could not install LazyDocker automatically. Please install it manually."
    fi
fi

# Check for Docker
if ! command -v docker &> /dev/null; then
    print_warning "Docker not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S docker --noconfirm
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker $USER
    elif command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install docker.io -y
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker $USER
    elif command -v yum &> /dev/null; then
        sudo yum install docker -y
        sudo systemctl enable docker
        sudo systemctl start docker
        sudo usermod -aG docker $USER
    else
        print_error "Could not install Docker automatically. Please install it manually."
    fi
fi

# Create directories for captures
print_status "Creating capture directories..."
mkdir -p ~/Pictures
mkdir -p ~/Videos

# Install global npm packages for web development
print_status "Installing global npm packages..."
if command -v npm &> /dev/null; then
    npm install -g live-server typescript-language-server @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier
    print_success "Global npm packages installed"
else
    print_warning "npm not available. Please install Node.js and npm manually."
fi

print_success "Installation completed successfully!"

echo ""
echo -e "${GREEN}🎉 NVimX-1 has been installed successfully!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Start Neovim: ${YELLOW}nvim${NC}"
echo "2. Wait for plugins to install automatically"
echo "3. Enjoy your new Neovim configuration!"
echo ""
echo -e "${BLUE}Key features:${NC}"
echo "• Theme switching: ${YELLOW}<leader>ut${NC}"
echo "• File finder: ${YELLOW}<leader>ff${NC}"
echo "• Live grep: ${YELLOW}<leader>fg${NC}"
echo "• File explorer: ${YELLOW}<leader>e${NC}"
echo "• Terminal: ${YELLOW}<leader>t${NC}"
echo "• Code capture: ${YELLOW}<leader>ci${NC}"
echo "• Screen recording: ${YELLOW}<leader>cr${NC}"
echo "• AI assistant: ${YELLOW}<leader>ai${NC}"
echo "• Code suggestions: ${YELLOW}<Tab>${NC}"
echo "• LazyGit: ${YELLOW}<leader>gg${NC}"
echo "• LazyDocker: ${YELLOW}<leader>dd${NC}"
echo ""
echo -e "${BLUE}Capture tools installed:${NC}"
echo "• Screenshot tools (wl-screenshot/imagemagick)"
echo "• Screen recording (wf-recorder/ffmpeg)"
echo "• Syntax highlighting (bat/highlight)"
echo ""
echo -e "${BLUE}Open Source AI tools installed:${NC}"
echo "• Codeium (free AI completion)"
echo "• Tabnine (alternative AI completion)"
echo "• ChatGPT.nvim (open source AI chat)"
echo "• Refactoring tools"
echo ""
echo -e "${BLUE}Git and Docker tools installed:${NC}"
echo "• LazyGit (visual Git interface)"
echo "• LazyDocker (visual Docker interface)"
echo "• Docker (container management)"
echo "• Git conflict resolution"
echo "• Git blame and signs"
echo ""
echo -e "${BLUE}AI Assistant Setup:${NC}"
echo "• Set your OpenAI API key: ${YELLOW}export OPENAI_API_KEY='your-api-key'${NC}"
echo "• Or add it to your shell profile: ${YELLOW}echo 'export OPENAI_API_KEY=your-api-key' >> ~/.bashrc${NC}"
echo "• Restart your terminal after setting the API key"
echo ""
echo -e "${BLUE}If you had a previous configuration, it was backed up to:${NC}"
if [ -n "$BACKUP_DIR" ]; then
    echo "${YELLOW}$BACKUP_DIR${NC}"
fi
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}" 