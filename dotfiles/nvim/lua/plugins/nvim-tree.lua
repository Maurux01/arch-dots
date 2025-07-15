-- lua/plugins/nvim-tree.lua
-- NvimTree - File explorer like VS Code

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
    { "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Focus NvimTree" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc = "Collapse NvimTree" },
    { "<leader>er", "<cmd>NvimTreeRefresh<cr>", desc = "Refresh NvimTree" },
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "󰈙",
            symlink = "󰉒",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_closed = "󰉋",
              arrow_open = "󰉋",
              default = "󰉋",
              open = "󰉋",
              empty = "󰉋",
              empty_open = "󰉋",
              symlink = "󰉒",
              symlink_open = "󰉒",
            },
            git = {
              unstaged = "󰄱",
              staged = "󰱒",
              unmerged = "󰘬",
              renamed = "󰁕",
              untracked = "󰈔",
              deleted = "󰩺",
              ignored = "󰈝",
            },
          },
        },
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_files = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    })
  end,
} 