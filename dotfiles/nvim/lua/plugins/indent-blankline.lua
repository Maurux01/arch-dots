-- lua/plugins/indent-blankline.lua
-- Configuración para indent-blankline v3 (LazyVim)

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    scope = { enabled = true },
    indent = { char = "│" },
  },
} 