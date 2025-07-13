return {
  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "LazyGit Config" },
      { "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Filter" },
      { "<leader>gl", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Filter Current File" },
    },
    config = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1
      vim.g.lazygit_use_custom_config_file_path = 0
      vim.g.lazygit_config_file_path = ""
    end,
  },

  -- Git signs with enhanced features
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    },
    keys = {
      { "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end, expr = true, desc = "Next Git hunk" },
      { "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end, expr = true, desc = "Previous Git hunk" },
      { "<leader>rh", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Git hunk" },
      { "<leader>ph", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Git hunk" },
      { "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git blame" },
      { "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle Git deleted" },
    },
  },

  -- Git blame
  {
    "f-person/git-blame.nvim",
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git blame" },
    },
    opts = {
      enable_by_default = false,
      message_template = "<author> • <date> • <summary>",
      date_format = "%r",
      highlight_group = "Comment",
      virt_text_pos = "eol",
      delay = 1000,
    },
  },

  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    keys = {
      { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours" },
      { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both" },
      { "<leader>gcn", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None" },
      { "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous Conflict" },
      { "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
    },
  },
} 