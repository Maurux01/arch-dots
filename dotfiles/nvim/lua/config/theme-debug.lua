-- Theme Debug and Diagnostics
-- This file helps diagnose theme keybind issues

-- Debug function to check if keymaps are set
local function debug_keymaps()
  local keymaps = vim.api.nvim_get_keymap('n')
  local theme_keymaps = {}
  
  for _, keymap in ipairs(keymaps) do
    if keymap.lhs:find("leader") and keymap.lhs:find("t") then
      table.insert(theme_keymaps, {
        lhs = keymap.lhs,
        rhs = keymap.rhs,
        desc = keymap.desc or "No description"
      })
    end
  end
  
  if #theme_keymaps == 0 then
    vim.notify("No theme keymaps found!", vim.log.levels.ERROR)
  else
    local message = "Found theme keymaps:\n"
    for _, keymap in ipairs(theme_keymaps) do
      message = message .. string.format("  %s -> %s (%s)\n", keymap.lhs, keymap.rhs, keymap.desc)
    end
    vim.notify(message, vim.log.levels.INFO, {
      title = "Theme Keymaps Debug",
      timeout = 8000,
    })
  end
end

-- Test if leader key is defined
local function check_leader()
  local leader = vim.g.mapleader
  if leader then
    vim.notify("Leader key is: '" .. leader .. "'", vim.log.levels.INFO)
  else
    vim.notify("Leader key is NOT set!", vim.log.levels.ERROR)
  end
end

-- Test theme change directly
local function test_direct_theme()
  vim.notify("Testing direct theme change...", vim.log.levels.INFO)
  local success, error = pcall(function()
    vim.cmd.colorscheme("tokyonight")
  end)
  
  if success then
    vim.notify("Direct theme change successful", vim.log.levels.INFO)
  else
    vim.notify("Direct theme change failed: " .. tostring(error), vim.log.levels.ERROR)
  end
end

-- Set up debug keymaps
vim.keymap.set("n", "<leader>debug", debug_keymaps, { desc = "Debug Theme Keymaps" })
vim.keymap.set("n", "<leader>leader", check_leader, { desc = "Check Leader Key" })
vim.keymap.set("n", "<leader>direct", test_direct_theme, { desc = "Test Direct Theme Change" })

-- Auto-run debug on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      vim.notify("Theme debug loaded. Use <leader>debug to check keymaps", vim.log.levels.INFO)
    end, 1000)
  end,
  once = true,
}) 