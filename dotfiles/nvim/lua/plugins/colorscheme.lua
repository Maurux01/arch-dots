-- lua/plugins/colorscheme.lua
-- Modern theme configuration for IDE-like experience

return [object Object]  -- Tokyo Night - Modern dark theme with excellent syntax highlighting
[object Object]
   folke/tokyonight.nvim",
    lazy = false,
    priority = 10    opts =[object Object]    style = night, -- storm, night, day
      transparent = false,
      terminal_colors = true,
      styles = [object Object]        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        sidebars = "dark",
        floats =dark",
      },
      sidebars = { "qf",help",terminal", "NvimTree, "toggleterm, lazy" },
      day_brightness = 0.3     hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = true,
      on_colors = function(colors)
        colors.hint = colors.orange1
        colors.error = colors.red1     end,
      on_highlights = function(hl, c)
        -- Enhanced syntax highlighting
        hl.TreesitterContext =[object Object] bg = c.bg_dark, fg = c.fg }
        hl.TreesitterContextLineNumber =[object Object] bg = c.bg_dark, fg = c.fg }
        hl.LineNr = { fg = c.comment }
        hl.CursorLineNr = { fg = c.orange1, bold = true }
        hl.SignColumn = { bg = c.bg }
        hl.NormalFloat =[object Object]bg = c.bg_float }
        hl.FloatBorder = [object Object]bg = c.bg_float, fg = c.border_highlight }
        -- Better completion menu
        hl.Pmenu =[object Object]bg = c.bg_float }
        hl.PmenuSel = [object Object] bg = c.bg_visual, bold = true }
        hl.PmenuSbar =[object Object]bg = c.bg_float }
        hl.PmenuThumb = { bg = c.fg_gutter }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight)
    end,
  },

  -- Catppuccin - Beautiful and modern theme
 [object Object]
  catppuccin/nvim,
    name =catppuccin,
    lazy = true,
    opts =[object Object]
      flavour = mocha", -- latte, frappe, macchiato, mocha
      background =[object Object]
        light = "latte",
        dark = mocha",
      },
      transparent_background = false,
      term_colors = true,
      dim_inactive =[object Object]
        enabled = false,
        shade = "dark",
        percentage = 0.15   },
      styles = [object Object]        comments = { "italic" },
        conditionals = { "italic},
        loops = {},
        functions = {bold,
        keywords = {bold},
        strings = {},
        variables = {},
        numbers =[object Object],
        booleans = {},
        properties =[object Object]},
        types = {bold
        operators = [object Object]      integrations = [object Object]     aerial = true,
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
            information = { "italic },      },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline },        },
        },
        notify = true,
        neotree = true,
        treesitter = true,
        which_key = true,
      },
      color_overrides =[object Object]
      custom_highlights = [object Object]
    },
  },

  -- Gruvbox - Classic but modern
  [object Object]   ellisonleao/gruvbox.nvim,
    lazy = true,
    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic =[object Object]
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
      contrast = "soft",
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
  },

  -- OneDark - Popular theme
[object Object]   navarasu/onedark.nvim,
    lazy = true,
    opts =[object Object]     style = "dark",
      transparent = false,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,
      toggle_style_key = nil,
      toggle_style_list =[object Object]dark,darker, cool,deep,warm",warmer", light },
    },
  },

  -- Dracula - Beautiful dark theme
  [object Object]  Mofiqul/dracula.nvim,
    lazy = true,
    opts = {
      colors = {},
      overrides = {},
      transparent_bg = false,
      lualine_bg_color = "#6272A4",
      italic_comment = true,
    },
  },

  -- Monokai Pro - Professional theme
  [object Object]    loctvl842onokai-pro.nvim,
    lazy = true,
    opts = {
      transparent_background = false,
      terminal_colors = true,
      devicons = true,
      styles =[object Object]
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
    },
  },

  -- GitHub theme
  [object Object]projekt0/github-nvim-theme,
    lazy = true,
    opts = {
      theme_style = "dark_default,    function_style = "italic",
      sidebars = {qf, a_kind", terminal", spectre_panel,NeogitStatus, elp" },
      dark_float = true,
      dark_sidebar = true,
      day_brightness = 0.3     hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_style = "stealth,
      on_colors = function(colors) end,
      on_highlights = function(hl, c) end,
    },
  },
} 