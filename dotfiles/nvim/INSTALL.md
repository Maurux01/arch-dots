# 🚀 Installation Guide - NVimX-1

## Quick Start

### Option 1: One-Command Installation (Recommended)

```bash
# Clone and install in one command
git clone https://github.com/yourusername/NVimX-1.git && cd NVimX-1 && ./install.sh
```

### Option 2: Step-by-Step Installation

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/NVimX-1.git
cd NVimX-1
```

2. **Run the installation script:**
```bash
./install.sh
```

3. **Start Neovim:**
```bash
nvim
```

## What the Installation Script Does

The `install.sh` script automatically:

✅ **Checks Prerequisites**
- Verifies Neovim is installed
- Detects your package manager (pacman, apt, yum)

✅ **Backs Up Existing Config**
- Creates a timestamped backup of your current `~/.config/nvim/`
- Preserves your existing configuration

✅ **Installs Dependencies**
- **ripgrep** - Fast text search for Telescope
- **fd** - Fast file finder
- **Node.js & npm** - For LSP servers and web development tools

✅ **Installs Global Packages**
- **live-server** - Development server for web projects
- **typescript-language-server** - TypeScript/JavaScript LSP
- **prettier** - Code formatter
- **@typescript-eslint/parser** - TypeScript ESLint parser
- **@typescript-eslint/eslint-plugin** - TypeScript ESLint plugin

✅ **Copies Configuration**
- Copies all files to `~/.config/nvim/`
- Sets proper permissions
- Removes the install script from the destination

## Manual Installation

If you prefer to install manually:

### 1. Clone to Neovim Config Directory
```bash
git clone https://github.com/yourusername/NVimX-1.git ~/.config/nvim
```

### 2. Install Dependencies

**Arch Linux / Manjaro:**
```bash
sudo pacman -S neovim ripgrep fd nodejs npm
```

**Ubuntu / Debian:**
```bash
sudo apt update
sudo apt install neovim ripgrep fd-find
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

**Fedora / RHEL:**
```bash
sudo yum install neovim ripgrep fd-find
curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
sudo yum install nodejs
```

### 3. Install Global npm Packages
```bash
npm install -g live-server typescript-language-server prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin
```

### 4. Start Neovim
```bash
nvim
```

## Post-Installation

### First Launch
When you first start Neovim, it will:
1. Install LazyVim plugin manager
2. Download and install all plugins
3. Set up LSP servers
4. Configure themes and keymaps

This process may take a few minutes on the first run.

### Verify Installation
After the first launch, you can verify everything is working:

```bash
nvim --headless -c "lua print('Neovim loaded successfully')" -c "quit"
```

## Troubleshooting

### Common Issues

**1. "Command not found: nvim"**
```bash
# Install Neovim
sudo pacman -S neovim  # Arch Linux
sudo apt install neovim # Ubuntu
```

**2. "ripgrep not found"**
```bash
# Install ripgrep
sudo pacman -S ripgrep  # Arch Linux
sudo apt install ripgrep # Ubuntu
```

**3. "fd not found"**
```bash
# Install fd
sudo pacman -S fd       # Arch Linux
sudo apt install fd-find # Ubuntu
```

**4. LSP not working**
```bash
# Install language servers
npm install -g typescript-language-server
npm install -g @tailwindcss/language-server
npm install -g css-languageserver
npm install -g html-languageserver
```

**5. Theme not found**
The configuration includes error handling for missing themes. If a theme isn't available, it will fallback to the first available theme.

### Debug Mode
Start Neovim with debug information:
```bash
nvim --log-level debug
```

### Reset Configuration
If something goes wrong, you can reset:
```bash
rm -rf ~/.config/nvim
./install.sh
```

## Features After Installation

Once installed, you'll have access to:

🎨 **Theme Switching**
- `<leader>ut` - Toggle themes
- `<leader>u1-5` - Quick theme selection

🔍 **File Navigation**
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>e` - File explorer

💻 **Development Tools**
- `<leader>t` - Terminal
- `<leader>ls` - Live server
- `<C-y>` - Emmet expand

🔧 **LSP Features**
- `gd` - Go to definition
- `gr` - References
- `K` - Hover
- `<leader>ca` - Code actions

## Support

If you encounter any issues:

1. Check the [troubleshooting section](#troubleshooting)
2. Open an issue on GitHub
3. Check the Neovim logs: `nvim --log-level debug`

## Contributing

Want to improve the installation process?

1. Fork the repository
2. Make your changes
3. Test the installation script
4. Submit a pull request

---

**Happy coding! 🚀** 