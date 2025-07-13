-- lua/config/options.lua
-- Opciones personalizadas para LazyVim

-- Configuración básica de Neovim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Opciones básicas
local opt = vim.opt

-- Interfaz
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "line"
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Búsqueda
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indentación
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Archivos
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Terminal
opt.termguicolors = true
opt.showmode = false

-- Fuente
opt.guifont = "JetBrains Mono:h13"

-- Comportamiento
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.hidden = true
opt.wrap = false
opt.linebreak = true
opt.showbreak = "↪ "
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·" }

-- Rendimiento
opt.synmaxcol = 240
opt.updatetime = 250

-- Configuración específica de archivos
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- Mejorar la experiencia de edición
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- Configuración de colores
vim.cmd([[
  hi CursorLine ctermbg=NONE guibg=NONE
  hi CursorLineNr ctermfg=Yellow guifg=Yellow
  hi LineNr ctermfg=Gray guifg=Gray
  hi SignColumn ctermbg=NONE guibg=NONE
]])
