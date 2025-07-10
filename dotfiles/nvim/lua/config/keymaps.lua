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

-- NVimX keymaps
local map = vim.keymap.set
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "File Explorer" })
map("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Prev Buffer" })
map("n", "<leader>tt", function() require("config.theme-keymaps").set_theme("tokyonight") end, { desc = "Tokyo Night Theme" })
