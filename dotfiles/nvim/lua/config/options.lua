-- Custom options for LazyVim

-- Set leader keys (only here)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "line"
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Terminal
opt.termguicolors = true
opt.showmode = false

-- Font (only for GUI clients)
if vim.fn.has("gui_running") == 1 or vim.g.neovide or vim.g.goneovim then
  opt.guifont = "JetBrains Mono:h13"
end

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.hidden = true
opt.wrap = false
opt.linebreak = true
opt.showbreak = "↪ "
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·" }

-- Performance
opt.synmaxcol = 240
opt.updatetime = 250
-- opt.lazyredraw = true -- Disabled: causes issues with Noice plugin

-- Color customizations (consider moving to theme module if needed)
vim.cmd([[hi CursorLine ctermbg=NONE guibg=NONE]])
vim.cmd([[hi CursorLineNr ctermfg=Yellow guifg=Yellow]])
vim.cmd([[hi LineNr ctermfg=Gray guifg=Gray]])
vim.cmd([[hi SignColumn ctermbg=NONE guibg=NONE]])
