-- lua/plugins/dashboard.lua
-- Dashboard funcional con logo de Neovim

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    enabled = true,
    config = function()
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = {
            "",
            "",
            " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "",
            "                    🚀 Welcome to Neovim 🚀                   ",
            "",
          },
          center = {
            {
              icon = "󰈞 ",
              desc = "Find Files",
              key = "f",
              action = "Telescope find_files",
            },
            {
              icon = "󰉋 ",
              desc = "Recent Files",
              key = "r",
              action = "Telescope oldfiles",
            },
            {
              icon = "󰈢 ",
              desc = "Live Grep",
              key = "g",
              action = "Telescope live_grep",
            },
            {
              icon = "󰊄 ",
              desc = "Lazy",
              key = "l",
              action = "Lazy",
            },
            {
              icon = "󰒲 ",
              desc = "LazyGit",
              key = "G",
              action = "LazyGit",
            },
            {
              icon = "󰃢 ",
              desc = "Projects",
              key = "p",
              action = "Telescope projects",
            },
            {
              icon = "󰍉 ",
              desc = "Mason",
              key = "m",
              action = "Mason",
            },
            {
              icon = "󰒍 ",
              desc = "Check Health",
              key = "h",
              action = "checkhealth",
            },
            {
              icon = "󰐦 ",
              desc = "Quit",
              key = "q",
              action = "quit",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
} 