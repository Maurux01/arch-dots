-- Theme integration test file
-- This file helps verify that all themes work properly with the current setup

local M = {}

-- List of all available themes
local themes = {
  "catppuccin",
  "tokyonight", 
  "gruvbox",
  "dracula",
  "kanagawa",
  "onedarkpro",
  "rose-pine",
  "nightfox",
  "oxocarbon",
}

-- Test function to verify theme loading
function M.test_theme(theme_name)
  local success, err = pcall(function()
    vim.cmd.colorscheme(theme_name)
  end)
  
  if success then
    print("✓ Theme '" .. theme_name .. "' loaded successfully")
    return true
  else
    print("✗ Theme '" .. theme_name .. "' failed to load: " .. tostring(err))
    return false
  end
end

-- Test all themes
function M.test_all_themes()
  print("Testing all themes...")
  local success_count = 0
  local total_count = #themes
  
  for _, theme in ipairs(themes) do
    if M.test_theme(theme) then
      success_count = success_count + 1
    end
    -- Small delay to see the theme change
    vim.wait(100)
  end
  
  print(string.format("Theme test complete: %d/%d themes working", success_count, total_count))
  return success_count == total_count
end

-- Test theme toggle functionality
function M.test_theme_toggle()
  print("Testing theme toggle functionality...")
  
  local theme_toggle = require("config.theme-toggle")
  
  -- Test set function
  for _, theme in ipairs(themes) do
    local success, err = pcall(function()
      theme_toggle.set(theme)
    end)
    
    if success then
      print("✓ Theme toggle set('" .. theme .. "') works")
    else
      print("✗ Theme toggle set('" .. theme .. "') failed: " .. tostring(err))
    end
  end
  
  -- Test next/prev functions
  local success, err = pcall(function()
    theme_toggle.next()
    theme_toggle.prev()
  end)
  
  if success then
    print("✓ Theme toggle next/prev functions work")
  else
    print("✗ Theme toggle next/prev functions failed: " .. tostring(err))
  end
end

-- Test which-key integration
function M.test_which_key_integration()
  print("Testing which-key theme integration...")
  
  -- Check if which-key is loaded
  local success, which_key = pcall(require, "which-key")
  
  if success then
    print("✓ Which-key is loaded")
    
    -- Test if theme keybindings are registered
    local registered = which_key.get_mappings()
    local theme_keys_found = 0
    
    for key, mapping in pairs(registered) do
      if key:match("^u[1-9]$") or key == "ut" or key == "un" or key == "up" or key == "ul" then
        theme_keys_found = theme_keys_found + 1
      end
    end
    
    print(string.format("✓ Found %d theme-related keybindings", theme_keys_found))
  else
    print("✗ Which-key not loaded: " .. tostring(which_key))
  end
end

-- Run comprehensive test
function M.run_comprehensive_test()
  print("=== Neovim Theme Integration Test ===")
  print("")
  
  M.test_all_themes()
  print("")
  
  M.test_theme_toggle()
  print("")
  
  M.test_which_key_integration()
  print("")
  
  print("=== Test Complete ===")
end

-- Command to run the test
vim.api.nvim_create_user_command("ThemeTest", M.run_comprehensive_test, {})

return M 