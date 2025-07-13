-- GitHub Nvim Theme configuration
return {
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup({
        options = {
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
          styles = {
            comments = "italic",
            keywords = "italic",
            functions = "bold",
            variables = "NONE",
            conditionals = "italic",
          },
        },
        groups = {},
        palettes = {},
        specs = {},
        plugins = {
          treesitter = true,
          cmp = true,
          gitsigns = true,
          telescope = true,
          nvimtree = true,
          indent_blankline = true,
          dashboard = true,
          neogit = true,
        },
      })
    end,
  },
} 