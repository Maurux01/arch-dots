-- lua/plugins/visual-effects.lua
-- Additional visual effects and animations
return {
  -- Rainbow parentheses
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          html = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
          javascript = 'rainbow-delimiters-react',
          typescript = 'rainbow-delimiters-react',
          tsx = 'rainbow-delimiters-react',
          jsx = 'rainbow-delimiters-react',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
  },

  -- Smooth cursor line
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
          hl = { underline = true },
        }
      })
    end
  },

  -- Animated search highlighting
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup({
        build_position_cb = function(plist, _, _, _)
          require("scrollbar.handlers.search").handler.show(plist.start_pos)
        end,
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

  -- Smooth scrollbar
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000,
        marks = {
          GitAdd = { text = " ", color = "SignAdd" },
          GitChange = { text = " ", color = "SignChange" },
          GitDelete = { text = " ", color = "SignDelete" },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
          "notify",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
          clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
          },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = false,
          search = false,
        },
      })
    end
  },

  

  -- Animated treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "javascript", "typescript", "tsx",
          "python", "rust", "go",
          "html", "css", "json",
          "markdown", "yaml", "toml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        autotag = { enable = true },
        rainbow = { enable = true },
        context_commentstring = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end
  },
} 