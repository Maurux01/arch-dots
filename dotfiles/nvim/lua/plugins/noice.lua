return {
  -- Noice (Enhanced UI)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "notify",
            find = "nvim",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      throttle = 1000 / 30,
      views = {
        cmdline_popup = {
          position = {
            row = "50%",
            col = "50%",
          },
          size = {
            width = 50,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 24,
            height = 8,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
        notify = {
          backend = "notify",
          size = {
            width = 40,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
        mini = {
          win_options = {
            winblend = 20,
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
      -- Ajuste global de estilo para notificaciones
      format = {
        notification = {
          style = {
            font = "AdwaitaMono Nerd Font",
            size = 10,
            padding = 1,
            border_radius = 4,
          },
        },
      },
    },
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll Forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll Backward",
        mode = { "i", "n", "s" },
      },
    },
  },

  -- Notify (Enhanced Notifications)
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2500,
      max_height = function()
        return math.floor(vim.o.lines * 0.4)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.3)
      end,
      render = "compact",
      stages = "fade_in_slide_out",
      background_colour = "#1e1e2e",
      fps = 60,
      icons = false,
      on_open = function(win)
        vim.api.nvim_win_set_option(win, "conceallevel", 3)
        vim.api.nvim_win_set_option(win, "spell", false)
        vim.api.nvim_win_set_option(win, "list", false)
        vim.api.nvim_win_set_option(win, "wrap", false)
        vim.api.nvim_win_set_option(win, "linebreak", false)
        vim.api.nvim_win_set_option(win, "foldcolumn", "0")
        vim.api.nvim_win_set_option(win, "number", false)
        vim.api.nvim_win_set_option(win, "relativenumber", false)
        vim.api.nvim_win_set_option(win, "signcolumn", "no")
        -- Reducir tamaño de fuente y padding
        vim.api.nvim_win_set_option(win, "winblend", 20)
      end,
    },
    keys = {
      {
        "<leader>un",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All Notifications",
      },
    },
  },
} 