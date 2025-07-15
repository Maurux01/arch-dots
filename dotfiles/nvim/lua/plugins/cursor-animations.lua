-- lua/plugins/cursor-animations.lua
-- Beautiful and advanced cursor animations
return {
  -- Smooth cursor with beautiful effects
  {
    'gen740/smoothcursor.nvim',
    config = function()
      require('smoothcursor').setup({
        type = "default",
        fancy = {
          enable = true,
          head = { 
            cursor = "▷", 
            texthl = "SmoothCursor", 
            linehl = nil 
          },
          body = { 
            cursor = "█", 
            texthl = "SmoothCursor", 
            linehl = nil 
          },
          tail = { 
            cursor = "◁", 
            texthl = "SmoothCursor", 
            linehl = nil 
          },
        },
        sparkle = {
          enable = true,
          frequency = 2,
          size = 3,
          texthl = "SmoothCursorSparkle",
        },
        fly_mode = {
          enable = true,
          size = 4,
          texthl = "SmoothCursorFly",
        },
        speed = 20,
        intervals = 30,
        priority = 10,
        threshold = 2,
        disable_float_win = true,
        enabled_filetypes = nil,
        disabled_filetypes = {
          "TelescopePrompt",
          "NvimTree",
          "Lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "dashboard",
          "alpha",
        },
      })
    end
  },

  -- Cursor line with beautiful effects
  {
    'yamatsum/nvim-cursorline',
    config = function()
      require('nvim-cursorline').setup({
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { 
            underline = true,
            bold = true,
          },
        }
      })
    end
  },

  -- Beautiful cursor animations with effects
  {
    'mawkler/modicator.nvim',
    config = function()
      require('modicator').setup({
        -- Show warning if the required Neovim version is not met
        show_warnings = false,
        highlights = {
          -- Default highlights for different modes
          defaults = {
            bold = true,
            italic = true,
          },
        },
        integration = {
          -- Built-in integrations
          lualine = {
            enabled = true,
            -- Timeout in ms for the integration
            timeout = 1000,
          },
          native_lsp = {
            enabled = true,
            -- Timeout in ms for the integration
            timeout = 1000,
          },
        },
      })
    end
  },

  -- Cursor animations with smooth transitions
  {
    'echasnovski/mini.cursorword',
    version = false,
    config = function()
      require('mini.cursorword').setup({
        delay = 100,
      })
    end
  },

  -- Beautiful cursor highlighting
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup({
        symbol = "│",
        options = { 
          try_as_border = true,
          indent_at_cursor = true,
        },
        draw = {
          delay = 100,
          animation = require('mini.indentscope').gen_animation.none(),
        },
      })
    end
  },

  -- Cursor animations for search
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup({
        build_position_cb = function(plist, _, _, _)
          require("scrollbar.handlers.search").handler.show(plist.start_pos)
        end,
        calm_down = true,
        nearest_only = true,
        nearest_float_when = "always",
        virtual_hl = {
          enable = true,
          name = "HlslensVirtual",
        },
      })
      
      local kopts = {noremap = true, silent = true}
      
      vim.keymap.set('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require("hlslens").start()<CR>]],
        kopts)
      vim.keymap.set('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require("hlslens").start()<CR>]],
        kopts)
      vim.keymap.set('n', '*', [[*<Cmd>lua require("hlslens").start()<CR>]], kopts)
      vim.keymap.set('n', '#', [[#<Cmd>lua require("hlslens").start()<CR>]], kopts)
      vim.keymap.set('n', 'g*', [[g*<Cmd>lua require("hlslens").start()<CR>]], kopts)
      vim.keymap.set('n', 'g#', [[g#<Cmd>lua require("hlslens").start()<CR>]], kopts)
    end
  },

  -- Beautiful cursor line
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    config = function()
      require("ibl").setup({
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
          priority = 500,
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
      })
    end
  },

  -- Cursor animations for better visual feedback
  {
    'echasnovski/mini.animate',
    version = false,
    config = function()
      require('mini.animate').setup({
        -- Cursor animations
        cursor = {
          enable = true,
          timing = require('mini.animate').gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        -- Scroll animations
        scroll = {
          enable = true,
          timing = require('mini.animate').gen_timing.linear({ duration = 150, unit = 'total' }),
        },
        -- Resize animations
        resize = {
          enable = true,
          timing = require('mini.animate').gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        -- Open/close animations
        open = {
          enable = true,
          timing = require('mini.animate').gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        -- Close animations
        close = {
          enable = true,
          timing = require('mini.animate').gen_timing.linear({ duration = 100, unit = 'total' }),
        },
      })
    end
  },
} 