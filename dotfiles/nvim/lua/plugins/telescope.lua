-- lua/plugins/telescope.lua
-- Configuración personalizada de Telescope

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  opts = {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = "  ",
      border = true,
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      winblend = 10,
      results_title = false,
      preview_title = false,
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<C-n>"] = "cycle_history_next",
          ["<C-p>"] = "cycle_history_prev",
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        hidden = true,
        theme = "dropdown",
        previewer = false,
        layout_config = {
          width = 0.5,
          height = 0.5,
        },
      },
      buffers = {
        sort_lastused = true,
        sort_mru = true,
        ignore_current_buffer = true,
        theme = "dropdown",
        previewer = false,
        layout_config = {
          width = 0.5,
          height = 0.5,
        },
      },
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end,
        theme = "dropdown",
        previewer = false,
        layout_config = {
          width = 0.6,
          height = 0.5,
        },
      },
      file_browser = {
        hidden = true,
        respect_gitignore = true,
        grouped = true,
        initial_mode = "normal",
        theme = "dropdown",
        layout_config = {
          width = 0.9,
          height = 0.8,
        },
      },
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
        hijack_netrw = true,
        initial_mode = "normal",
        layout_config = {
          width = 0.9,
          height = 0.8,
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("file_browser")
  end,
} 