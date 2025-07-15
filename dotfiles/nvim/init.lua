-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.theme-toggle")
require("config.capture-utils")
require("config.telescope")
require("config.image-support")
require("config.autocmds")

-- Force dashboard on startup if no files are opened (fallback)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.bufnr() == 1 and vim.fn.bufname() == "" then
      vim.cmd("Dashboard")
    end
  end,
})
