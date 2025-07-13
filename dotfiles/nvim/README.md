# NVimX-1 - Neovim Configuration

A modern Neovim configuration based on LazyVim with custom enhancements for web development and productivity.

## ✨ Features

- **Modern UI**: Clean and intuitive interface with statusline and notifications
- **Theme Switching**: Multiple themes with easy switching (Tokyo Night, Catppuccin, Gruvbox, Dracula, Habamax)
- **File Explorer**: Oil.nvim for efficient file navigation
- **Fuzzy Finder**: Telescope for files, grep, and more
- **LSP Support**: Full language server protocol support for multiple languages
- **Web Development**: Specialized tools for HTML, CSS, JavaScript, TypeScript
- **Git Integration**: LazyGit, Git signs, blame, and conflict resolution
- **Docker Integration**: LazyDocker for container management
- **Terminal**: Integrated terminal with ToggleTerm
- **Sessions**: Automatic session management with persistence.nvim
- **Code Capture**: Screenshot and screen recording capabilities
- **AI Assistant**: Open source AI tools (Codeium, Tabnine, ChatGPT.nvim)

## 🎨 Themes

- Tokyo Night (default)
- Catppuccin
- Gruvbox
- Dracula
- Habamax

### Theme Controls
- `<leader>ut` - Toggle theme
- `<leader>uN` - Next theme
- `<leader>up` - Previous theme
- `<leader>u1-5` - Quick theme selection

## ⌨️ Complete Keybinds Reference

### 🧭 Navigation & File Management

#### **Telescope (Fuzzy Finder)**
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags
- `<leader>fo` - Old files
- `<leader>fc` - Colorscheme
- `<leader>fe` - File browser
- `<leader>fr` - Resume last search

#### **File Explorer**
- `<leader>e` - Oil explorer

#### **Buffer Management**
- `<C-l>` - Next buffer
- `<C-h>` - Previous buffer
- `<leader>bd` - Close buffer
- `<leader>bp` - Pick buffer
- `<leader>1-9` - Go to buffer 1-9

#### **Window Management**
- `<C-w>h` - Go to left window
- `<C-w>j` - Go to lower window
- `<C-w>k` - Go to upper window
- `<C-w>l` - Go to right window
- `<C-w>v` - Vertical split
- `<C-w>s` - Horizontal split
- `<C-w>c` - Close window
- `<C-w>o` - Close other windows
- `<leader>sv` - Vertical split
- `<leader>sh` - Horizontal split
- `<leader>se` - Equalize windows

#### **Window Resize**
- `<Up>` - Increase window height
- `<Down>` - Decrease window height
- `<Left>` - Decrease window width
- `<Right>` - Increase window width

#### **Tab Management**
- `<leader>tn` - New tab
- `<leader>tc` - Close tab
- `<leader>tl` - Next tab
- `<leader>th` - Previous tab

### 🔧 LSP (Language Server Protocol)

#### **Code Navigation**
- `gd` - Go to definition
- `gr` - References
- `K` - Hover
- `<leader>ca` - Code actions
- `<leader>rn` - Rename
- `<leader>f` - Format

#### **Diagnostics**
- `<leader>gl` - Show line diagnostics
- `<leader>gj` - Next diagnostic
- `<leader>gk` - Previous diagnostic

### 💻 Terminal

#### **ToggleTerm**
- `<leader>t` - Toggle terminal
- `<leader>th` - Horizontal terminal split
- `<leader>tv` - Vertical terminal split
- `<leader>tt` - Terminal in new tab

#### **Terminal Navigation**
- `<C-h>` - Go to left window (in terminal)
- `<C-j>` - Go to lower window (in terminal)
- `<C-k>` - Go to upper window (in terminal)
- `<C-l>` - Go to right window (in terminal)

### 💾 Sessions

#### **Persistence**
- `<leader>qs` - Restore session
- `<leader>ql` - Restore last session
- `<leader>qd` - Don't save session

