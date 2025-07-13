return {
  -- Web Development Tools
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "sass", "less", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "php", "xml", "xsl", "haml", "jade", "pug", "slim", "erb", "ejs" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-y>"
      vim.g.user_emmet_settings = {
        javascript = {
          extends = "jsx",
        },
        typescript = {
          extends = "tsx",
        },
      }
    end,
  },

  -- Prettier
  {
    "prettier/vim-prettier",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "json", "html", "vue", "yaml", "markdown" },
    build = "npm install",
    config = function()
      vim.g["prettier#autoformat"] = 1
      vim.g["prettier#autoformat_require_pragma"] = 0
      vim.g["prettier#exec_cmd_async"] = 1
    end,
  },

  -- Colorizer (Color highlighting)
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = true,
        sass = { enable = true, parsers = { css } },
        virtualtext = "■",
        always_update = true,
      },
      buftypes = {},
    },
  },

  -- Rainbow (Bracket colorization)
  {
    "luochen1990/rainbow",
    event = "BufReadPre",
    config = function()
      vim.g.rainbow_active = 1
      vim.g.rainbow_conf = {
        separately = {
          lua = { enabled = 0 },
          html = { enabled = 0 },
          xml = { enabled = 0 },
          markdown = { enabled = 0 },
        },
      }
    end,
  },

  -- Trouble (Better diagnostics view)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xw", "<cmd>Trouble workspace_diagnostics toggle<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix List (Trouble)" },
      { "gR", "<cmd>Trouble lsp_references toggle<cr>", desc = "References (Trouble)" },
    },
    opts = {
      auto_open = false,
      auto_close = true,
      auto_preview = true,
      auto_fold = false,
      use_diagnostic_signs = true,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "<tab>" },
        open_in_browser = "gx",
        copy_to_clipboard = "<C-c>",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j",
        help = "?",
      },
    },
  },
} 