-- AI Assistant Plugins - Solo Codeium
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
} 