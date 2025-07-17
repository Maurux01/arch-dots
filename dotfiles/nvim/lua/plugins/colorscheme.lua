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
  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night", transparent = false, terminal_colors = true },
  },
  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = { contrast = "hard", transparent_mode = false, terminal_colors = true },
  },
  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    opts = { transparent_bg = false, italic_comment = true },
  },
  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = { theme = "wave", transparent = false, terminal_colors = true },
  },
  -- One Dark Pro
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    opts = { style = "onedark", transparent = false, term_colors = true },
  },
  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = { variant = "main", dark_variant = "main", enable = { terminal = true } },
  },
  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = { options = { styles = { comments = "italic", keywords = "bold" }, transparent = false, terminal_colors = true } },
  },
  -- Oxocarbon
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    opts = { transparent = false, styles = { italic = true, bold = true } },
  },
} 