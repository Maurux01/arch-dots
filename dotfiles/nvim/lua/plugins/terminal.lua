-- lua/plugins/terminal.lua
-- Integración de toggleterm.nvim y keybinds para lazygit y lazydocker

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
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
        winblend = 10,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = { border = "curved" },
      })
      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        hidden = true,
        direction = "float",
        float_opts = { border = "curved" },
      })
      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end, { desc = "Abrir LazyGit (flotante)" })
      vim.keymap.set("n", "<leader>dd", function()
        lazydocker:toggle()
      end, { desc = "Abrir LazyDocker (flotante)" })
      -- Keybinds para capturas de pantalla desde Neovim
      vim.keymap.set("n", "<leader>ss", function()
        require("toggleterm").exec("bash ~/dotfiles/scripts/screenshot.sh", 1, 12, "float")
      end, { desc = "Screenshot pantalla completa" })
      vim.keymap.set("n", "<leader>sa", function()
        require("toggleterm").exec("bash ~/dotfiles/scripts/screenshot.sh s", 1, 12, "float")
      end, { desc = "Screenshot área" })
      vim.keymap.set("n", "<leader>sm", function()
        require("toggleterm").exec("bash ~/dotfiles/scripts/screenshot.sh m", 1, 12, "float")
      end, { desc = "Screenshot monitor" })
      vim.keymap.set("n", "<leader>sj", function()
        require("toggleterm").exec("bash ~/dotfiles/scripts/screenshot.sh --jpeg", 1, 12, "float")
      end, { desc = "Screenshot JPEG" })
      vim.keymap.set("n", "<leader>vr", function()
        require("toggleterm").exec("bash ~/dotfiles/scripts/nvim-record.sh", 1, 12, "float")
      end, { desc = "Grabar sesión de Neovim (video)" })
    end,
  },
} 