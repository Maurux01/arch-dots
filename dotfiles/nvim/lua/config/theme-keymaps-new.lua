-- Theme switching keymaps with persistence
-- These keymaps allow you to quickly switch between dark themes and save your choice

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

local current_theme_index = 1

-- Simple theme persistence
local theme_file = vim.fn.stdpath("data") .. "/current_theme.txt"

local function save_theme(theme_name)
  if vim.tbl_contains(themes, theme_name) then
    local file = io.open(theme_file, "w")
    if file then
      file:write(theme_name)
      file:close()
      vim.notify("Theme saved: " .. theme_name, vim.log.levels.INFO)
    end
  end
end

local function get_current_theme()
  local file = io.open(theme_file, "r")
  if file then
    local saved_theme = file:read("*line")
    file:close()
    if saved_theme and vim.tbl_contains(themes, saved_theme) then
      return saved_theme
    end
  end
  return "tokyonight"
end

-- Function to cycle through themes
local function cycle_theme()
  current_theme_index = current_theme_index + 1
  if current_theme_index > #themes then
    current_theme_index = 1
  end
  
  local theme_name = themes[current_theme_index]
  vim.cmd.colorscheme(theme_name)
  save_theme(theme_name)
  vim.notify("Switched to theme: " .. theme_name .. " (saved)", vim.log.levels.INFO)
end

-- Function to set specific theme
local function set_theme(theme_name)
  if vim.tbl_contains(themes, theme_name) then
    vim.cmd.colorscheme(theme_name)
    current_theme_index = tbl_index(themes, theme_name) or 1
    save_theme(theme_name)
    vim.notify("Switched to theme: " .. theme_name .. " (saved)", vim.log.levels.INFO)
  else
    vim.notify("Theme not found: " .. theme_name, vim.log.levels.ERROR)
  end
end

-- Function to show theme status
local function show_theme_status()
  local current = get_current_theme()
  local status_text = "Current theme: " .. current
  
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

-- Function to list themes
local function list_themes()
  local current = get_current_theme()
  local theme_list = {}
  
  for _, theme in ipairs(themes) do
    local indicator = (theme == current) and " ✓" or ""
    table.insert(theme_list, theme .. indicator)
  end
  
  local message = "Available themes:\n" .. table.concat(theme_list, "\n")
  vim.notify(message, vim.log.levels.INFO, {
    title = "Theme List",
    timeout = 5000,
  })
end

-- Set up keymaps
vim.keymap.set("n", "<leader>tn", cycle_theme, { desc = "Next Theme (saved)" })

-- Original themes
vim.keymap.set("n", "<leader>tt", function() set_theme("tokyonight") end, { desc = "Tokyo Night (saved)" })
vim.keymap.set("n", "<leader>tc", function() set_theme("catppuccin") end, { desc = "Catppuccin (saved)" })
vim.keymap.set("n", "<leader>tg", function() set_theme("gruvbox") end, { desc = "Gruvbox (saved)" })
vim.keymap.set("n", "<leader>td", function() set_theme("dracula") end, { desc = "Dracula (saved)" })
vim.keymap.set("n", "<leader>to", function() set_theme("onedark") end, { desc = "One Dark (saved)" })

-- New themes
vim.keymap.set("n", "<leader>tm", function() set_theme("material") end, { desc = "Material (saved)" })
vim.keymap.set("n", "<leader>tf", function() set_theme("nightfox") end, { desc = "Nightfox (saved)" })
vim.keymap.set("n", "<leader>tk", function() set_theme("kanagawa") end, { desc = "Kanagawa (saved)" })
vim.keymap.set("n", "<leader>tr", function() set_theme("rose-pine") end, { desc = "Rose Pine (saved)" })
vim.keymap.set("n", "<leader>tp", function() set_theme("monokai-pro") end, { desc = "Monokai Pro (saved)" })
vim.keymap.set("n", "<leader>ts", function() set_theme("sonokai") end, { desc = "Sonokai (saved)" })
vim.keymap.set("n", "<leader>te", function() set_theme("edge") end, { desc = "Edge (saved)" })
vim.keymap.set("n", "<leader>t.", function() set_theme("oceanicnext") end, { desc = "Oceanic Next (saved)" })
vim.keymap.set("n", "<leader>ta", function() set_theme("palenight") end, { desc = "Palenight (saved)" })

-- Additional themes with excellent syntax highlighting
vim.keymap.set("n", "<leader>tn", function() set_theme("nord") end, { desc = "Nord (saved)" })
vim.keymap.set("n", "<leader>tv", function() set_theme("everforest") end, { desc = "Everforest (saved)" })
vim.keymap.set("n", "<leader>td", function() set_theme("doom-one") end, { desc = "Doom One (saved)" })
vim.keymap.set("n", "<leader>tx", function() set_theme("carbonfox") end, { desc = "Carbonfox (saved)" })
vim.keymap.set("n", "<leader>tx", function() set_theme("oxocarbon") end, { desc = "Oxocarbon (saved)" })
vim.keymap.set("n", "<leader>tl", function() set_theme("melange") end, { desc = "Melange (saved)" })
vim.keymap.set("n", "<leader>tm", function() set_theme("modus-vivendi") end, { desc = "Modus Vivendi (saved)" })
vim.keymap.set("n", "<leader>to", function() set_theme("one") end, { desc = "Vim One (saved)" })
vim.keymap.set("n", "<leader>tp", function() set_theme("papercolor") end, { desc = "Papercolor (saved)" })

-- Additional theme management keymaps
vim.keymap.set("n", "<leader>t?", show_theme_status, { desc = "Show Theme Status" })
vim.keymap.set("n", "<leader>tl", list_themes, { desc = "List Themes" })

-- Initialize current theme index based on saved theme
local function init_theme_index()
  local saved_theme = get_current_theme()
  current_theme_index = tbl_index(themes, saved_theme) or 1
end

-- Initialize on startup
init_theme_index()

-- Load theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local saved_theme = get_current_theme()
    vim.cmd.colorscheme(saved_theme)
  end,
  priority = 1000,
})

local function tbl_index(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end
  return nil
end 