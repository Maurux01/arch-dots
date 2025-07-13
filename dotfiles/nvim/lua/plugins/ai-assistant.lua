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

  -- AI-powered code generation
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
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

  -- Open Source AI Chat (Alternative to CopilotChat)
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo $OPENAI_API_KEY",
        openai_params = {
          model = "gpt-3.5-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        openai_edit_params = {
          model = "code-davinci-edit-001",
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        max_history = 0,
        show_help = "yes",
        chat_input = {
          prompt = "> ",
        },
        chat_win_options = {
          winblend = 0,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
        popup_win_options = {
          winblend = 0,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
        show_break_lines = false,
        popup_layout = {
          default = "center",
          center = {
            width = 80,
            height = 80,
          },
          right = {
            width = 30,
            width_settings_open = 50,
          },
        },
        popup_type = {
          help = "float",
          chat = "float",
        },
        debug = false,
        disable_signs = false,
        log = {
          enabled = false,
          file = nil,
        },
        use_popup = true,
        highlights = {
          input = "Normal:Normal",
          unknown = "ErrorMsg",
          flags = "Special",
        },
        prompts = {
          Explain = "Explain how the selected code works.",
          Review = "Review the selected code and provide suggestions for improvement.",
          Tests = "Generate unit tests for the selected code.",
          Fix = "Fix the selected code and explain the changes.",
          Optimize = "Optimize the selected code and explain the improvements.",
          Docs = "Generate documentation for the selected code.",
        },
        chat = {
          sessions_window = {
            border = "single",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            winblend = 0,
          },
          type = "popup",
          relative = "editor",
          position = {
            row = 0,
            col = 0,
          },
          size = {
            width = 80,
            height = 80,
          },
          session = {
            auto_save = true,
            auto_save_path = vim.fn.stdpath("data") .. "/chatgpt_sessions",
          },
        },
        popup = {
          enter = "<CR>",
          close = "<C-c>",
        },
        keymaps = {
          close = { "<C-c>" },
          yank_last = "<g-y>",
          yank_last_code = "<g-c>",
          scroll_up = "<C-u>",
          scroll_down = "<C-d>",
          toggle_settings = "<C-o>",
          new_session = "<C-n>",
          cycle_windows = "<Tab>",
          select_session = "<Space>",
          rename_session = "r",
          delete_session = "d",
          draft_message = "<C-d>",
          toggle_settings = "<C-o>",
          toggle_message_role = "<C-r>",
          toggle_system_role_open = "<C-s>",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
} 