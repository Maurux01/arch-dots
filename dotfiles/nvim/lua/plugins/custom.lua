return {
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
  -- SYNTAX HIGHLIGHTING & BRACKETS
  -- ============================================================================
  
  -- Enhanced syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "cpp",
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
      },
    },
  },

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
  -- DARK THEMES
  -- ============================================================================
  
  -- Tokyo Night (Dark)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "NvimTree", "toggleterm" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
    },
  },

  -- Catppuccin (Dark)
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
        comments = { "italic" },
        conditionals = { "italic" },
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
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        notify = true,
        neotree = true,
        treesitter = true,
        which_key = true,
      },
    },
  },

  -- Gruvbox (Dark)
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_mode = false,
      terminal_colors = true,
      overrides = {},
      dim_inactive = false,
    },
  },

  -- ============================================================================
  -- LSP & COMPLETION
  -- ============================================================================
  
  -- Mason for LSP installation
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        "stylua",
        "rust-analyzer",
        "gopls",
        "pyright",
        "clangd",
      },
    },
  },

  -- Mason LSP config
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = {
      automatic_installation = true,
    },
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Luasnip for snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load()
    end,
  },

  -- Friendly snippets
  {
    "rafamadriz/friendly-snippets",
    event = "VeryLazy",
  },

  -- ============================================================================
  -- TELESCOPE & FUZZY FINDING
  -- ============================================================================
  
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Old Files" },
      { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
    },
  },

  -- ============================================================================
  -- GIT INTEGRATION
  -- ============================================================================
  
  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map("n", "<leader>ph", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>rh", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>Rp", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>sh", gs.stage_hunk, "Stage Hunk")
        map("n", "<leader>uh", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>bl", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Line Blame")
      end,
    },
  },

  -- ============================================================================
  -- STATUS LINE & UI
  -- ============================================================================
  
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- ============================================================================
  -- NOTIFICATIONS
  -- ============================================================================
  
  -- Notify
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },

  -- ============================================================================
  -- WHICH-KEY
  -- ============================================================================
  
  -- Which-key for keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
    },
  },
} 