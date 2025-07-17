# Modern Neovim IDE Configuration

## 🚀 Overview

This configuration transforms Neovim into a modern, professional IDE with enhanced visual appeal, productivity features, and a seamless development experience. Built on top of LazyVim with custom enhancements.

## ✨ Key Features

### 🎨 Modern Visual Design
- **Beautiful Dashboard**: Alpha-nvim dashboard with ASCII art and quick actions
- **Multiple Themes**: Tokyo Night, Catppuccin, Gruvbox, and more
- **Enhanced Syntax Highlighting**: Treesitter with rainbow delimiters and better colors
- **Modern UI Elements**: Rounded borders, better colors, and professional appearance

### 🔧 Enhanced Autocompletion
- **Smart Completion**: nvim-cmp with LSP, snippets, and buffer completion
- **Visual Enhancements**: Icons, better formatting, and improved menu appearance
- **Snippet Support**: LuaSnip with friendly-snippets for multiple languages
- **Auto-pairs**: Intelligent bracket and quote completion

### 📋 Integrated Terminal
- **Multiple Terminals**: Main terminal, Git terminal, LazyGit, and language REPLs
- **Floating Windows**: Modern terminal appearance with rounded borders
- **Quick Access**: Keyboard shortcuts for different terminal types
- **Better Integration**: Seamless switching between editor and terminal

### 🎯 Productivity Features
- **Enhanced Navigation**: Better file tree, telescope integration, and quick access
- **Modern Keybindings**: Intuitive shortcuts for common actions
- **Auto-save**: Automatic file saving on focus lost
- **Smart Indentation**: Language-specific indentation rules
- **Comment System**: Enhanced commenting with visual feedback

### 🌈 Visual Enhancements
- **Rainbow Delimiters**: Color-coded brackets and parentheses
- **Indent Guides**: Visual indentation markers
- **Better Search**: Enhanced search highlighting and results
- **TODO Comments**: Special highlighting for TODO, FIX, NOTE comments
- **Twilight Mode**: Focus mode for better concentration

## 🎮 Keybindings

### Dashboard Navigation
- `e` - New file
- `f` - Find files
- `r` - Recent files
- `g` - Live grep
- `t` - Terminal
- `n` - File tree
- `c` - Config
- `q` - Quit

### Theme Switching
- `<leader>1` - Tokyo Night theme
- `<leader>2` - Catppuccin theme
- `<leader>3 - Gruvbox theme

### Terminal Management
- `<C-\>` - Toggle main terminal
- `<leader>tg` - Git terminal
- `<leader>tl` - LazyGit
- `<leader>tn` - Node REPL
- `<leader>tp` - Python REPL

### Enhanced Navigation
- `<leader>f` - Find files
- `<leader>g` - Live grep
- `<leader>r` - Recent files
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>Q` - Quit all

### Window Management
- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally
- `<leader>sc` - Close window
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Delete buffer

### Comment System
- `<leader>cc` - Toggle line comment
- `<leader>cb` - Toggle block comment
- `<leader>c` - Comment selection (visual mode)
- `<leader>b` - Block comment selection (visual mode)

### Search and Replace
- `<leader>sr` - Search and replace
- `<leader>sw` - Search word under cursor
- `<leader>ft` - Find todos
- `<leader>fT` - Find todos/fixes

## 🎨 Themes Included

### Tokyo Night
- Modern dark theme with excellent syntax highlighting
- Professional appearance with subtle colors
- Great for long coding sessions

### Catppuccin
- Beautiful and modern theme
- Multiple variants (latte, frappe, macchiato, mocha)
- Excellent contrast and readability

### Gruvbox
- Classic but modern theme
- Warm colors with good contrast
- Popular among developers

### Additional Themes
- OneDark - Popular dark theme
- Dracula - Beautiful dark theme
- Monokai Pro - Professional theme
- GitHub - Clean and modern

## 🔧 Technical Features

### Performance Optimizations
- Lazy loading for all plugins
- Optimized startup time
- Efficient memory usage
- Smart caching strategies

### Language Support
- Enhanced syntax highlighting for 20+ languages
- Language-specific indentation rules
- Auto-formatting on save
- LSP integration for all major languages

### Terminal Integration
- Multiple terminal types
- Floating and split terminals
- Language-specific REPLs
- Git integration with LazyGit

### File Management
- Modern file tree with NvimTree
- Telescope for fuzzy finding
- Recent files tracking
- Session management

## 🚀 Getting Started
1 **Installation**: The configuration is ready to use with LazyVim2 **First Launch**: Youll see the modern dashboard with quick actions
3. **Theme Selection**: Use `<leader>1/2/3` to switch themes
4. **Terminal**: Use `<C-\>` to open the integrated terminal
5. **File Navigation**: Use `<leader>f` to find files quickly

## 🎯 Customization

### Adding New Themes
Edit `lua/plugins/colorscheme.lua` to add new themes:

```lua
{
 your-theme/theme-name,
  lazy = true,
  opts = {
    -- theme options
  },
}
```

### Custom Keybindings
Add custom keybindings in `init.lua`:

```lua
vim.keymap.set(n, "<your-key>,<your-command>", { desc =Description" })
```

### Plugin Configuration
All plugins are configured in `lua/plugins/` directory. Each file contains a specific plugin's configuration.

## 🔍 Troubleshooting

### Common Issues1 **Slow Startup**: Check if all plugins are loading correctly2 **Theme Issues**: Ensure terminal supports true colors
3. **Terminal Problems**: Verify terminal emulator compatibility
4 Issues**: Install language servers for your languages

### Performance Tips
1. Use lazy loading for rarely used plugins2le unused language servers
3. Optimize your terminal font for better rendering
4se SSD storage for faster file operations

## 📚 Additional Resources

- [LazyVim Documentation](https://www.lazyvim.org/)
- [Neovim Documentation](https://neovim.io/doc/)
- [Alpha-nvim](https://github.com/goolord/alpha-nvim)
- [Tokyo Night Theme](https://github.com/folke/tokyonight.nvim)
-Catppuccin Theme](https://github.com/catppuccin/nvim)

## 🤝 Contributing

Feel free to submit issues and enhancement requests. This configuration is designed to be modular and easily customizable.

---

**Enjoy your modern Neovim IDE experience! 🚀** 