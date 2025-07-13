-- lua/plugins/oil.lua
-- Configuración básica de Oil.nvim

return {
  "stevearc/oil.nvim",
  opts = {},
  cmd = "Oil",
  keys = {
    { "<leader>o", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
  },
} 