-- lua/plugins/command-history.lua
-- Advanced command line completion and history

return {
  -- Command palette with telescope (primary method)
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>;", "<cmd>Telescope commands<cr>", desc = "Commands" },
    },
  },

  -- Wilder.nvim as fallback (simplified configuration)
  {
    "gelguy/wilder.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local status_ok, wilder = pcall(require, "wilder")
      if not status_ok then
        vim.notify("wilder.nvim not found!", vim.log.levels.WARN)
        return
      end

      wilder.setup({
        modes = { ":", "/", "?" },
        next_key = "<Tab>",
        prev_key = "<S-Tab>",
        accept_key = "<Down>",
        reject_key = "<Up>",
      })

      -- Simple configuration without external dependencies
      wilder.set_option("use_python_remote_plugin", false)
      
      -- Basic pipeline without fzy-lua-native
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
          }),
          wilder.vim_search_pipeline()
        ),
      })

      -- Simple renderer
      wilder.set_option("renderer", wilder.renderer_mux({
        [":"] = wilder.popupmenu_renderer({
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        }),
        ["/"] = wilder.wildmenu_renderer({}),
      }))
    end,
  },
} 