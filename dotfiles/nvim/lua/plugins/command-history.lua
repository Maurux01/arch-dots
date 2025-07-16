-- lua/plugins/command-history.lua
-- Advanced command line completion and history

return {
  {
    "gelguy/wilder.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local wilder = require("wilder")
      wilder.setup({
        modes = { ":", "/", "?" },
        next_key = "<Tab>",
        prev_key = "<S-Tab>",
        accept_key = "<Down>",
        reject_key = "<Up>",
      })

      -- Enable fuzzy matching
      wilder.set_option("use_python_remote_plugin", false)
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        ),
      })

      -- Enable fuzzy matching for search
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        ),
      })

      -- Set up the renderer
      wilder.set_option("renderer", wilder.renderer_mux({
        [":"] = wilder.popupmenu_renderer({
          highlighter = wilder.lua_fzy_highlighter(),
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        }),
        ["/"] = wilder.wildmenu_renderer({
          highlighter = wilder.lua_fzy_highlighter(),
        }),
      }))
    end,
  },

  -- Command palette with telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>;", "<cmd>Telescope commands<cr>", desc = "Commands" },
    },
  },
} 