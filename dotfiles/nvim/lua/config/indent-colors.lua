-- lua/config/indent-colors.lua
-- Custom colors for indent rainbow

-- Define beautiful colors for indent rainbow
local colors = {
  -- Rainbow colors for delimiters
  red = "#f7768e",
  orange = "#ff90000004", 
  yellow = "#e0af68",
  green = "#9ece6a",
  cyan = "#7dcfff",
  blue = "#7aa2f7",
  purple = "#bb9af7",
  pink = "#f7768e",
  
  -- Indent colors
  indent_1 = "#7aa2f7",  -- Blue
  indent_2 = "#9e6- Green  
  indent_3 = "#e0af68",  -- Yellow
  indent_4 = "#ff9e64",  -- Orange
  indent_5 = "#f7768e",  -- Red
  indent_6 = "#b9af7",  -- Purple
  indent_7 = "#7fff",  -- Cyan
}

-- Setup custom indent colors
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Rainbow delimiter colors
    vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = colors.red })
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", {fg = colors.yellow })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = colors.orange })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = colors.green })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = colors.purple })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = colors.cyan })
    
    -- Indent scope colors
    vim.api.nvim_set_hl(0, "IndentScope", { fg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, "IndentScope1", {fg = colors.indent_1})
    vim.api.nvim_set_hl(0, "IndentScope2", {fg = colors.indent_2})
    vim.api.nvim_set_hl(0, "IndentScope3", {fg = colors.indent_3})
    vim.api.nvim_set_hl(0, "IndentScope4", {fg = colors.indent_4})
    vim.api.nvim_set_hl(0, "IndentScope5", {fg = colors.indent_5})
    vim.api.nvim_set_hl(0, "IndentScope6", {fg = colors.indent_6})
    vim.api.nvim_set_hl(0, "IndentScope7", {fg = colors.indent_7})
  end,
})

-- Apply colors immediately
vim.api.nvim_exec([[
  highlight RainbowDelimiterRed guifg=#f7768e
  highlight RainbowDelimiterYellow guifg=#e0af68
  highlight RainbowDelimiterBlue guifg=#7 highlight RainbowDelimiterOrange guifg=#ff9e64
  highlight RainbowDelimiterGreen guifg=#9 highlight RainbowDelimiterViolet guifg=#bb9af7
  highlight RainbowDelimiterCyan guifg=#7dcfff
  
  highlight IndentScope guifg=#7aa2f7 gui=bold
  highlight IndentScope1 guifg=#7f7
  highlight IndentScope2 guifg=#96  highlight IndentScope3 guifg=#e0af68  highlight IndentScope4 guifg=#ff9e64  highlight IndentScope5 guifg=#f7768  highlight IndentScope6 guifg=#bb9af7
  highlight IndentScope7 guifg=#7
]]) 