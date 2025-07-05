-- Simple theme test keybinds
-- This file tests if the theme keybinds are working

-- Test function to change theme
local function test_theme_change()
  vim.notify("Testing theme change...", vim.log.levels.INFO)
  vim.cmd.colorscheme("tokyonight")
  vim.notify("Theme changed to tokyonight", vim.log.levels.INFO)
end

-- Set up test keybinds
vim.keymap.set("n", "<leader>test", test_theme_change, { desc = "Test Theme Change" })

-- Simple theme cycling
local themes = {"tokyonight", "catppuccin", "gruvbox"}
local current = 1

local function simple_cycle()
  current = current + 1
  if current > #themes then
    current = 1
  end
  vim.cmd.colorscheme(themes[current])
  vim.notify("Theme: " .. themes[current], vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>cycle", simple_cycle, { desc = "Simple Theme Cycle" })

-- Test if leader key is working
vim.keymap.set("n", "<leader>check", function()
  vim.notify("Leader key is working!", vim.log.levels.INFO)
end, { desc = "Check Leader Key" }) 