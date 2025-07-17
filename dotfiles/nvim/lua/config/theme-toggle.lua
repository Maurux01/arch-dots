-- lua/config/theme-toggle.lua
-- Sistema de cambio de temas oscuros

local themes = {
  "catppuccin",
  "tokyonight",
  "gruvbox",
  "dracula",
  "nord",
  "everforest",
  "kanagawa",
  "onedarkpro",
  "rose-pine",
  "nightfox",
  "oxocarbon",
  "monokai-pro",
  "ayu",
}

local current = 1
local function set_theme(idx)
  current = idx
  vim.cmd.colorscheme(themes[current])
  -- Guardar el tema actual en un archivo
  vim.fn.writefile({themes[current]}, vim.fn.stdpath("config") .. "/current_theme.txt")
end

local function next_theme()
  set_theme((current % #themes) + 1)
end

local function prev_theme()
  set_theme((current - 2) % #themes + 1)
end

local function pick_theme()
  vim.ui.select(themes, { prompt = "Seleccionar tema oscuro:" }, function(choice)
    if choice then
      for i, v in ipairs(themes) do
        if v == choice then 
          set_theme(i) 
          break 
        end
      end
    end
  end)
end

-- Cargar el último tema usado
local function load_last_theme()
  local theme_file = vim.fn.stdpath("config") .. "/current_theme.txt"
  if vim.fn.filereadable(theme_file) == 1 then
    local theme = vim.fn.readfile(theme_file)[1]
    for i, v in ipairs(themes) do
      if v == theme then
        current = i
        break
      end
    end
  end
  set_theme(current)
end

-- Comandos de usuario
vim.api.nvim_create_user_command("ThemeNext", next_theme, {})
vim.api.nvim_create_user_command("ThemePrev", prev_theme, {})
vim.api.nvim_create_user_command("ThemePick", pick_theme, {})
vim.api.nvim_create_user_command("ThemeLoad", load_last_theme, {})

-- Cargar tema al inicio
vim.api.nvim_create_autocmd("VimEnter", {
  callback = load_last_theme,
  once = true,
})

return {
  next = next_theme,
  prev = prev_theme,
  pick = pick_theme,
  load = load_last_theme,
  themes = themes,
} 