### 🎨 Theme & UI

#### **Theme Switching**
- `<leader>ut` - Toggle theme
- `<leader>uN` - Next theme
- `<leader>up` - Previous theme
- `<leader>u1` - Tokyo Night
- `<leader>u2` - Catppuccin
- `<leader>u3` - Gruvbox
- `<leader>u4` - Dracula
- `<leader>u5` - Habamax

#### **UI Controls**
- `<leader>un` - Dismiss all notifications
- `<leader>snl` - Noice last message
- `<leader>snh` - Noice history
- `<leader>sna` - Noice all

### 🤖 Open Source AI Assistant & Code Suggestions

#### **Codeium (Free AI Completion)**
- `<Tab>` - Accept suggestion
- `<C-]>` - Dismiss suggestion
- Automatic code completion

#### **Tabnine (Alternative AI Completion)**
- `<Tab>` - Accept suggestion
- `<C-]>` - Dismiss suggestion
- Context-aware suggestions

#### **ChatGPT.nvim (Open Source AI Chat)**
- `<leader>ai` - Open ChatGPT
- `<leader>ae` - Edit with ChatGPT
- `<leader>at` - Explain code
- `<leader>af` - Fix bug
- `<leader>ar` - Review code
- `<leader>ao` - Optimize code
- `<leader>ad` - Add tests

#### **Code Completion**
- `<C-Space>` - Trigger completion
- `<C-n>` - Next item
- `<C-p>` - Previous item
- `<C-e>` - Close completion
- `<Tab>` - Accept completion or expand snippet
- `<S-Tab>` - Previous completion or jump snippet

#### **Refactoring**
- `<leader>rr` - Select refactor
- `<leader>rp` - Debug print
- `<leader>rv` - Debug print variable
- `<leader>rc` - Debug cleanup

### 🐙 Git & Version Control

#### **LazyGit (Visual Git Interface)**
- `<leader>gg` - Open LazyGit
- `<leader>gc` - LazyGit Config
- `<leader>gf` - LazyGit Filter
- `<leader>gl` - LazyGit Filter Current File

#### **Git Signs & Blame**
- `]c` - Next Git hunk
- `[c` - Previous Git hunk
- `<leader>rh` - Reset Git hunk
- `<leader>ph` - Preview Git hunk
- `<leader>tb` - Toggle Git blame
- `<leader>td` - Toggle Git deleted
- `<leader>gb` - Toggle Git blame

#### **Git Conflict Resolution**
- `<leader>gco` - Choose Ours
- `<leader>gct` - Choose Theirs
- `<leader>gcb` - Choose Both
- `<leader>gcn` - Choose None
- `<leader>gcp` - Previous Conflict
- `<leader>gcn` - Next Conflict

### 🐳 Docker & Containers

#### **LazyDocker (Visual Docker Interface)**
- `<leader>dd` - Open LazyDocker
- `<leader>dc` - LazyDocker Config

#### **Docker Telescope**
- `<leader>fd` - Docker containers
- `<leader>fi` - Docker images
- `<leader>fv` - Docker volumes
- `<leader>fn` - Docker networks

### 📸 Code Capture & Recording

#### **Screenshots**
- `<leader>ci` - Capture buffer as image
- `<leader>ci` - Capture selection as image (visual mode)
- `<leader>cc` - Capture code block with syntax highlighting (visual mode)

#### **Screen Recording**
- `<leader>cr` - Toggle screen recording

#### **Focus Mode**
- `<leader>ct` - Toggle Twilight (focus mode)

#### **Code Execution**
- `<leader>cs` - Run code snippet (SnipRun)
- `<leader>cl` - Clear snippet output

#### **ASCII Art**
- `<leader>cb` - Create ASCII box around selection (visual mode)
- `<leader>cv` - Draw box around selection (Venn)

### 🌐 Web Development

#### **Emmet**
- `<C-y>` - Emmet expand (in insert mode)

#### **Prettier**
- `<leader>fp` - Format with Prettier

