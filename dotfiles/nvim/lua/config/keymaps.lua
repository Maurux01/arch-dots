-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Load theme keymaps
require("config.theme-keymaps-new")

-- Load AI keymaps
require("config.ai-keymaps")

-- Load buffer navigation keymaps
require("config.buffer-keymaps")

-- Load test keymaps (temporary)
require("config.test-themes")

-- Load theme debug (temporary)
require("config.theme-debug")

<<<<<<< HEAD
-- NVimX keymaps
local map = vim.keymap.set
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "File Explorer" })
map("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Prev Buffer" })
map("n", "<leader>tt", function() require("config.theme-keymaps").set_theme("tokyonight") end, { desc = "Tokyo Night Theme" })
=======
-- =============================================================================
-- 🎯 CUSTOM KEYMAPS
-- =============================================================================

-- Disable any default Space + E keybind that might interfere
vim.keymap.del("n", "<leader>E", { silent = true })

-- Add useful Space + E keybind for Telescope find_files
vim.keymap.set("n", "<leader>E", "<cmd>Telescope find_files<cr>", { 
  desc = "Find Files (Telescope)",
  silent = true 
})

-- =============================================================================
-- 📝 KEYMAP SUMMARY
-- =============================================================================
-- Space + e  -> Explorer (Neotree)
-- Space + E  -> Find Files (Telescope)
-- =============================================================================
>>>>>>> c9651f0c7a71909e175e0a6e8d32e13436871899
