-- lua/plugins/nvim-web-devicons.lua
-- Optimized nvim-web-devicons configuration for correct folder icon alignment
return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require('nvim-web-devicons').setup({
        default = true,
        strict = true,
        override = {}, -- No overrides para carpetas
        color_icons = true,
        default_icon = {
          icon = "",
          name = "Default"
        },
        glob_icons = true,
      })
    end,
  },
} 