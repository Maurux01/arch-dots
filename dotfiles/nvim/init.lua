-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.theme-toggle")
require("config.capture-utils")
require("config.telescope")
require("config.image-support")
require("config.autocmds")
require("config.performance")
require("config.cursor-highlights")

-- Force our custom dashboard on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only show dashboard if no files were opened
    if vim.fn.argc() == 0 then
      -- Force our dashboard
      vim.defer_fn(function()
        vim.cmd("Dashboard")
      end, 1000)
    end
  end,
  nested = true,
})

-- Disable LazyVim's default dashboard
vim.g.lazyvim_dashboard = false
