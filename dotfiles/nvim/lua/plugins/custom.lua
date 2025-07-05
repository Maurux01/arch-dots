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

  -- Alternative: Cursor AI (if you prefer)
  -- Disabled due to GitHub authentication issues
  -- {
  --   "cursor-ai/cursor.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("cursor").setup({
  --       -- Configuration options
  --     })
  --   end,
  -- },

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
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "hard",
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
  },

  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      colors = {},
      transparent_bg = false,
      lualine_bg_color = "#44475a",
      italic_comment = true,
    },
  },

  -- One Dark
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark",
      transparent = false,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },
      lualine = {
        transparent = false,
      },
      diagnostics = {
        darker = false,
        undercurl = true,
        background = false,
      },
    },
  },

  -- Material Theme (Dark)
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      contrast = {
        sidebars = true,
        floating_windows = true,
        line_numbers = false,
        sign_column = false,
        fold_column = false,
        cursor_line = false,
      },
      styles = {
        comments = { italic = true },
        strings = { bold = true },
        keywords = { bold = true },
        functions = { bold = true },
        variables = {},
        operators = {},
        types = {},
      },
      plugins = {
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        lualine = {
          enabled = true,
        },
        gitsigns = {
          enabled = true,
        },
        nvim_tree = {
          enabled = true,
        },
        which_key = {
          enabled = true,
        },
        indent_blankline = {
          enabled = true,
        },
        vim_illuminate = {
          enabled = true,
        },
      },
      lualine_style = "stealth",
      async_loading = true,
      custom_colors = nil,
      custom_highlights = {},
      disable = {
        colored_cursor_line = false,
        borders = false,
        background = false,
        term_colors = false,
        eob_lines = false,
      },
      high_visibility = {
        lighter = false,
        darker = false,
      },
    },
  },

  -- Nightfox (Dark)
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
        module_default = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
          conditionals = "bold",
          constants = "bold",
          functions = "bold",
          numbers = "bold",
          operators = "bold",
          strings = "italic",
          variables = "bold",
        },
        inverse = {
          match_paren = false,
          visual = false,
          search = false,
        },
        modules = {
          aerial = true,
          barbar = true,
          beacon = false,
          cmp = true,
          coc = {
            enabled = true,
            background = true,
          },
          dap_ui = true,
          dashboard = true,
          diagnostic = {
            enabled = true,
            background = true,
          },
          fern = false,
          fidget = true,
          gitgutter = false,
          gitsigns = true,
          hop = false,
          illuminate = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          lightspeed = false,
          lsp_saga = false,
          lsp_trouble = true,
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = "italic",
              hints = "italic",
              warnings = "italic",
              information = "italic",
            },
            underlines = {
              errors = "underline",
              hints = "underline",
              warnings = "underline",
              information = "underline",
            },
          },
          navic = {
            enabled = false,
            custom_bg = false,
          },
          neogit = true,
          neotree = true,
          notify = true,
          nvimtree = true,
          packer = false,
          palette = true,
          parinfer = false,
          pounce = false,
          sneak = false,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          ts_rainbow = true,
          which_key = true,
        },
      },
      palettes = {},
      specs = {},
      groups = {},
    },
  },

  -- Kanagawa (Dark)
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
  },

  -- Rose Pine (Dark)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "moon",
      dark_variant = "moon",
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",
        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",
        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",
        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },
    },
  },

  -- Monokai Pro
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = false,
      terminal_colors = true,
      devicons = true,
      styles = {
        comment = { italic = true },
        keyword = { italic = true },
        type = { italic = true },
        storageclass = { italic = true },
        structure = { italic = true },
        parameter = { italic = true },
        annotation = { italic = true },
        tag_attribute = { italic = true },
      },
      filter = "pro",
      day_night = {
        enable = false,
        day_filter = "pro",
        night_filter = "octagon",
      },
      inc_search = "background",
      background_clear = {
        "float_win",
        "toggleterm",
        "telescope",
        "which-key",
        "renamer",
        "notify",
        "nvim-tree",
        "neo-tree",
        "bufferline",
      },
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
          underline_fill = false,
          bold = true,
        },
        indent_blankline = {
          context_highlight = "default",
          context_start_underline = false,
        },
      },
    },
  },

  -- Sonokai
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "andromeda"
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_disable_italic_comment = 0
      vim.g.sonokai_diagnostic_line_highlight = 1
      vim.g.sonokai_better_performance = 1
    end,
  },

  -- Edge
  {
    "sainnhe/edge",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.edge_style = "aura"
      vim.g.edge_enable_italic = 1
      vim.g.edge_disable_italic_comment = 0
      vim.g.edge_diagnostic_line_highlight = 1
      vim.g.edge_better_performance = 1
    end,
  },

  -- Oceanic Next
  {
    "mhartington/oceanic-next",
    lazy = false,
    priority = 1000,
  },

  -- Palenight
  {
    "drewtempelmeyer/palenight.vim",
    lazy = false,
    priority = 1000,
  },

  -- ============================================================================
  -- ADDITIONAL DARK THEMES WITH EXCELLENT SYNTAX HIGHLIGHTING
  -- ============================================================================

  -- Nord Theme (Excellent syntax highlighting)
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = true
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
    end,
  },

  -- Everforest (Nature-inspired with great syntax)
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_better_performance = 1
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_disable_italic_comment = 0
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diagnostic_virtual_text = "colored"
    end,
  },

  -- Doom One (Doom Emacs inspired)
  {
    "NTBBloodbath/doom-one.nvim",
    lazy = false,
    priority = 1000,
    -- No se requiere configuración especial, solo cargar el tema si se desea
    -- config = function()
    --   vim.cmd.colorscheme("doom-one")
    -- end,
  },

  -- Carbonfox (Part of Nightfox family)
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
        module_default = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
        inverse = {
          match_paren = false,
          visual = false,
          search = false,
        },
        modules = {
          carbonfox = {
            transparent = false,
          },
        },
      },
    },
  },

  -- Oxocarbon (IBM Carbon inspired)
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Melange (Warm dark theme)
  {
    "savq/melange-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.melange_transparent_background = false
      vim.g.melange_dim_inactive_windows = false
      vim.g.melange_term_colors = true
      vim.g.melange_plugin_default = "auto"
      -- Plugins
      vim.g.melange_plugins = {
        indent_blankline = { enabled = true },
        nvim_tree = { enabled = true },
        neogit = { enabled = true },
        gitsigns = { enabled = true },
        telescope = { enabled = true },
        which_key = { enabled = true },
        lsp_saga = { enabled = true },
        lightline = { enabled = true },
        lualine = { enabled = true },
        lspsaga = { enabled = true },
        cmp = { enabled = true },
        dap = { enabled = true },
        dap_ui = { enabled = true },
        neotree = { enabled = true },
        nvim_bufferline = { enabled = true },
        nvim_notify = { enabled = true },
        nvim_ts_rainbow = { enabled = true },
        ts_rainbow = { enabled = true },
        vim_illuminate = { enabled = true },
      }
    end,
  },

  -- Modus Vivendi (Accessible dark theme)
  {
    "ishan9299/modus-theme-vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.modus_theme = "modus-vivendi"
    end,
  },

  -- Vim One Dark (Enhanced One Dark)
  {
    "rakr/vim-one",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("one")
      vim.g.one_allow_italics = 1
    end,
  },

  -- Papercolor Dark (Material Design inspired)
  {
    "NLKNguyen/papercolor-theme",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.PaperColor_Theme_Options = {
        theme = {
          default = {
            transparent_background = 0,
          },
        },
      }
    end,
  },

  -- ============================================================================
  -- THEME SWITCHER
  -- ============================================================================
  
  -- Theme switcher functionality
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      -- Ensure spec table exists
      opts.spec = opts.spec or {}
      -- Add theme switching to which-key
      opts.spec["<leader>t"] = { name = "Themes" }
    end,
  },

  -- ============================================================================
  -- ADDITIONAL ENHANCEMENTS
  -- ============================================================================
  
  -- Better comments
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Better search and replace
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Search and Replace" },
    },
  },

  -- Better terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },

  -- Better file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle dir=%:p:h<cr>", desc = "Explorer Snacks (cwd)" },
    },
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
  },

  -- hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = {},
  },
}

-- Filtrar notificaciones de healthcheck de which-key
if pcall(require, "notify") then
  local notify = require("notify")
  local old = notify
  vim.notify = function(msg, ...)
    if type(msg) == "string" and msg:find('No healthcheck found for "which-keys"') then
      return
    end
    return old(msg, ...)
  end
end 