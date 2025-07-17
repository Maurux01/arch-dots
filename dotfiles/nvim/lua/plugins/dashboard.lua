-- lua/plugins/dashboard.lua
-- Modern dashboard using alpha-nvim for a professional IDE look

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      -- Custom header with ASCII art
      local header = {
        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗,
        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║,
        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║,
        ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║,
        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║,
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝,
                      🚀 Modern IDE Experience,
        "                    ⚡ Powered by Neovim",
      }

      -- Dashboard buttons with modern icons
      local buttons = {
        { type = "text", val = "Quick Actions", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        dashboard.button("e", "📁  New File", "<cmd>ene<CR>"),
        dashboard.button("f", "🔍  Find Files", "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "📚  Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", "🔎  Live Grep", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("t", "📋  Terminal", "<cmd>ToggleTerm<CR>"),
        dashboard.button("n", "🌳  File Tree", "<cmd>NvimTreeToggle<CR>"),
        dashboard.button("c", "⚙️  Config", "<cmd>edit ~/.config/nvim/init.lua<CR>"),
        dashboard.button("q", "❌  Quit", "<cmd>qa<CR>"),
        { type = "padding", val = 1 },
      }

      -- Footer with system info
      local footer = {
        { type = "text", val = "Session Management", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        dashboard.button("s", "💾  Save Session", "<cmd>SessionSave<CR>"),
        dashboard.button("l", "📂  Load Session", "<cmd>SessionLoad<CR>"),
        { type = "padding", val = 1 },
      }

      -- Theme & Customization buttons
      local customization = {
        { type = "text", val = "Theme & Customization", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        dashboard.button("1", "🌙  Tokyo Night", "<cmd>colorscheme tokyonight<CR>"),
        dashboard.button("2", "☕  Catppuccin", "<cmd>colorscheme catppuccin<CR>"),
        dashboard.button("3", "🌅  Gruvbox", "<cmd>colorscheme gruvbox<CR>"),
      }

      -- Footer with system info
      local footer = {
        { type = "text", val = "System Info", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        { type = "text", val = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100) / 100)
            return "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          end, opts = { hl = "Comment", position = "center" } },
        { type = "padding", val = 1 },
        { type = "text", val = "Press <leader>? for help", opts = { hl = "Comment", position = "center" } },
      }

      -- Configure dashboard layout
      local config = {
        layout = {
          { type = "padding", val = 2 },
          { type = "text", val = header, opts = { hl = "String", position = "center" } },
          { type = "padding", val = 2 },
          { type = "group", val = buttons },
          { type = "padding", val = 2 },
          { type = "group", val = customization },
          { type = "padding", val = 2 },
          { type = "group", val = footer },
        },
        opts = {
          margin = 5,
          setup = function()
            -- Disable statusline and tabline for cleaner look
            vim.opt.laststatus = 0
            vim.opt.showtabline = 0
            
            -- Re-enable them when leaving alpha
            vim.api.nvim_create_autocmd("User", {
              pattern = "AlphaReady",
              callback = function()
                vim.opt.laststatus = 3
                vim.opt.showtabline = 2
              end,
            })
          end,
        },
      }

      return config
    end,
    config = function(_, opts)
      require("alpha").setup(opts)
    end,
  },
} 