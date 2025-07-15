-- lua/plugins/animations.lua
-- Beautiful and fast animations for Neovim
return {
  -- Smooth scrolling and animations
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {
          '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb'
        },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = false,     -- Disable "Performance Mode" on all buffers.
      })
    end
  },

  -- Smooth cursor animations
  {
    'gen740/smoothcursor.nvim',
    config = function()
      require('smoothcursor').setup({
        type = "default",        -- Cursor movement calculation method
        fancy = {
          enable = true,         -- Enable fancy mode
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
          body = { cursor = "█", texthl = "SmoothCursor", linehl = nil },
          tail = { cursor = "◁", texthl = "SmoothCursor", linehl = nil },
        },
        sparkle = {
          enable = true,         -- Enable sparkle effect
          frequency = 3,         -- Sparkle frequency
          size = 2,              -- Sparkle size
          texthl = "SmoothCursorSparkle",
        },
        fly_mode = {
          enable = true,         -- Enable fly mode
          size = 3,              -- Fly mode size
          texthl = "SmoothCursorFly",
        },
        speed = 25,              -- Cursor movement speed
        intervals = 35,          -- Smooth intervals
        priority = 10,           -- Set marker priority
        threshold = 3,           -- Animate only if the distance is greater than this value
        disable_float_win = true, -- Disable on float windows
        enabled_filetypes = nil, -- Enable only for specific file types
        disabled_filetypes = {   -- Disable for specific file types
          "TelescopePrompt",
          "NvimTree",
          "Lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      })
    end
  },

  -- Smooth window transitions
  {
    'anuvyklack/hydra.nvim',
    config = function()
      local hydra = require('hydra')
      
      -- Window management with smooth animations
      local window_hydra = hydra({
        name = 'Window',
        mode = 'n',
        body = '<leader>w',
        heads = {
          { 'h', '<C-w>h', { desc = 'Go to left window' } },
          { 'j', '<C-w>j', { desc = 'Go to lower window' } },
          { 'k', '<C-w>k', { desc = 'Go to upper window' } },
          { 'l', '<C-w>l', { desc = 'Go to right window' } },
          { 's', '<C-w>s', { desc = 'Split horizontally' } },
          { 'v', '<C-w>v', { desc = 'Split vertically' } },
          { 'q', '<C-w>q', { desc = 'Close window' } },
          { '=', '<C-w>=', { desc = 'Equalize windows' } },
          { '<Esc>', nil, { exit = true, desc = 'Exit' } },
        }
      })
    end
  },

  -- Smooth notifications
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        stages = "fade_in_slide_out",
        timeout = 3000,
        background_colour = "#000000",
        icons = {
          DEBUG = "󰍛",
          ERROR = "󰅚",
          INFO = "󰋼",
          TRACE = "󰎆",
          WARN = "󰀪",
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        top_down = true,
      })
      
      -- Override vim.notify to use nvim-notify
      vim.notify = require('notify')
    end
  },

  -- Smooth telescope animations
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      
      telescope.setup({
        defaults = {
          -- Smooth scrolling in results
          scroll_strategy = "cycle",
          -- Smooth preview scrolling
          preview = {
            scroll_down = '<C-f>',
            scroll_up = '<C-b>',
          },
          -- Smooth selection animations
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
            },
            n = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = false,
            no_ignore_parent = false,
          },
          live_grep = {
            additional_args = function()
              return {"--hidden"}
            end,
          },
        },
      })
      
      telescope.load_extension('fzf')
    end
  },

  -- Smooth LSP animations
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('trouble').setup({
        mode = "workspace_diagnostics",
        auto_preview = false,
        auto_fold = false,
        auto_jump = {},
        use_diagnostic_signs = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = {"<cr>", "<tab>"},
          open_in_browser = "gx",
          copy_to_clipboard = "<C-c>",
          toggle_outline = "T",
          switch_severity = "s",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = "zM",
          cancel = "<c-e>",
        },
      })
    end
  },

  -- Smooth buffer animations
  {
    'kazhala/close-buffers.nvim',
    config = function()
      require('close_buffers').setup({
        filetype_ignore = {},
        file_glob_ignore = {},
        file_regex_ignore = {},
        preserve_window_layout = { 'this', 'nameless' },
        next_buffer_cmd = nil,
      })
    end
  },

  -- Smooth indent animations
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require('mini.indentscope').setup({
        symbol = "│",
        options = { try_as_border = true },
        draw = {
          delay = 100,
          animation = require('mini.indentscope').gen_animation.none(),
        },
      })
    end
  },

  -- Smooth pairs animations
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function()
      require('mini.pairs').setup({
        modes = { insert = true, command = false, terminal = false },
        pairs = { { '(', ')' }, { '[', ']' }, { '{', '}' } },
        ignore_dot_repeat = true,
        disable_filetype = { 'TelescopePrompt', 'gitcommit' },
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
          offset = 0,
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey = 'Comment',
        },
      })
    end
  },

  -- Smooth surround animations
  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require('mini.surround').setup({
        mappings = {
          add = 'sa',
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          replace = 'sr',
          update_n_lines = 'sn',
        },
        search_method = 'cover_or_next',
        n_lines = 20,
        custom_surroundings = nil,
        highlight_duration = 500,
        highlight_grey = 'Comment',
        mappings = {
          add = 'sa',
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          replace = 'sr',
          update_n_lines = 'sn',
        },
      })
    end
  },
} 