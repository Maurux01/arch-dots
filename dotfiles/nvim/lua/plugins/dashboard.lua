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
              icon = '󰑓 ',
              desc = 'Update [u]',
              key = 'u',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'Lazy sync',
            },
            {
              icon = '󰉋 ',
              desc = 'Files [f]',
              key = 'f',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = 'Telescope find_files',
            },
            {
              icon = '󰋩 ',
              desc = 'Apps [a]',
              key = 'a',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = function()
                require('telescope').extensions.app.default()
              end,
            },
            {
              icon = '󰙯 ',
              desc = 'dotfiles [d]',
              key = 'd',
              key_hl = 'DashboardShortCut',
              desc_hl = 'DashboardDesc',
              action = function()
                vim.cmd('cd ~/.config/nvim')
                require('telescope.builtin').find_files()
              end,
            },
          },
          footer = function()
            local stats = require('lazy').stats()
            return { '🚀 Sharp tools make good work.' }
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
        project = {
          enable = true,
          limit = 8,
          icon = '󰉋 ',
          label = 'Recently Projects:',
          action = 'Telescope find_files cwd=',
        },
        mru = {
          limit = 10,
          icon = '󰑓 ',
          label = 'Most Recent Files:',
          action = 'edit',
        },
        mru_file = {
          limit = 10,
          icon = '󰈙 ',
          label = 'Most Recent Files:',
          action = 'edit',
        },
      }

      return opts
    end,
  },
} 