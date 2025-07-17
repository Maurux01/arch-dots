-- Modern dark themes only (plugins) - Optimized for contrast and visual appeal
return {
  -- Catppuccin (Mocha, predeterminado) - Excelente contraste
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = { 
      flavour = "mocha",
      transparent_background = false,
      term_colors = true,
      integrations = {
        aerial = true,
        alpha = true,
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
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  
  -- Tokyo Night - Moderno y elegante
  {
    "folke/tokyonight.nvim",
    lazy = true,
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
      sidebars = { "qf", "help", "terminal", "neotree", "telescope" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
    },
  },
  
  -- Gruvbox - Clásico pero modernizado
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = { 
      contrast = "hard",
      transparent_mode = false,
      terminal_colors = true,
      overrides = {
        SignColumn = { bg = "#282828" },
        GruvboxRedSign = { bg = "#282828" },
        GruvboxGreenSign = { bg = "#282828" },
        GruvboxBlueSign = { bg = "#282828" },
        GruvboxYellowSign = { bg = "#282828" },
        GruvboxPurpleSign = { bg = "#282828" },
        GruvboxOrangeSign = { bg = "#282828" },
        GruvboxAquaSign = { bg = "#282828" },
      },
    },
  },
  
  -- Dracula - Excelente contraste
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    opts = {
      transparent_bg = false,
      italic_comment = true,
      overrides = {
        -- Customize colors for better contrast
        Comment = { fg = "#6272A4", italic = true },
        LineNr = { fg = "#6272A4" },
        CursorLineNr = { fg = "#F8F8F2" },
      },
    },
  },
  
  -- Kanagawa - Elegante y moderno
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = { 
      theme = "wave",
      transparent = false,
      terminal_colors = true,
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Customize for better contrast
          Comment = { fg = theme.syn.comment, italic = true },
          LineNr = { fg = theme.syn.comment },
          CursorLineNr = { fg = theme.ui.special },
        }
      end,
    },
  },
  
  -- One Dark Pro - Excelente para desarrollo
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    opts = { 
      style = "onedark",
      transparent = false,
      term_colors = true,
      styles = {
        types = "NONE",
        methods = "NONE",
        numbers = "NONE",
        strings = "NONE",
        comments = "italic",
        keywords = "bold,italic",
        constants = "NONE",
        functions = "NONE",
        operators = "NONE",
        variables = "NONE",
        parameters = "NONE",
        conditionals = "italic",
        virtual_text = "NONE",
      },
    },
  },
  
  -- Rose Pine - Moderno y elegante
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = { 
      variant = "main",
      dark_variant = "main",
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        migrations = true,
        semantic_tokens = true,
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
        warn = "rose",
        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_stash = "muted",
        git_text = "rose",
        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
      },
    },
  },
  
  -- Nightfox - Variantes modernas
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = { 
      options = { 
        styles = { 
          comments = "italic", 
          keywords = "bold",
          functions = "bold",
          strings = "italic",
        },
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
        module_default = true,
        colorblind = {
          enable = false,
          simulate_only = false,
          severity = {
            protan = 0,
            deutan = 0,
            tritan = 0,
          },
        },
      },
    },
  },
  
  -- Oxocarbon - Minimalista y elegante
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    opts = {
      transparent = false,
      styles = {
        italic = true,
        bold = true,
      },
    },
  },
} 