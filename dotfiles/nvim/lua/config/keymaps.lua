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

-- NVimX keymaps
local map = vim.keymap.set
map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "File Explorer" })
map("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Prev Buffer" })

-- =============================================================================
-- 🪟 WINDOW & SPLIT MANAGEMENT
-- =============================================================================

-- Close splits/windows
map("n", "<leader>q", "<cmd>close<cr>", { desc = "Close Window/Split" })
map("n", "<leader>Q", "<cmd>q!<cr>", { desc = "Force Close Window" })
map("n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save and Close" })

-- Split management
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal Split" })
map("n", "<leader>sc", "<cmd>close<cr>", { desc = "Close Split" })
map("n", "<leader>so", "<cmd>only<cr>", { desc = "Close Other Splits" })

-- Window navigation (like VSCode)
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Down Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Up Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Window resizing
map("n", "<C-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease Width" })
map("n", "<C-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase Width" })
map("n", "<C-Up>", "<cmd>resize -5<cr>", { desc = "Decrease Height" })
map("n", "<C-Down>", "<cmd>resize +5<cr>", { desc = "Increase Height" })

-- Window equalization
map("n", "<leader>=", "<cmd>wincmd =<cr>", { desc = "Equalize Windows" })

local theme_persistence = require("config.theme-persistence")

local function set_theme_and_save(theme)
  vim.cmd.colorscheme(theme)
  theme_persistence.save_theme(theme)
end

map("n", "<leader>tt", function() set_theme_and_save("tokyonight") end, { desc = "Tokyo Night Theme" })
map("n", "<leader>tc", function() set_theme_and_save("catppuccin") end, { desc = "Catppuccin Theme" })
map("n", "<leader>tg", function() set_theme_and_save("gruvbox") end, { desc = "Gruvbox Theme" })
map("n", "<leader>td", function() set_theme_and_save("dracula") end, { desc = "Dracula Theme" })
map("n", "<leader>to", function() set_theme_and_save("onedark") end, { desc = "One Dark Theme" })
map("n", "<leader>tm", function() set_theme_and_save("material") end, { desc = "Material Theme" })
map("n", "<leader>tf", function() set_theme_and_save("nightfox") end, { desc = "Nightfox Theme" })
map("n", "<leader>tk", function() set_theme_and_save("kanagawa") end, { desc = "Kanagawa Theme" })
map("n", "<leader>tr", function() set_theme_and_save("rose-pine") end, { desc = "Rose Pine Theme" })
map("n", "<leader>tp", function() set_theme_and_save("monokai-pro") end, { desc = "Monokai Pro Theme" })
map("n", "<leader>ts", function() set_theme_and_save("sonokai") end, { desc = "Sonokai Theme" })
map("n", "<leader>te", function() set_theme_and_save("edge") end, { desc = "Edge Theme" })
map("n", "<leader>t.", function() set_theme_and_save("oceanicnext") end, { desc = "Oceanic Next Theme" })
map("n", "<leader>ta", function() set_theme_and_save("palenight") end, { desc = "Palenight Theme" })
map("n", "<leader>tn", function() set_theme_and_save("nord") end, { desc = "Nord Theme" })
map("n", "<leader>tv", function() set_theme_and_save("everforest") end, { desc = "Everforest Theme" })
map("n", "<leader>td", function() set_theme_and_save("doom-one") end, { desc = "Doom One Theme" })
map("n", "<leader>tx", function() set_theme_and_save("carbonfox") end, { desc = "Carbonfox Theme" })
map("n", "<leader>tz", function() set_theme_and_save("oxocarbon") end, { desc = "Oxocarbon Theme" })
map("n", "<leader>tl", function() set_theme_and_save("melange") end, { desc = "Melange Theme" })

-- =============================================================================
-- 📝 KEYMAP SUMMARY
-- =============================================================================
-- Space + e  -> Explorer (Neotree)
-- Space + E  -> Find Files (Telescope)
-- Space + q  -> Close Window/Split
-- Space + Q  -> Force Close Window
-- Space + wq -> Save and Close
-- Space + sv -> Vertical Split
-- Space + sh -> Horizontal Split
-- Space + sc -> Close Split
-- Space + so -> Close Other Splits
-- Space + =  -> Equalize Windows
-- Ctrl + h/j/k/l -> Navigate between windows
-- Ctrl + Arrow Keys -> Resize windows
-- =============================================================================
