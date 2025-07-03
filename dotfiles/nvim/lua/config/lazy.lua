-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath('data')..'/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Temas
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'morhetz/gruvbox' },
  { 'folke/tokyonight.nvim' },
  { 'shaunsingh/nord.nvim' },
  { 'Mofiqul/dracula.nvim' },
  { 'navarasu/onedark.nvim' },
  { 'ishan9299/nvim-solarized-lua' },
  -- Animaciones
  { 'echasnovski/mini.animate' },
  -- LSP y autocompletado
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  -- Árbol de archivos
  { 'nvim-tree/nvim-tree.lua' },
  { 'nvim-tree/nvim-web-devicons' },
  -- Barra de estado
  { 'nvim-lualine/lualine.nvim' },
  -- Fuzzy finder
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Git
  { 'lewis6991/gitsigns.nvim' },
  -- Terminal
  { 'akinsho/toggleterm.nvim' },
  -- IA
  { 'github/copilot.vim' },
  { 'Exafunction/codeium.vim' },
  { 'jackMort/ChatGPT.nvim', dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' } },
})

-- Cargar configuración modular
require('config.options')
require('config.keymaps')
require('config.lsp')
require('config.theme')
require('config.plugins') 