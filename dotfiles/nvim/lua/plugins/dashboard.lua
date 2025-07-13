-- lua/plugins/dashboard.lua
-- Dashboard personalizado con logo de Neovim

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    ║
║    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    ║
║    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    ║
║    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    ║
║    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ║
║    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    ║
║                                                              ║
║                    🚀 Welcome to Neovim 🚀                   ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
      ]]

      local opts = {
        theme = "doom",
        config = {
          header = vim.split(logo, "\n"),
          center = {
            {
              icon = "󰈞 ",
              icon_hl = "Title",
              desc = "Find Files",
              desc_hl = "String",
              key = "f",
              key_hl = "Number",
              key_format = " [%s]",
              action = "Telescope find_files",
            },
            {
              icon = "󰉋 ",
              icon_hl = "Title",
              desc = "Recent Files",
              desc_hl = "String",
              key = "r",
              key_hl = "Number",
              key_format = " [%s]",
              action = "Telescope oldfiles",
            },
            {
              icon = "󰈢 ",
              icon_hl = "Title",
              desc = "Live Grep",
              desc_hl = "String",
              key = "g",
              key_hl = "Number",
              key_format = " [%s]",
              action = "Telescope live_grep",
            },
            {
              icon = "󰊄 ",
              icon_hl = "Title",
              desc = "Lazy",
              desc_hl = "String",
              key = "l",
              key_hl = "Number",
              key_format = " [%s]",
              action = "Lazy",
            },
            {
              icon = "󰒲 ",
              icon_hl = "Title",
              desc = "LazyGit",
              desc_hl = "String",
              key = "G",
              key_hl = "Number",
              key_format = " [%s]",
              action = "LazyGit",
            },
            {
              icon = "󰃢 ",
              icon_hl = "Title",
              desc = "Projects",
              desc_hl = "String",
              key = "p",
              key_hl = "Number",
              key_format = " [%s]",
              action = "Telescope projects",
            },
            {
              icon = "󰍉 ",
              icon_hl = "Title",
              desc = "Mason",
              desc_hl = "String",
              key = "m",
              key_hl = "Number",
              key_format = " [%s]",
              action = "Mason",
            },
            {
              icon = "󰒍 ",
              icon_hl = "Title",
              desc = "Check Health",
              desc_hl = "String",
              key = "h",
              key_hl = "Number",
              key_format = " [%s]",
              action = "checkhealth",
            },
            {
              icon = "󰐦 ",
              icon_hl = "Title",
              desc = "Quit",
              desc_hl = "String",
              key = "q",
              key_hl = "Number",
              key_format = " [%s]",
              action = "quit",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      return opts
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
} 