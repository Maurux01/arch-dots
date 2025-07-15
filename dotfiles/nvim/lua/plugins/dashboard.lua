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

      -- Custom FRIDAY banner (like in the image)
      local friday_banner = {
        '               ███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗',
        '               ██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝',
        '               █████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝ ',
        '               ██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝  ',
        '               ██║     ██║  ██║██║██████╔╝██║  ██║   ██║   ',
        '               ╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
      }

      -- Combine FRIDAY banner with git dashboard
      local combined_header = {}
      for _, line in ipairs(friday_banner) do
        table.insert(combined_header, line)
      end
      table.insert(combined_header, '') -- Empty line for spacing
      
      -- Add date and time info like in the image
      local current_time = os.date("%Y-%m-%d %H:%M:%S")
      table.insert(combined_header, current_time)
      table.insert(combined_header, '宜 : 祈福,入学,开市,求医,成服 忌 : 词讼,安门,移徙')
      table.insert(combined_header, '') -- Empty line for spacing
      
      for _, line in ipairs(git_dashboard) do
        table.insert(combined_header, line)
      end

      local opts = {
        theme = 'doom',
        config = {
          header = combined_header,
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
      }

      return opts
    end,
  },
} 