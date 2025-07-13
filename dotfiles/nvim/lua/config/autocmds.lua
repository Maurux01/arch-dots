-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- NVimX autocmds mejorados

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("nvimx_resize", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Auto-save files when focus is lost
vim.api.nvim_create_autocmd("FocusLost", {
  group = vim.api.nvim_create_augroup("nvimx_autosave", { clear = true }),
  callback = function()
    if vim.bo.modifiable and vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("nvimx_highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("nvimx_remove_trailing_whitespace", { clear = true }),
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.yaml", "*.yml" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Auto-format on save for specific file types
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("nvimx_auto_format", { clear = true }),
  pattern = { "*.lua" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Set filetype for specific extensions
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("nvimx_filetype", { clear = true }),
  pattern = { "*.conf" },
  callback = function()
    vim.bo.filetype = "conf"
  end,
})

-- Auto-close quickfix and location list when leaving
vim.api.nvim_create_autocmd("WinLeave", {
  group = vim.api.nvim_create_augroup("nvimx_auto_close", { clear = true }),
  callback = function()
    if vim.bo.filetype == "qf" then
      vim.cmd("silent! close")
    end
  end,
})

-- Disable auto-comment on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("nvimx_disable_auto_comment", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions = vim.opt_local.formatoptions - "o"
  end,
})

-- Set indentation for specific file types
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("nvimx_indent", { clear = true }),
  pattern = { "yaml", "yml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("nvimx_indent", { clear = true }),
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Enable spell checking for specific file types
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("nvimx_spell", { clear = true }),
  pattern = { "markdown", "tex", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Auto-close NvimTree when it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("nvimx_auto_close_tree", { clear = true }),
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree") then
      vim.cmd("quit")
    end
  end,
})
