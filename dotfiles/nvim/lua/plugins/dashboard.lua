-- lua/plugins/dashboard.lua
-- Custom dashboard configuration
return {
  {
    'nvimdev/dashboard-nvim',
    lazy = false,
    priority = 1000, -- Load after other plugins
    config = function()
      require('dashboard').setup({
        theme = 'doom',
        config = {
          header = {
            '               ███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗',
            '               ██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝',
            '               █████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝ ',
            '               ██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝  ',
            '               ██║     ██║  ██║██║██████╔╝██║  ██║   ██║   ',
            '               ╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
            '',
            os.date("%Y-%m-%d %H:%M:%S"),
            '宜 : 祈福,入学,开市,求医,成服 忌 : 词讼,安门,移徙',
            '',
          },
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
              action = 'Telescope find_files find_command=fd,--type,executable',
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
          limit = 7,
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
      })
    end,
  },
} 