#### **Live Server**
- `<leader>ls` - Toggle Live Server

### 🔍 Search & Replace

#### **Search**
- `<leader>sr` - Search and replace
- `<leader>sR` - Search and replace word under cursor
- `<leader>nh` - Clear highlights

#### **Quickfix & Location List**
- `<C-q>` - Close quickfix
- `]q` - Next quickfix
- `[q` - Previous quickfix
- `]l` - Next location
- `[l` - Previous location

### 📋 Clipboard

#### **System Clipboard**
- `<leader>y` - Yank to clipboard
- `<leader>Y` - Yank line to clipboard
- `<leader>p` - Paste from clipboard
- `<leader>P` - Paste from clipboard before

### 🔧 Text Manipulation

#### **Surround**
- `ys` - Add surround
- `ds` - Delete surround
- `cs` - Change surround

#### **Comments**
- `<leader>/` - Toggle comment line
- `<leader>/` - Toggle comment for selection (visual mode)

#### **Line Movement**
- `<A-j>` - Move line down
- `<A-k>` - Move line up

#### **Indentation**
- `<` - Better indent (visual mode)
- `>` - Better indent (visual mode)

### 💾 File Operations

#### **Save & Quit**
- `<C-s>` - Save file
- `<leader>w` - Save
- `<leader>W` - Save all
- `<leader>q` - Quit
- `<leader>Q` - Quit all

### 🎛️ Toggle Options

#### **Display Options**
- `<leader>tw` - Toggle wrap
- `<leader>tn` - Toggle number
- `<leader>tr` - Toggle relative number
- `<leader>ts` - Toggle spell

### 🔍 Git Integration

#### **Git Commands**
- `<leader>gb` - Git blame
- `<leader>gd` - Git diff
- `<leader>gs` - Git status

### 🧹 Utility

#### **Clear & Reset**
- `<esc>` - Clear search highlights
- `<leader>gg` - Go to previous file

### 📝 LazyVim

#### **Plugin Manager**
- `<leader>E` - Open Lazy (Plugin Manager)

## 🛠️ Installation

### Option 1: One-Line Installation (Recommended)

```bash
# Install with a single command
curl -fsSL https://raw.githubusercontent.com/yourusername/NVimX-1/main/curl-install.sh | bash
```

### Option 2: Clone and Install

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

### Option 3: Manual Installation

If you prefer manual installation:

1. **Clone to your Neovim config directory:**
```bash
git clone https://github.com/yourusername/NVimX-1.git ~/.config/nvim
```

2. **Install dependencies manually:**
```bash
# Install ripgrep (for Telescope)
sudo pacman -S ripgrep

# Install fd (for file finding)
sudo pacman -S fd

# Install Node.js (for LSP servers)
sudo pacman -S nodejs npm

# Install capture tools
sudo pacman -S wl-screenshot imagemagick wf-recorder ffmpeg bat highlight

# Install open source AI tools
sudo pacman -S cmake ninja pkg-config

# Install Git and Docker tools
sudo pacman -S lazygit lazydocker docker

# Install global npm packages
npm install -g live-server typescript-language-server prettier
```

3. **Start Neovim and wait for plugins to install:**
```bash
nvim
```

## What the Installation Scripts Do

The installation scripts automatically:

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

✅ **Installs Capture Tools**
- **wl-screenshot/imagemagick** - Screenshot tools
- **wf-recorder/ffmpeg** - Screen recording tools
- **bat/highlight** - Syntax highlighting for code capture

✅ **Installs Open Source AI Tools**
- **cmake, ninja, pkg-config** - For AI tool compilation
- **Codeium** - Free AI code completion
- **Tabnine** - Alternative AI completion
- **ChatGPT.nvim** - Open source AI chat
- **Refactoring tools** - AI-powered code refactoring

✅ **Installs Git and Docker Tools**
- **LazyGit** - Visual Git interface
- **LazyDocker** - Visual Docker interface
- **Docker** - Container management
- **Git conflict resolution** - Automatic conflict handling
- **Git blame and signs** - Enhanced Git integration

