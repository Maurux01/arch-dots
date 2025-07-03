-- Keymaps (mezcla VSCode + Vim)
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader
vim.g.mapleader = ' '

-- Navegación de buffers y splits
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprevious<CR>', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Guardar y cerrar
map('n', '<leader>w', ':w<CR>', opts)
map('n', '<leader>q', ':bd<CR>', opts)

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)

-- NvimTree
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- Terminal
map('n', '<leader>tt', ':ToggleTerm<CR>', opts)

-- LSP
map('n', '<leader>gd', vim.lsp.buf.definition, opts)
map('n', '<leader>gr', vim.lsp.buf.references, opts)
map('n', '<leader>rn', vim.lsp.buf.rename, opts)
map('n', '<leader>ca', vim.lsp.buf.code_action, opts)

-- Temas
map('n', '<leader>cc', ':Telescope colorscheme<CR>', opts)

-- IA
map('n', '<leader>ai', ':Copilot panel<CR>', opts)

-- Git
map('n', '<leader>gs', ':LazyGit<CR>', opts) 