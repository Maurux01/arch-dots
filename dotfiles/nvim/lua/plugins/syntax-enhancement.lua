-- lua/plugins/syntax-enhancement.lua
-- Enhanced syntax highlighting and comment improvements for modern IDE experience

return {
  -- Enhanced Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",  "cpp",  "css",   "dockerfile",
        "gitignore",
        "go",
        "html",   "javascript",
        "json",
        "jsonc",    "lua",       "luadoc",
        "luap",
        "markdown",
        "markdown_inline",       "python",
        "query",
        "regex",
        "rust",
        "scss",  "sql",
        "toml",  "tsx",
        "typescript",  "vim",       "vimdoc",
        "yaml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autotag = { enable = true },
      context_commentstring = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",          scope_incremental = "<TAB>",
        },
      },
      textobjects = {
        enable = true,
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Around function" },
            ["if"] = { query = "@function.inner", desc = "Inside function" },
            ["ac"] = { query = "@class.outer", desc = "Around class" },
            ["ic"] = { query = "@class.inner", desc = "Inside class" },
            ["al"] = { query = "@loop.outer", desc = "Around loop" },
            ["il"] = { query = "@loop.inner", desc = "Inside loop" },
            ["ab"] = { query = "@block.outer", desc = "Around block" },
            ["ib"] = { query = "@block.inner", desc = "Inside block" },
            ["ap"] = { query = "@parameter.outer", desc = "Around parameter" },
            ["ip"] = { query = "@parameter.inner", desc = "Inside parameter" },        },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = { query = "@function.outer", desc = "Next function start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            ["]b"] = { query = "@block.outer", desc = "Next block start" },      },
          goto_next_end = {
            ["]M"] = { query = "@function.outer", desc = "Next function end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            ["]B"] = { query = "@block.outer", desc = "Next block end" },      },
          goto_previous_start = {
            ["[m"] = { query = "@function.outer", desc = "Previous function start" },
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
            ["[b"] = { query = "@block.outer", desc = "Previous block start" },      },
          goto_previous_end = {
            ["[M"] = { query = "@function.outer", desc = "Previous function end" },
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
            ["[B"] = { query = "@block.outer", desc = "Previous block end" },        },
        },
        swap = {
          enable = true,
          -- swap_next = { ["<leader>a"] = { query = "@parameter.inner", desc = "Swap next parameter" } },
          -- swap_previous = { ["<leader>A"] = { query = "@parameter.inner", desc = "Swap previous parameter" } },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      
      -- Enhanced highlighting for specific languages
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.markdown.filetype_to_parsername = "markdown" end,
  },

  -- Enhanced comment system
  {
    "numToStr/Comment.nvim",
    opts = {
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = {
        line = "<leader>cc",        block = "<leader>cb",
      },
      opleader = {
        line = "<leader>c",        block = "<leader>b",
      },
      extra = {
        above = "<leader>cO",        below = "<leader>co",
        eol = "<leader>cA",
      },
      mappings = {
        basic = true,
        extra = true,
        extended = false,
      },
      pre_hook = nil,
      post_hook = nil,
    },
    keys = {
      { "<leader>cc", mode = { "n" }, desc = "Toggle line comment" },
      { "<leader>cb", mode = { "n" }, desc = "Toggle block comment" },
      { "<leader>c", mode = { "v" }, desc = "Comment selection" },
      { "<leader>b", mode = { "v" }, desc = "Block comment selection" },
    },
  },

  -- Better indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "│",      context_char = "│",
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = true,
      show_current_context_start = true,
      filetype_exclude = {
        "help",
        "alpha",   "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",       "notify",   "toggleterm",
        "lazyterm",
      },
      buftype_exclude = { "terminal" },
    },
  },

  -- Rainbow parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    opts = {
      highlight = {
        RainbowDelimiterRed = "RainbowDelimiterRed",
        RainbowDelimiterYellow = "RainbowDelimiterYellow",
        RainbowDelimiterBlue = "RainbowDelimiterBlue",
        RainbowDelimiterOrange = "RainbowDelimiterOrange",
        RainbowDelimiterGreen = "RainbowDelimiterGreen",
        RainbowDelimiterViolet = "RainbowDelimiterViolet",
        RainbowDelimiterCyan = "RainbowDelimiterCyan",
      },
      query = {
        elixir = "rainbow-blocks",
        help = "rainbow-parens",
        javascript = "rainbow-parens",       lua = "rainbow-blocks",
        python = "rainbow-parens",       vim = "rainbow-parens",
        vimdoc = "rainbow-parens",       xml = "rainbow-tags",
      },
      strategy = {
        global = require("rainbow-delimiters").strategy.global,    html = require("rainbow-delimiters").strategy.local,
        javascript = require("rainbow-delimiters").strategy.local,
        lua = require("rainbow-delimiters").strategy.local,
        python = require("rainbow-delimiters").strategy.local,
        vim = require("rainbow-delimiters").strategy.local,
      },
    },
  },

  -- Better highlighting for search results
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25,
        inactive = true,
      },
      context = 10,
      treesitter = true,
      expand = {
        function,       method",
        table",
      if_statement,   for_statement",
      while_statement,   try_statement",
      catch_clause,       switch_statement",
        class   interface,       module",
       type",
       enum",
    type_alias",
    parameters,       string",
    assignment",
    variable_declaration",
      },
      exclude = {},
    },
    keys = {
      { "<leader>tt", "<cmd>Twilight<CR>", desc = "Toggle twilight" },
    },
  },

  -- Better highlighting for TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = { icon = "", color = "error", alt = { "FIXIT", "ISSUE" } },
        TODO = { icon = "", color = "info" },
        HACK = { icon = "", color = "warning" },
        WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      highlight = {
        before = "fg", -- "fg or "bg or empty
        keyword = "wide", --fg, bg, wide", wide_bg", wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg or "bg or empty
        pattern = [.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      search = {
        command = "rg",
        args = {
         --color=never,      --no-heading",
        --with-filename",
         --line-number",
    --column",
        },
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    },
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find todos" },
      { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Find todos/fixes" },
    },
  },

  -- Better highlighting for matching brackets
  {
    "monkoose/matchparen.nvim",
    opts = {
      on_startup = true,
      hl_group = "MatchParen",
      augroup_name = "matchparen",
    },
  },
} 