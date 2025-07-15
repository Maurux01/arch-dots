-- lua/plugins/dashboard.lua
-- Dashboard funcional con logo de Neovim
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    enabled = true,
    config = function()
      -- Asegurar que el dashboard se muestre solo cuando no hay argumentos
      local function should_show_dashboard()
        return vim.fn.argc() == 0 and vim.fn.bufnr() == 1 and vim.fn.bufname() == ""
      end
      
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
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "Telescope find_files",
            },
            {
              icon = "󰉋 ",
              desc = "Recent Files",
              key = "r",
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "Telescope oldfiles",
            },
            {
              icon = "󰈢 ",
              desc = "Live Grep",
              key = "g",
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "Telescope live_grep",
            },
            {
              icon = "󰊄 ",
              desc = "Lazy",
              key = "l",
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "Lazy",
            },
            {
              icon = "󰒲 ",
              desc = "LazyGit",
              key = "G",
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "LazyGit",
            },
            {
              icon = "󰃢 ",
              desc = "Projects",
              key = "p",
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "Telescope projects",
            },
            {
              icon = "󰍉 ",
              desc = "Mason",
              key = "m",
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "Mason",
            },
            {
              icon = "󰒍 ",
              desc = "Check Health",
              key = "h",
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "checkhealth",
            },
            {
              icon = "󰐦 ",
              desc = "Quit",
              key = "q",
              key_hl = "DashboardShortCut",
              desc_hl = "DashboardDesc",
              action = "quit",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
        hide = {
          statusline = false,
          tabline = false,
          winbar = false,
        },
        preview = {
          command = "ueberzug",
          file_path = nil,
          file_height = 12,
          file_width = 40,
        },
        mru = {
          limit = 10,
        },
        project = {
          limit = 8,
        },
        disable_move = false,
        shortcut_type = "number",
        change_to_vcs_root = false,
        config_file = nil,
        open_cmd = "edit",
        week_header = {
          enable = false,
        },
        disable = false,
      })
      
      -- Asegurar que el dashboard se muestre en el momento correcto
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          if should_show_dashboard() then
            vim.cmd("Dashboard")
          end
        end,
      })
      
      -- Fallback: mostrar dashboard después de un breve delay
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if should_show_dashboard() then
            vim.defer_fn(function()
              vim.cmd("Dashboard")
            end, 100)
          end
        end,
      })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
} 