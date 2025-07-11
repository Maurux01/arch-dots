-- Custom LazyVim configuration
return {
  -- ============================================================================
  -- THEMES
  -- ============================================================================
  
  -- Catppuccin theme (primary)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      styles = {
        comments = { italic = true },
        conditionals = { italic = true },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        mason = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { italic = true },
            hints = { italic = true },
            warnings = { italic = true },
            information = { italic = true },
          },
          underlines = {
            errors = { underline = true },
            hints = { underline = true },
            warnings = { underline = true },
            information = { underline = true },
          },
        },
        notify = true,
        neotree = true,
        treesitter = true,
        which_key = true,
      },
      color_overrides = {},
      custom_highlights = {},
    },
  },

  -- Configure LazyVim to use Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- ============================================================================
  -- AI ASSISTANTS
  -- ============================================================================
  
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Copilot keymaps
      vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", { desc = "Copilot Next" })
      vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { desc = "Copilot Previous" })
      vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept)", { desc = "Copilot Accept" })
      vim.keymap.set("i", "<C-h>", "<Plug>(copilot-dismiss)", { desc = "Copilot Dismiss" })
      
      -- Normal mode keymaps for Copilot
      vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<cr>", { desc = "Copilot Panel" })
      vim.keymap.set("n", "<leader>cs", "<cmd>Copilot status<cr>", { desc = "Copilot Status" })
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "yes",
      debug = false,
      disable_extra_info = 'no',
      language = "English",
      model = "gpt-4",
      temperature = 0.1,
    },
    build = function()
      vim.notify("Please install 'ollama' to use CopilotChat.nvim")
    end,
    cmd = "CopilotChat",
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "Copilot Chat" },
      { "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
    },
  },

  -- Alternative AI: Codeium (free, no auth required)
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },

  -- ============================================================================
  -- ENHANCED FEATURES
  -- ============================================================================
  
  -- Rainbow brackets and parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          tsx = "rainbow-parens",
          javascript = "rainbow-parens",
          typescript = "rainbow-parens",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow", 
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },

  -- ============================================================================
  -- ADDITIONAL LANGUAGES
  -- ============================================================================
  
  -- Add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "html",
        "http",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
    end,
  },

  -- ============================================================================
  -- TOOLS
  -- ============================================================================
  
  -- Add any tools you want to have installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "black",
        "isort",
        "prettier",
        "eslint_d",
        "typescript-language-server",
        "lua-language-server",
        "rust-analyzer",
      })
    end,
  },

  -- ============================================================================
  -- LSP CONFIGURATIONS
  -- ============================================================================
  
  -- Add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        -- Add more LSP servers as needed
        lua_ls = {},
        rust_analyzer = {},
        tsserver = {},
      },
    },
  },

  -- ============================================================================
  -- UI ENHANCEMENTS
  -- ============================================================================
  
  -- Change some telescope options
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
}
