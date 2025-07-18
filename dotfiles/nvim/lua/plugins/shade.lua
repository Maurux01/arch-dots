-- lua/plugins/shade.lua
-- Shade.nvim - Dims inactive windows for better focus

return {
  "sunjon/shade.nvim",
  config = function()
    require('shade').setup({
      overlay_opacity = 50,
      opacity_step = 1,
      keys = {
        brightness_up    = '<C-Up>',
        brightness_down  = '<C-Down>',
        toggle           = '<leader>st',
      }
    })
  end,
} 