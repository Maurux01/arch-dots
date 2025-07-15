-- Theme Switcher Module
-- Provides theme switching with error handling and notifications
local M = {}

local themes = {
  "tokyonight",
  "catppuccin", 
  "gruvbox",
  "dracula",
  "habamax",
  "monokai-pro",
  "github_dark",
  "github_light",
  "github_dimmed",
  "github_dark_default",
  "github_dark_colorblind",
  "github_dark_high_contrast",
  "github_dark_tritanopia",
  "github_light_default",
  "github_light_colorblind",
  "github_light_high_contrast",
  "github_light_tritanopia",
}

local current_theme_index = 1
local theme_file = vim.fn.stdpath('config') .. '/current_theme.txt'

-- Save the current theme to a file
local function save_theme(theme_name)
  local f = io.open(theme_file, 'w')
  if f then
    f:write(theme_name)
    f:close()
  end
end

-- Load the last used theme from file
local function load_theme()
  local f = io.open(theme_file, 'r')
  if f then
    local theme = f:read('*l')
    f:close()
    return theme
  end
  return nil
end

-- Try to set a theme by name, fallback if not available
local function set_theme_by_name(theme_name)
  for i, theme in ipairs(themes) do
    if theme == theme_name then
      current_theme_index = i
      local success = pcall(function()
        vim.cmd('colorscheme ' .. theme_name)
      end)
      if not success then
        -- Fallback to first available theme
        vim.cmd('colorscheme ' .. themes[1])
        current_theme_index = 1
        save_theme(themes[1])
      end
      return success
    end
  end
  return false
end

-- Load theme on startup with error handling
local loaded_theme = load_theme()
if loaded_theme then
  local success = set_theme_by_name(loaded_theme)
  if not success then
    vim.notify('Theme not available: ' .. loaded_theme .. ', fallback to: ' .. themes[1], vim.log.levels.WARN)
    vim.cmd('colorscheme ' .. themes[1])
    current_theme_index = 1
    save_theme(themes[1])
  end
else
  vim.cmd('colorscheme ' .. themes[1])
  current_theme_index = 1
  save_theme(themes[1])
end

-- Toggle to the next theme
function M.toggle()
  current_theme_index = current_theme_index % #themes + 1
  local new_theme = themes[current_theme_index]
  local success = pcall(function()
    vim.cmd('colorscheme ' .. new_theme)
  end)
  if success then
    save_theme(new_theme)
    vim.notify('Theme changed to: ' .. new_theme, vim.log.levels.INFO, {
      title = 'Theme Switcher',
      timeout = 2000,
    })
  else
    vim.notify('Theme not available: ' .. new_theme, vim.log.levels.WARN, {
      title = 'Theme Switcher',
      timeout = 2000,
    })
  end
end

-- Go to the next theme
function M.next()
  M.toggle()
end

-- Go to the previous theme
function M.prev()
  current_theme_index = current_theme_index - 1
  if current_theme_index < 1 then
    current_theme_index = #themes
  end
  local new_theme = themes[current_theme_index]
  local success = pcall(function()
    vim.cmd('colorscheme ' .. new_theme)
  end)
  if success then
    save_theme(new_theme)
    vim.notify('Theme: ' .. new_theme, vim.log.levels.INFO, {
      title = 'Theme Switcher',
      timeout = 1500,
    })
  else
    vim.notify('Theme not available: ' .. new_theme, vim.log.levels.WARN, {
      title = 'Theme Switcher',
      timeout = 1500,
    })
  end
end

-- Set a specific theme by name
function M.set(theme_name)
  for i, theme in ipairs(themes) do
    if theme == theme_name then
      current_theme_index = i
      local success = pcall(function()
        vim.cmd('colorscheme ' .. theme_name)
      end)
      if success then
        save_theme(theme_name)
        vim.notify('Theme set to: ' .. theme_name, vim.log.levels.INFO, {
          title = 'Theme Switcher',
          timeout = 1500,
        })
      else
        vim.notify('Theme not available: ' .. theme_name, vim.log.levels.WARN, {
          title = 'Theme Switcher',
          timeout = 2000,
        })
      end
      return
    end
  end
  vim.notify('Theme not found: ' .. theme_name, vim.log.levels.WARN, {
    title = 'Theme Switcher',
    timeout = 2000,
  })
end

-- Make the module available globally
_G["theme-switcher"] = M

return M 