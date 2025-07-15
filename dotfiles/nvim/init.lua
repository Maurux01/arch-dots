-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.theme-toggle")
require("config.capture-utils")
require("config.telescope")
require("config.image-support")
require("config.autocmds")

-- Force alpha dashboard on startup if no files are opened
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only show alpha dashboard if no files were opened
    if vim.fn.argc() == 0 then
      -- Small delay to ensure plugins are loaded
      vim.defer_fn(function()
        vim.cmd("Alpha")
      end, 100)
    end
  end,
  nested = true,
})
