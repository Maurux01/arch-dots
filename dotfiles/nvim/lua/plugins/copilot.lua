return {
  -- Codeium (Free AI code completion)
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        tools = {
          -- Disable codeium language server
          codeium_lsp = {
            enabled = false,
          },
        },
        language_server = {
          -- Disable codeium language server
          enabled = false,
        },
      })
    end,
  },

  -- Tabnine (Alternative AI completion - Open Source)
  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    config = function()
      require("tabnine").setup({
        disable_auto_comment = true,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt", "NvimTree" },
        log_file_path = nil,
      })
    end,
  },

  -- AI-powered code actions
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "python",
        "bash",
        "rust",
        "go",
        "c",
        "cpp",
        "java",
        "php",
        "ruby",
        "sql",
        "xml",
        "toml",
        "dockerfile",
        "gitignore",
        "vim",
        "vimdoc",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autotag = { enable = true },
      context_commentstring = { enable = true },
    },
  },

  -- Auto pairs with AI suggestions
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
  },

  -- AI-powered refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "v" },
        desc = "Select Refactor",
      },
      {
        "<leader>rp",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        mode = "n",
        desc = "Debug Print",
      },
      {
        "<leader>rv",
        function()
          require("refactoring").debug.print_var({ normal = true })
        end,
        mode = "n",
        desc = "Debug Print Var",
      },
      {
        "<leader>rv",
        function()
          require("refactoring").debug.print_var({})
        end,
        mode = "v",
        desc = "Debug Print Var",
      },
      {
        "<leader>rc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        mode = "n",
        desc = "Debug Cleanup",
      },
    },
  },

  -- AI-powered code analysis
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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