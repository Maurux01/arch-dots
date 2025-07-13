return {
  -- Code Capture for Screenshots and Videos
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    opts = {
      selected_lines = "Visual",
      show_repl_props = false,
      borders = "single",
    },
    keys = {
      { "<leader>cs", "<cmd>SnipRun<cr>", desc = "Run code snippet" },
      { "<leader>cl", "<cmd>SnipReset<cr>", desc = "Clear snippet output" },
    },
  },

  -- Screenshot functionality
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
        "function",
        "method",
        "table",
        "if_statement",
      },
    },
    keys = {
      { "<leader>ct", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
  },

  -- Code highlighting for screenshots
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "python",
        "bash",
        "rust",
        "go",
      },
    },
  },

  -- Terminal recording
  {
    "akinsho/toggleterm.nvim",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },

  -- Ascii art for code blocks
  {
    "jbyuki/venn.nvim",
    keys = {
      { "<leader>cv", "<cmd>VBox<cr>", desc = "Draw box around selection" },
    },
  },
} 