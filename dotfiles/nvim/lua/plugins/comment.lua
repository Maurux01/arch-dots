-- lua/plugins/comment.lua
-- Configuración personalizada de comment

return {
  "numToStr/Comment.nvim",
  opts = {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
      line = "<leader>/",
      block = "<leader>cb",
    },
    opleader = {
      line = "<leader>/",
      block = "<leader>cb",
    },
    extra = {
      above = "<leader>cO",
      below = "<leader>co",
      eol = "<leader>cA",
    },
    mappings = {
      basic = true,
      extra = true,
      extended = false,
    },
    pre_hook = nil,
    post_hook = nil,
  },
} 