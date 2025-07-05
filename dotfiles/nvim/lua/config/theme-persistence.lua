-- Theme Persistence System
-- Saves and restores the selected theme between sessions

local M = {}

-- Path for theme persistence file
local theme_file = vim.fn.stdpath("data") .. "/current_theme.txt"

-- Available themes
local themes = {
  "tokyonight",
  "catppuccin", 
  "gruvbox",
  "dracula",
  "onedark",
  "material",
  "nightfox",
  "kanagawa",
  "rose-pine",
  "monokai-pro",
  "sonokai",
  "edge",
  "oceanicnext",
  "palenight",
  "nord",
  "everforest",
  "doom-one",
  "carbonfox",
  "oxocarbon",
  "melange",
  "modus-vivendi",
  "one",
  "papercolor",
}

-- Function to save current theme to file
function M.save_theme(theme_name)
  if vim.tbl_contains(themes, theme_name) then
    local file = io.open(theme_file, "w")
    if file then
      file:write(theme_name)
      file:close()
      vim.notify("Theme saved: " .. theme_name, vim.log.levels.INFO)
    else
      vim.notify("Could not save theme to file", vim.log.levels.ERROR)
    end
  end
end

-- Function to load theme from file
function M.load_theme()
  local file = io.open(theme_file, "r")
  if file then
    local saved_theme = file:read("*line")
    file:close()
    
    if saved_theme and vim.tbl_contains(themes, saved_theme) then
      vim.cmd.colorscheme(saved_theme)
      vim.notify("Theme restored: " .. saved_theme, vim.log.levels.INFO)
      return saved_theme
    end
  end
  
  -- Default theme if no saved theme or invalid theme
  vim.cmd.colorscheme("tokyonight")
  vim.notify("Using default theme: tokyonight", vim.log.levels.INFO)
  return "tokyonight"
end

-- Function to get current theme from file
function M.get_current_theme()
  local file = io.open(theme_file, "r")
  if file then
    local saved_theme = file:read("*line")
    file:close()
    
    if saved_theme and vim.tbl_contains(themes, saved_theme) then
      return saved_theme
    end
  end
  return "tokyonight" -- default
end

-- Function to list all themes with current indicator
function M.list_themes()
  local current = M.get_current_theme()
  local theme_list = {}
  
  for _, theme in ipairs(themes) do
    local indicator = (theme == current) and " ✓" or ""
    table.insert(theme_list, theme .. indicator)
  end
  
  return theme_list
end

-- Function to show theme status
function M.show_theme_status()
  local current = M.get_current_theme()
  local status_text = "Current theme: " .. current
  
  -- Check if theme file exists
  local file = io.open(theme_file, "r")
  if file then
    file:close()
    status_text = status_text .. " (saved)"
  else
    status_text = status_text .. " (not saved)"
  end
  
  vim.notify(status_text, vim.log.levels.INFO, {
    title = "Theme Status",
    timeout = 3000,
  })
end

-- Load theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    M.load_theme()
  end,
  priority = 1000,
})

return M 