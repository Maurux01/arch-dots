return {
  -- Sessions (Session Management)
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/") },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- Auto Session
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      auto_session_enable_last_session = true,
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_use_git_branch = true,
      auto_session_verbose = false,
      auto_session_create_enabled = true,
      auto_session_last_session_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enable_last_session = true,
      auto_session_post_save_cmds = { "tabdo NvimTreeClose" },
      auto_session_pre_save_cmds = { "tabdo NvimTreeClose" },
    },
  },
} 