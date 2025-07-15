-- AI Assistant Plugins - Codeium y Avante
return {
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
      vim.keymap.set("i", "<Tab>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, desc = "Codeium: Accept suggestion" })
      vim.keymap.set("i", "<S-Tab>", function()
        return vim.fn["codeium#Next"]()
      end, { expr = true, silent = true, desc = "Codeium: Next suggestion" })
      vim.keymap.set("i", "<C-]>", function()
        return vim.fn["codeium#Dismiss"]()
      end, { expr = true, silent = true, desc = "Codeium: Dismiss suggestion" })
      vim.keymap.set("n", "<leader>ai", "<cmd>Codeium<cr>", { desc = "Codeium: Toggle" })
      vim.keymap.set("n", "<leader>as", "<cmd>Codeium<cr>", { desc = "Codeium: Status" })
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    keys = {
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