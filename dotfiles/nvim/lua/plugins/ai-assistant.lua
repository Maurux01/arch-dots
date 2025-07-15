-- AI Assistant Plugins - Configuración limpia y optimizada
return {
  -- Codeium (Free AI code completion)
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    config = function()
      require("codeium").setup({
        tools = {
          codeium_lsp = {
            enabled = false,
          },
        },
        language_server = {
          enabled = false,
        },
      })
      
      -- Keybinds para Codeium
      vim.keymap.set("i", "<Tab>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, desc = "Codeium: Accept suggestion" })
      
      vim.keymap.set("i", "<S-Tab>", function()
        return vim.fn["codeium#Next"]()
      end, { expr = true, silent = true, desc = "Codeium: Next suggestion" })
      
      vim.keymap.set("i", "<C-]>", function()
        return vim.fn["codeium#Dismiss"]()
      end, { expr = true, silent = true, desc = "Codeium: Dismiss suggestion" })
      
      -- Comandos adicionales
      vim.keymap.set("n", "<leader>ai", "<cmd>Codeium<cr>", { desc = "Codeium: Toggle" })
      vim.keymap.set("n", "<leader>as", "<cmd>Codeium<cr>", { desc = "Codeium: Status" })
    end,
  },

  -- AI-powered refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "v" },
        desc = "Select Refactor",
      },
      {
        "<leader>rp",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        mode = "n",
        desc = "Debug Print",
      },
      {
        "<leader>rv",
        function()
          require("refactoring").debug.print_var({ normal = true })
        end,
        mode = "n",
        desc = "Debug Print Var",
      },
      {
        "<leader>rv",
        function()
          require("refactoring").debug.print_var({})
        end,
        mode = "v",
        desc = "Debug Print Var",
      },
      {
        "<leader>rc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        mode = "n",
        desc = "Debug Cleanup",
      },
    },
  },

  -- AI-powered code analysis
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      auto_open = false,
      auto_close = true,
      auto_preview = true,
      auto_fold = false,
      use_diagnostic_signs = true,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "<tab>" },
        open_in_browser = "gx",
        copy_to_clipboard = "<C-c>",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j",
        help = "?",
      },
    },
  },

  -- ChatGPT integration (Open Source)
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo $OPENAI_API_KEY",
        yank_register = "+",
        edit_with_instructions = {
          keymaps = {
            close = "<C-c>",
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-i>",
          },
        },
        chat = {
          keymaps = {
            close = { "<C-c>" },
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            toggle_settings = "<C-o>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            select_session = "<C-s>",
            rename_session = "r",
            delete_session = "d",
          },
        },
        popup_layout = {
          default = "center",
          center = {
            width = "80%",
            height = "80%",
          },
          right = {
            width = "30%",
            width_settings_open = "50%",
          },
        },
        popup_window = {
          filetype = "chatgpt",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " ChatGPT ",
              top_align = "center",
            },
          },
          win_options = {
            background = "Normal",
            winblend = 10,
          },
          buf_options = {
            filetype = "chatgpt",
          },
        },
        popup_input = {
          prompt = " ChatGPT ",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
            },
          },
          win_options = {
            background = "Normal",
            winblend = 10,
          },
          submit = "<C-Enter>",
          submit_n = "<Enter>",
          max_visible_lines = 20,
        },
        show_help = "yes",
        show_error = "yes",
        no_selection = false,
        model = "gpt-3.5-turbo",
        temperature = 0.2,
        openai_params = {
          model = "gpt-3.5-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0.2,
        },
        max_tokens = 300,
        fade_in_animation = {
          enabled = true,
          duration = 300,
        },
        context_provider = {
          enabled = false,
          mode = "buffer",
          providers = {
            ["gpt-3.5-turbo"] = "https://github.com/jackMort/ChatGPT.nvim/blob/main/scripts/context.lua",
            ["gpt-4"] = "https://github.com/jackMort/ChatGPT.nvim/blob/main/scripts/context.lua",
          },
        },
        system_window = {
          border = {
            style = "rounded",
            text = {
              top = " SYSTEM ",
            },
          },
        },
        popup_menu = {
          enabled = true,
          keymaps = {
            focus = "<C-k>",
            close = "<esc>",
          },
        },
        integrations = {
          telescope = {
            enabled = true,
            config = {},
          },
          which_key = {
            enabled = true,
            register = {
              add_actions = true,
              add_commands = true,
              add_alias = true,
            },
          },
        },
        callbacks = {},
      })
    end,
  },

  -- Avante.nvim - AI-powered Neovim IDE
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-tree",
    },
    keys = {
      -- Avante keybindings (conflict-free with existing plugins)
      {
        "<leader>aa",
        function()
          require("avante").toggle()
        end,
        desc = "Avante: Toggle chat",
      },
      {
        "<leader>ap",
        function()
          require("avante").planning()
        end,
        desc = "Avante: Planning mode",
      },
      {
        "<leader>ae",
        function()
          require("avante").editing()
        end,
        desc = "Avante: Editing mode",
      },
      {
        "<leader>as",
        function()
          require("avante").suggesting()
        end,
        desc = "Avante: Suggesting mode",
      },
      {
        "<leader>ac",
        function()
          require("avante").chat()
        end,
        desc = "Avante: Chat mode",
      },
      -- NvimTree integration
      {
        "<leader>a+",
        function()
          local tree_ext = require("avante.extensions.nvim_tree")
          tree_ext.add_file()
        end,
        desc = "Avante: Select file in NvimTree",
        ft = "NvimTree",
      },
      {
        "<leader>a-",
        function()
          local tree_ext = require("avante.extensions.nvim_tree")
          tree_ext.remove_file()
        end,
        desc = "Avante: Deselect file in NvimTree",
        ft = "NvimTree",
      },
    },
    config = function()
      require("avante").setup({
        provider = "gemini",
        provider_config = {
          api_key = os.getenv("GEMINI_API_KEY"),
          model = "gemini-pro",
          temperature = 0.1,
          max_tokens = 2000,
        },
        selector = {
          exclude_auto_select = { "NvimTree", "TelescopePrompt", "Trouble" },
          auto_select = true,
        },
        ui = {
          border = "rounded",
          width = 0.8,
          height = 0.8,
          relative = "editor",
        },
        rules = {
          project_dir = ".avante/rules",
          global_dir = "~/.config/avante/rules",
        },
        integrations = {
          nvim_tree = {
            enabled = true,
          },
          telescope = {
            enabled = true,
          },
        },
      })
    end,
  },
} 