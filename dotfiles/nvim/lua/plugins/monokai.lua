-- Monokai Pro theme configuration
return {
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        transparent_background = false,
        terminal_colors = true,
        devicons = true,
        styles = {
          comment = { italic = true },
          keyword = { italic = true },
          type = { italic = true },
          function = { italic = true },
          variable = {},
          string = {},
          number = {},
          constant = {},
          operator = {},
          preproc = {},
          include = {},
          special = {},
          tag = {},
          delimiter = {},
          statement = {},
          storageclass = {},
          structure = {},
          typedef = {},
          specialchar = {},
          conditional = {},
          repeat = {},
          label = {},
          exception = {},
          debug = {},
          identifier = {},
          specialcomment = {},
          underlined = {},
          ignore = {},
          error = {},
          todo = {},
        },
        filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum | classic
        day_night = {
          enable = false,
          day_filter = "pro",
          night_filter = "spectrum"
        },
        inc_search = { background = false },
        background_clear = {
          "toggleterm",
          "telescope",
          "which-key",
          "notify",
          "nvim-tree",
          "lazy",
          "mason"
        },
        plugins = {
          bufferline = {
            underline_selected = false,
            underline_visible = false,
            underline_fill = false,
            bold = true
          },
          indent_blankline = {
            color = "monokai_pro_spectrum",
            context_color = "monokai_pro_spectrum",
            context_style = "bold"
          },
          illuminate = {
            delay = 120
          },
          neotree = {
            contrast = false,
            transparency = false
          },
          notify = {
            background_colour = "#000000"
          },
          nvim_tree = {
            contrast = false,
            transparency = false
          },
          telescope = {
            borderless = true,
            border = false
          },
          which_key = {
            border = false
          }
        },
        -- Valid override function (empty for now)
        override = function(colors)
          return {}
        end
      })
    end
  }
} 