✅ **Installs Global Packages**
- **live-server** - Development server for web projects
- **typescript-language-server** - TypeScript/JavaScript LSP
- **prettier** - Code formatter
- **@typescript-eslint/parser** - TypeScript ESLint parser
- **@typescript-eslint/eslint-plugin** - TypeScript ESLint plugin

✅ **Copies Configuration**
- Copies all files to `~/.config/nvim/`
- Sets proper permissions
- Removes installation scripts from destination

✅ **Creates Directories**
- Creates `~/Pictures` for screenshots
- Creates `~/Videos` for recordings

## 📁 Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── config/
│   │   ├── autocmds.lua     # Auto commands
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── options.lua      # Neovim options
│   │   ├── theme-toggle.lua # Theme switching
│   │   └── capture-utils.lua # Code capture utilities
│   └── plugins/
│       ├── autopairs.lua    # Auto pairs
│       ├── cmp.lua          # Completion
│       ├── colorscheme.lua  # Color schemes
│       ├── comment.lua      # Comments
│       ├── dap.lua          # Debug adapter
│       ├── gitsigns.lua     # Git signs
│       ├── indent-blankline.lua # Indent guides
│       ├── lsp.lua          # Language servers
│       ├── mini-animate.lua # Animations
│       ├── neotest.lua      # Testing
│       ├── noice.lua        # UI components
│       ├── oil.lua          # File explorer
│       ├── sessions.lua     # Session management
│       ├── surround.lua     # Surround operations
│       ├── telescope.lua    # Fuzzy finder
│       ├── toggleterm.lua   # Terminal
│       ├── webdev.lua       # Web development
│       ├── which-key.lua    # Key hints
│       ├── code-capture.lua # Code capture plugins
│       ├── copilot.lua      # Open source AI tools
│       ├── ai-assistant.lua # AI tools and suggestions
│       ├── lazy-git.lua     # Git integration
│       └── lazy-docker.lua  # Docker integration
```

## 🔧 Configuration

### Adding New Plugins

Create a new file in `lua/plugins/` or add to an existing one:

```lua
return {
  "plugin-name/plugin-repo",
  opts = {
    -- plugin options
  },
  config = function(_, opts)
    -- plugin configuration
  end,
}
```

### Custom Keymaps

Add your custom keymaps in `lua/config/keymaps.lua`:

```lua
keymap("n", "<leader>custom", "<cmd>CustomCommand<cr>", { desc = "Custom command" })
```

## 🤖 Open Source AI Assistant Features

### Code Completion
- **Codeium**: Free AI code completion with unlimited usage
- **Tabnine**: Alternative AI completion with open source components
- **LSP Integration**: Language-aware suggestions
- **Context-Aware**: Suggestions based on your codebase

### AI Chat
- **ChatGPT.nvim**: Open source AI chat interface
- **Code Review**: AI-powered code review and suggestions
- **Test Generation**: Automatic test generation
- **Bug Fixing**: AI-assisted bug detection and fixes
- **Documentation**: Automatic documentation generation

### Refactoring
- **Smart Refactoring**: AI-powered code refactoring
- **Debug Helpers**: Automatic debug print statements
- **Code Analysis**: Intelligent code analysis and suggestions
- **Performance Optimization**: AI-assisted performance improvements

### Snippets
- **Friendly Snippets**: VSCode-compatible snippets
- **LuaSnip**: Advanced snippet engine
- **Auto-expansion**: Context-aware snippet expansion
- **Custom Snippets**: Create your own snippets

### Setup for ChatGPT.nvim
1. **Get OpenAI API Key**: Sign up at [OpenAI](https://openai.com/)
2. **Set Environment Variable**:
   ```bash
   export OPENAI_API_KEY='your-api-key-here'
   ```
3. **Add to Shell Profile** (optional):
   ```bash
   echo 'export OPENAI_API_KEY=your-api-key-here' >> ~/.bashrc
   source ~/.bashrc
   ```

## 🐙 Git Integration Features

### LazyGit (Visual Git Interface)
- **Interactive Git Management**: Visual interface for Git operations
- **Branch Management**: Easy branch creation, switching, and merging
- **Commit History**: Visual commit history and diff viewing
- **Staging Area**: Interactive staging and unstaging of files
- **Remote Management**: Easy push, pull, and remote operations

### Git Signs & Blame
- **Line Indicators**: Visual indicators for added, modified, and deleted lines
- **Hunk Navigation**: Easy navigation between Git hunks
- **Blame Information**: Inline blame information for code lines
- **Conflict Resolution**: Visual conflict resolution tools

### Git Conflict Resolution
- **Automatic Detection**: Automatic detection of Git conflicts
- **Visual Resolution**: Visual interface for resolving conflicts
- **Quick Actions**: Quick actions for choosing ours, theirs, or both
- **Conflict Navigation**: Easy navigation between conflicts

## 🐳 Docker Integration Features

### LazyDocker (Visual Docker Interface)
- **Container Management**: Visual interface for Docker containers
- **Image Management**: Easy image building, pulling, and removal
- **Volume Management**: Visual volume creation and management
- **Network Management**: Docker network configuration
- **Logs Viewing**: Real-time container logs

### Docker Telescope
- **Container Search**: Search and filter Docker containers
- **Image Search**: Search and filter Docker images
- **Volume Search**: Search and filter Docker volumes
- **Network Search**: Search and filter Docker networks

### Docker Development
- **Dockerfile Support**: Syntax highlighting for Dockerfiles
- **Docker Compose**: Support for docker-compose files
- **Container Logs**: Real-time log viewing
- **Resource Monitoring**: Container resource usage monitoring

## 📸 Code Capture Features

### Screenshots
- **Buffer Capture**: Capture entire buffer as image
- **Selection Capture**: Capture selected text as image
- **Code Block Capture**: Capture code with syntax highlighting
- **ASCII Art**: Create decorative boxes around code

### Screen Recording
- **Start/Stop Recording**: Toggle screen recording
- **Automatic Naming**: Files saved with timestamps
- **Multiple Formats**: Support for Wayland and X11

### Focus Mode
- **Twilight**: Dim inactive code for better focus
- **Syntax Highlighting**: Enhanced code visibility

### Code Execution
- **SnipRun**: Execute code snippets inline
- **Output Display**: Show results in Neovim

## 🐛 Troubleshooting

### Common Issues

1. **Theme not found**: Make sure the theme is installed via LazyVim
2. **LSP not working**: Install language servers (e.g., `npm install -g typescript-language-server`)
3. **Telescope not finding files**: Install `fd` or `ripgrep`
4. **Capture tools not working**: Install screenshot/recording tools manually
5. **AI tools not working**: Install cmake, ninja, pkg-config for AI tools
6. **LazyGit not working**: Install LazyGit manually if auto-install fails
7. **LazyDocker not working**: Install LazyDocker and Docker manually if auto-install fails
8. **ChatGPT.nvim not working**: Set your OpenAI API key environment variable

### Debug Mode

Start Neovim with debug information:
```bash
nvim --log-level debug
```

## 📝 Recent Fixes

- ✅ Fixed theme switching with error handling
- ✅ Removed duplicate LSP configurations
- ✅ Cleaned up keymaps and removed broken references
- ✅ Fixed file explorer configuration
- ✅ Added proper error handling for missing themes
- ✅ Consolidated web development tools
- ✅ Added automatic installation scripts
- ✅ Added one-line curl installation
- ✅ Added comprehensive keybinds reference
- ✅ Added code capture and screen recording functionality
- ✅ Added open source AI assistant and code suggestions
- ✅ Added LazyGit and LazyDocker integration
- ✅ Removed GitHub Copilot, kept only open source AI tools

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
