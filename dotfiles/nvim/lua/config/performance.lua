-- lua/config/performance.lua
-- Performance optimizations for smooth animations

-- Optimize for animations
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.redrawtime = 1500
vim.opt.lazyredraw = false -- Disabled for smooth animations

-- Smooth scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Performance settings
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Animation-friendly settings
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"

-- Smooth window transitions
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Optimize for large files
vim.opt.synmaxcol = 240
vim.opt.maxmempattern = 2000

-- Smooth completion
vim.opt.completeopt = "menuone,noselect,noinsert"

-- Animation performance
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Custom autocmds for smooth animations
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  callback = function()
    vim.opt.updatetime = 100
  end,
})

-- Optimize for terminal
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Smooth window resizing
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
}) 