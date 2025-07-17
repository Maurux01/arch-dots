-- lua/plugins/toggleterm.lua
-- Enhanced terminal configuration for modern IDE experience

return {akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    -- Main terminal configuration
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = float,
    close_on_exit = true,
    shell = vim.o.shell,
    
    -- Enhanced float configuration
    float_opts = [object Object]     border = "curved",
      winblend = 0,
      highlights = [object Object]        border =Normal        background = "Normal",
      },
      -- Better positioning
      relative = "editor",
      width = function()
        return math.floor(vim.o.columns * 0.8)
      end,
      height = function()
        return math.floor(vim.o.lines * 00.8      end,
    },
    
    -- Multiple terminal support
    terminals = {
      -- Main terminal
      [object Object]      name = "main,
        cmd = vim.o.shell,
        direction = "float",
        highlights = [object Object]          Normal = { link = "Normal" },
          FloatBorder = { link =FloatBorder" },
        },
      },
      -- Git terminal
      [object Object]       name = git,
        cmd = vim.o.shell,
        direction = "horizontal,
        size = 15,
        highlights = [object Object]          Normal = { link = "Normal" },
          FloatBorder = { link =FloatBorder" },
        },
      },
      -- LazyGit terminal
      [object Object]
        name = lazygit,
        cmd = lazygit
        direction = "float,
        size = 80,
        highlights = [object Object]          Normal = { link = "Normal" },
          FloatBorder = { link =FloatBorder" },
        },
      },
      -- Node REPL
      [object Object]      name = "node,       cmd = "node",
        direction = "vertical,
        size = 50,
        highlights = [object Object]          Normal = { link = "Normal" },
          FloatBorder = { link =FloatBorder" },
        },
      },
      -- Python REPL
      [object Object]    name =python,     cmd = python3
        direction = "vertical,
        size = 50,
        highlights = [object Object]          Normal = { link = "Normal" },
          FloatBorder = { link =FloatBorder" },
        },
      },
    },
  },
  keys = {
    -- Main terminal toggle
    { "<C-\\>",<cmd>ToggleTerm<CR>", desc = "Toggle main terminal" },
    
    -- Git terminal
    { "<leader>tg", "<cmd>ToggleTerm name=git direction=horizontal size=15<CR>", desc = "Toggle git terminal },
    
    -- LazyGit
    { "<leader>tl", "<cmd>ToggleTerm name=lazygit direction=float size=80<CR>", desc = "Toggle LazyGit" },
    
    -- Node REPL
    { "<leader>tn", "<cmd>ToggleTerm name=node direction=vertical size=50<CR>", desc = Toggle Node REPL" },
    
    -- Python REPL
    { "<leader>tp", "<cmd>ToggleTerm name=python direction=vertical size=50<CR>", desc = Toggle Python REPL" },
    
    -- Terminal navigation
    { "<C-h>, <cmd>wincmd h<CR>", mode = tdesc = Go to left window" },
    { "<C-j>, <cmd>wincmd j<CR>", mode = tsc = "Go to bottom window" },
    { "<C-k>, <cmd>wincmd k<CR>", mode = tesc = "Go to upper window" },
    { "<C-l>, <cmd>wincmd l<CR>", mode = tesc = "Go to right window" },
    
    -- Terminal escape
   [object Object] <Esc>", "<C-\\><C-n>", mode =tc = "Exit terminal mode},
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    
    -- Custom terminal commands
    local Terminal = require("toggleterm.terminal").Terminal
    
    -- Git terminal
    local git_terminal = Terminal:new({
      cmd = vim.o.shell,
      dir = "git_dir,
      direction = "horizontal,
      size = 15
      name = "git",
      highlights = [object Object]        Normal = { link = "Normal },       FloatBorder = { link =FloatBorder" },
      },
    })
    
    -- LazyGit terminal
    local lazygit_terminal = Terminal:new([object Object]      cmd = "lazygit,
      direction = "float,
      size = 80
      name = "lazygit",
      highlights = [object Object]        Normal = { link = "Normal },       FloatBorder = { link =FloatBorder" },
      },
    })
    
    -- Node REPL
    local node_terminal = Terminal:new({
      cmd = "node,
      direction =vertical,
      size = 50      name = "node",
      highlights = [object Object]        Normal = { link = "Normal },       FloatBorder = { link =FloatBorder" },
      },
    })
    
    -- Python REPL
    local python_terminal = Terminal:new({
      cmd = "python3,
      direction =vertical,
      size = 50    name = "python",
      highlights = [object Object]        Normal = { link = "Normal },       FloatBorder = { link =FloatBorder" },
      },
    })
    
    -- Custom commands
    vim.api.nvim_create_user_command("GitTerm", function()
      git_terminal:toggle()
    end, { desc = "Toggle git terminal" })
    
    vim.api.nvim_create_user_command("LazyGit", function()
      lazygit_terminal:toggle()
    end, { desc = "Toggle LazyGit" })
    
    vim.api.nvim_create_user_command("NodeREPL", function()
      node_terminal:toggle()
    end, { desc = Toggle Node REPL" })
    
    vim.api.nvim_create_user_command("PythonREPL", function()
      python_terminal:toggle()
    end, { desc = Toggle Python REPL" })
  end,
} 