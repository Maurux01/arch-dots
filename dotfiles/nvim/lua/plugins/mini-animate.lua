return {
  -- Mini Animate (Smooth Animations)
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
          subscr = {
            { id = "resize", priority = 1000 },
            { id = "resize_tr", priority = 100 },
            { id = "resize_br", priority = 100 },
          },
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscr = { { id = "scroll", priority = 1000 }, { id = "scroll_win", priority = 100 } },
        },
        cursor = {
          timing = animate.gen_timing.linear({ duration = 26, unit = "total" }),
          subscr = { { id = "cursor", priority = 1000 }, { id = "curpos_win", priority = 100 } },
        },
        open = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
          subscr = { { id = "open", priority = 1000 }, { id = "open_win", priority = 100 } },
        },
        close = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
          subscr = { { id = "close", priority = 1000 }, { id = "close_win", priority = 100 } },
        },
      }
    end,
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },
} 