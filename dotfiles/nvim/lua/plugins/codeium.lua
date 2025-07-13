-- lua/plugins/codeium.lua
-- Configuración completa de Codeium para autocompletado con IA

return {
  -- Codeium
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    config = function()
      require("codeium").setup({})
      
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
      
      -- Comandos adicionales (cambiados para evitar conflictos)
      vim.keymap.set("n", "<leader>ci", "<cmd>Codeium<cr>", { desc = "Codeium: Toggle" })
      vim.keymap.set("n", "<leader>cc", "<cmd>Codeium<cr>", { desc = "Codeium: Toggle" })
      vim.keymap.set("n", "<leader>cs", "<cmd>Codeium<cr>", { desc = "Codeium: Status" })
    end,
  },
  
  -- Integración con nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "Exafunction/codeium.nvim",
    },
    opts = function(_, opts)
      -- Agregar Codeium como fuente de autocompletado
      table.insert(opts.sources, { name = "codeium", priority = 1000 })
      return opts
    end,
  },
} 