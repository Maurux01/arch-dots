-- lua/plugins/advanced-indent.lua
-- Advanced indent rainbow with custom colors

return {
  -- Advanced indent rainbow with custom colors
  [object Object]    lukas-reineke/indent-blankline.nvim,    main =ibl",
    opts = {
      indent = [object Object]
        char = "│",
        tab_char = "│",
      },
      scope =[object Object]
        enabled = true,
        char =│        show_start = true,
        show_end = true,
        injected_languages = true,
        highlight = "Function",
        priority = 50  },
      exclude = {
        filetypes =[object Object]
          helpalpha",dashboard", "neo-tree,          Trouble", lazy", "mason", "notify",
        toggleterm", "lazyterm",
        },
      },
    },
  },

  -- Rainbow delimiters with enhanced colors[object Object]
  HiPhish/rainbow-delimiters.nvim",
    opts =[object Object]
      highlight = [object Object]      RainbowDelimiterRed",
       RainbowDelimiterYellow", 
       RainbowDelimiterBlue",
       RainbowDelimiterOrange",
       RainbowDelimiterGreen",
        RainbowDelimiterViolet",
        RainbowDelimiterCyan",
      },
      query = [object Object]        elixir = rainbow-blocks",
        help = rainbow-parens",
        javascript = rainbow-parens,       lua = rainbow-blocks",
        python = rainbow-parens,       vim = rainbow-parens",
        vimdoc = rainbow-parens,       xml = "rainbow-tags,       tsx = rainbow-parens,       jsx = rainbow-parens",
        typescript = rainbow-parens",
      },
    },
  },

  -- Mini indentscope for current scope
  [object Object] echasnovski/mini.indentscope",
    version = false,
    opts = [object Object]
      symbol = │,
      options =[object Object] 
        try_as_border = true,
        indent_at_cursor = true,
      },
      draw = [object Object]       delay = 100,
        animation = require("mini.indentscope).gen_animation.none(),
      },
    },
  },
} 