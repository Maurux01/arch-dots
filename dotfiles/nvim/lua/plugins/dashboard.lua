-- lua/plugins/dashboard.lua
-- Dashboard-nvim with git-dashboard-nvim heatmap
return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
      { 'juansalvatore/git-dashboard-nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    opts = function()
      local git_dashboard = require('git-dashboard-nvim').setup {}

      local opts = {
        theme = 'doom',
        config = {
          header = git_dashboard,
          center = {
            {
              icon = '󰈞 ',
              desc = 'Find Files',
              key = 'f',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'Telescope find_files',
            },
            {
              icon = '󰉋 ',
              desc = 'Recent Files',
              key = 'r',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'Telescope oldfiles',
            },
            {
              icon = '󰈢 ',
              desc = 'Live Grep',
              key = 'g',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'Telescope live_grep',
            },
            {
              icon = '󰊄 ',
              desc = 'Lazy',
              key = 'l',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'Lazy',
            },
            {
              icon = '󰒲 ',
              desc = 'LazyGit',
              key = 'G',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'LazyGit',
            },
            {
              icon = '󰃢 ',
              desc = 'Projects',
              key = 'p',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'Telescope projects',
            },
            {
              icon = '󰍉 ',
              desc = 'Mason',
              key = 'm',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'Mason',
            },
            {
              icon = '󰒍 ',
              desc = 'Check Health',
              key = 'h',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'checkhealth',
            },
            {
              icon = '󰐦 ',
              desc = 'Quit',
              key = 'q',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'quit',
            },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
        hide = {
          statusline = false,
          tabline = false,
          winbar = false,
        },
        disable_move = false,
        shortcut_type = 'number',
        change_to_vcs_root = false,
        week_header = {
          enable = false,
        },
      }

      return opts
    end,
  },
} 