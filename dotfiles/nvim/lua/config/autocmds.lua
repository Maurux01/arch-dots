c -- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Asegurar que Neovim inicie en modo normal
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("normal!")
  end,
})

-- Notificación al copiar (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.notify("Texto copiado al registro!", vim.log.levels.INFO, { title = "Yank", timeout = 800 })
  end,
})

-- Notificación al pegar (paste)
vim.api.nvim_create_autocmd("TextChanged", {
  pattern = {"*"},
  callback = function()
    if vim.v.event and vim.v.event.operator == 'p' then
      vim.notify("Texto pegado!", vim.log.levels.INFO, { title = "Paste", timeout = 800 })
    end
  end,
})
