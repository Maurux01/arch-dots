# 🐟 My Awesome Fish Configuration

An **AWESOME** Fish shell configuration with modern plugins and tools for an incredible terminal experience.

## 🌟 Main Features

### 🎨 **Theme and Appearance**
- **Oh My Fish** with **bobthefish** theme
- **Nerd Fonts** for beautiful icons
- Dark colors and complete prompt configuration
- Support for Git, Docker, Kubernetes, and more

### 🚀 **Modern Plugins and Tools**
- **fzf** - Intelligent fuzzy search
- **zoxide** - Smart directory navigation
- **atuin** - Enhanced history with search
- **bat** - Cat with syntax highlighting
- **fd** - Modern and fast find
- **rg** - Ripgrep for fast searches
- **btop** - Modern system monitor
- **yazi** - Terminal file manager
- **lazygit** - Incredible Git TUI

### 💻 **Useful Aliases**
- **Git**: `gs`, `ga`, `gc`, `gp`, `gl`, `gco`, `gcb`, `gb`, `gd`, `glog`
- **System**: `ll`, `la`, `l`, `..`, `...`, `....`
- **Development**: `nv`, `lg`, `cat`, `find`, `grep`, `top`
- **Tools**: `y`, `z`, `fz`, `e`, `h`

### 🔧 **Custom Functions**
- `dotbackup` - Automatic dotfiles backup
- `update` - System update with cleanup
- `weather` - Weather in terminal
- `sysinfo` - System information
- `extract` - File extraction
- `mkcd` - Create directory and enter
- `backup` - Create backup with timestamp
- `serve` - Simple HTTP server
- `cheat` - Cheat sheets in terminal

### 🛠️ **Language and Tool Support**
- **Node.js**: nvm, npm, yarn, pnpm, bun
- **Python**: pyenv, pip, virtualenv
- **Ruby**: rbenv, gem
- **Rust**: cargo
- **Go**: GOPATH, go modules
- **Flutter**: Flutter SDK
- **Deno**: Deno runtime
- **PHP**: Composer
- **Kubernetes**: kubectl, helm
- **Docker**: Docker CLI
- **Terraform**: Terraform CLI
- **Cloud**: AWS CLI, Google Cloud, Azure CLI

## 🎯 **Recommended Plugins**

### Already Included
- ✅ **bobthefish** - Beautiful and functional theme
- ✅ **fzf** - Fuzzy search
- ✅ **z** - Smart navigation
- ✅ **nvm** - Node Version Manager
- ✅ **pyenv** - Python Version Manager

### Additional Recommended Plugins
```bash
# Install additional plugins
omf install bass          # Run bash commands
omf install foreign-env   # Environment variables
omf install grc          # Color output for commands
omf install pbcopy       # Clipboard on macOS
omf install up           # Directory navigation
omf install bang-bang    # Command history
omf install git-flow     # Git flow shortcuts
omf install virtualfish  # Python virtualenv
omf install docker-compose # Docker compose
omf install kubectl      # Kubernetes
omf install aws          # AWS CLI
omf install gcloud       # Google Cloud
omf install azure        # Azure CLI
```

## 🚀 **Quick Installation**

1. **Clone the repository:**
```bash
git clone https://github.com/your-username/myfishconfig.git
cd myfishconfig
```

2. **Install Fish shell:**
```bash
# Arch Linux
sudo pacman -S fish

# Ubuntu/Debian
sudo apt install fish

# macOS
brew install fish
```

3. **Install dependencies:**
```bash
# Modern tools
sudo pacman -S bat fd ripgrep fzf zoxide btop yazi lazygit neofetch

# Oh My Fish
curl -L https://get.oh-my.fish | fish

# Atuin (enhanced history)
curl -sSf https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh | bash
```

4. **Copy configuration:**
```bash
cp config.fish ~/.config/fish/
fish
```

## 🎨 **Customization**

### Change Theme
```bash
# View available themes
omf theme

# Change theme
omf theme agnoster
omf theme bobthefish
omf theme default
```

### Configure Colors
```bash
# Available color schemes
omf theme bobthefish --help

# Change scheme
set -g theme_color_scheme dark
set -g theme_color_scheme light
set -g theme_color_scheme solarized
```

### Add Aliases
```bash
# Add to end of config.fish
alias my-alias='my-command'
```

## 🔧 **Troubleshooting**

### Common Issues
1. **Fonts don't look good**: Install Nerd Fonts
2. **fzf doesn't work**: Verify installation with `which fzf`
3. **zoxide doesn't work**: Run `zoxide init fish | source`

### Logs and Debug
```bash
# View Fish configuration
fish_config

# View environment variables
set

# View available functions
functions
```

## 📚 **Useful Resources**

- [Fish Shell Documentation](https://fishshell.com/docs/current/)
- [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish)
- [Bobthefish Theme](https://github.com/oh-my-fish/theme-bobthefish)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [atuin](https://github.com/atuinsh/atuin)

## 🤝 **Contributing**

Contributions are welcome! If you have ideas to improve the configuration:

1. Fork the repository
2. Create a branch for your feature
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 **License**

MIT License - Use this configuration however you want!

---

**Enjoy your AWESOME terminal! 🐟✨**