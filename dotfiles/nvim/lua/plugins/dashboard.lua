-- lua/plugins/dashboard.lua
-- Alpha-nvim dashboard configuration with git-dashboard-nvim heatmap
return {
  {
    "goolord/alpha-nvim",
    dependencies = { 
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      
      -- Create custom header with git heatmap
      local custom_header = {
        '',
        '',
        ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '',
        '                    🚀 Welcome to Neovim 🚀                   ',
        '',
      }
      
      -- Try to add git heatmap if available
      local ok, git_dashboard = pcall(require, 'git-dashboard-nvim')
      if ok then
        local heatmap = git_dashboard
        if heatmap and #heatmap > 0 then
          for _, line in ipairs(heatmap) do
            table.insert(custom_header, line)
          end
        end
      end
      
      -- Configure alpha with custom header
      startify.config.header = custom_header
      
      require("alpha").setup(startify.config)
    end,
  },
} 