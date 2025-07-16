-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.theme-toggle")
require("config.capture-utils")
require("config.telescope")
require("config.image-support")
require("config.autocmds")
require("config.performance")
require("config.cursor-highlights")

-- Simple welcome message on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only show welcome if no files were opened
    if vim.fn.argc() == 0 then
      -- Show a simple welcome message
      vim.defer_fn(function()
        print("🚀 Welcome to Neovim!")
        print("Use <leader>d to find files or <leader>D for recent files")
      end, 1000)
    end
  end,
  nested = true,
})

-- Disable LazyVim's default dashboard
vim.g.lazyvim_dashboard = false
