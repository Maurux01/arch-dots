-- Modern dark themes only (plugins)
return {
  -- Catppuccin (Mocha, predeterminado)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = { flavour = "mocha" },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = { contrast = "hard" },
  },
  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
  },
  -- Nord
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },
  -- Everforest
  {
    "sainnhe/everforest",
    lazy = true,
  },
  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = { theme = "wave" },
  },
  -- One Dark Pro
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    opts = { style = "onedark" },
  },
  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = { variant = "main" },
  },
  -- Nightfox (y variantes)
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = { options = { styles = { comments = "italic", keywords = "bold" } } },
  },
  -- Oxocarbon
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
  },
  -- Monokai Pro
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
    opts = { filter = "pro" },
  },
  -- Ayu Dark
  {
    "Shatur/neovim-ayu",
    lazy = true,
    opts = { theme = "ayu-dark" },
  },
} 