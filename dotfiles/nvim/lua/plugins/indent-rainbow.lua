-- lua/plugins/indent-rainbow.lua
-- Advanced indent rainbow configuration

return {
  -- Indent Rainbow for better visual indentation
  {
    "michaeljsmith/vim-indent-object",
    config = function()
      -- Enhanced indent object mappings
      vim.keymap.set(v, "<cmd>lua require('indent_object').indent_object('a',i')<CR>", { desc = "Indent object (outer)" })
      vim.keymap.set(v, "<cmd>lua require('indent_object').indent_object('i',i')<CR>", { desc = "Indent object (inner)" })
      vim.keymap.set(o, "<cmd>lua require('indent_object').indent_object('a',i')<CR>", { desc = "Indent object (outer)" })
      vim.keymap.set(o, "<cmd>lua require('indent_object').indent_object('i',i')<CR>", { desc = "Indent object (inner)" })
    end,
  },

  -- Enhanced indent guides with colors
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = true,
        show_end = true,
        injected_languages = true,
        highlight = "Function",
        priority = 50 
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- Rainbow parentheses with enhanced colors
  {
    "HiPhish/rainbow-delimiters.nvim",
    opts = {
      highlight = {
        RainbowDelimiterRed = "Red",
        RainbowDelimiterYellow = "Yellow",
        RainbowDelimiterBlue = "Blue",
        RainbowDelimiterOrange = "Orange",
        RainbowDelimiterGreen = "Green",
        RainbowDelimiterViolet = "Violet",
        RainbowDelimiterCyan = "Cyan",
      },
      query = {
        elixir = "rainbow-blocks",
        help = "rainbow-parens",
        javascript = "rainbow-parens",
        lua = "rainbow-blocks",
        python = "rainbow-parens",
        vim = "rainbow-parens",
        vimdoc = "rainbow-parens",
        xml = "rainbow-tags",
        tsx = "rainbow-parens",
        jsx = "rainbow-parens",
        typescript = "rainbow-parens",
      },
      strategy = {
        global = require("rainbow-delimiters").strategy.global,
        html = require("rainbow-delimiters").strategy.local,
        javascript = require("rainbow-delimiters").strategy.local,
        lua = require("rainbow-delimiters").strategy.local,
        python = require("rainbow-delimiters").strategy.local,
        vim = require("rainbow-delimiters").strategy.local,
      },
    },
  },

  -- Mini indentscope for current scope highlighting
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "│",
      options = {
        try_as_border = true,
        indent_at_cursor = true,
      },
      draw = {
        delay = 100,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },

  -- Enhanced syntax highlighting for better indent visualization
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      rainbow = { enable = true },
      autotag = { enable = true },
      context_commentstring = { enable = true },
    },
  },
} 