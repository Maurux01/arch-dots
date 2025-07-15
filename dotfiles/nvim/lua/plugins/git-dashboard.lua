-- lua/plugins/git-dashboard.lua
-- Git Dashboard Nvim configuration
return {
  {
    'juansalvatore/git-dashboard-nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('git-dashboard-nvim').setup {
        -- Show only weeks that have commits
        show_only_weeks_with_commits = true,
        
        -- Show the number of contributions
        show_contributions_count = false,
        
        -- Use the current branch
        use_current_branch = true,
        
        -- Title format: 'owner_with_repo_name', 'repo_name', 'owner/repo'
        title = 'owner_with_repo_name',
        
        -- Padding
        top_padding = 2,
        bottom_padding = 1,
        
        -- Center the heatmap
        centered = true,
        
        -- Day labels
        days = { 'S', 'M', 'T', 'W', 'T', 'F', 'S' },
        
        -- Filled squares (different levels of activity)
        filled_squares = { '█', '█', '█', '█', '█', '█' },
        
        -- Empty square
        empty_square = ' ',
        
        -- Gap between squares
        gap = '',
        
        -- Colors (GitHub theme)
        colors = {
          days_and_months_labels = '#61afef',
          empty_square_highlight = '#3e4452',
          filled_square_highlights = { 
            '#61afef', 
            '#61afef', 
            '#61afef', 
            '#61afef', 
            '#61afef', 
            '#61afef' 
          },
          branch_highlight = '#61afef',
          dashboard_title = '#61afef',
        },
      }
    end,
  },
} 