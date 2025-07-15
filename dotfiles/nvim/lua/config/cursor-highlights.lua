-- lua/config/cursor-highlights.lua
-- Beautiful cursor highlights and colors

-- Define beautiful colors for cursor effects
local colors = {
  -- Primary colors
  blue = '#7aa2f7',
  cyan = '#7dcfff',
  green = '#9ece6a',
  purple = '#bb9af7',
  red = '#f7768e',
  orange = '#ff9e64',
  yellow = '#e0af68',
  pink = '#f7768e',
  
  -- Background colors
  bg = '#1a1b26',
  bg_alt = '#16161e',
  bg_light = '#24283b',
  
  -- Text colors
  fg = '#a9b1d6',
  fg_alt = '#7982a9',
  fg_dark = '#565a6e',
}

-- Setup cursor highlights
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Smooth cursor highlights
    vim.api.nvim_set_hl(0, "SmoothCursor", { 
      fg = colors.blue, 
      bg = colors.blue,
      bold = true,
    })
    
    -- Sparkle effect highlights
    vim.api.nvim_set_hl(0, "SmoothCursorSparkle", { 
      fg = colors.cyan, 
      bg = colors.bg,
      bold = true,
      sp = colors.cyan,
    })
    
    -- Fly mode highlights
    vim.api.nvim_set_hl(0, "SmoothCursorFly", { 
      fg = colors.purple, 
      bg = colors.bg,
      bold = true,
      sp = colors.purple,
    })
    
    -- Cursor line highlights
    vim.api.nvim_set_hl(0, "CursorLine", { 
      bg = colors.bg_light,
      sp = colors.blue,
    })
    
    -- Cursor word highlights
    vim.api.nvim_set_hl(0, "CursorWord", { 
      bg = colors.bg_light,
      bold = true,
      underline = true,
      sp = colors.blue,
    })
    
    -- Search highlights
    vim.api.nvim_set_hl(0, "Search", { 
      fg = colors.bg, 
      bg = colors.yellow,
      bold = true,
    })
    
    -- Visual mode highlights
    vim.api.nvim_set_hl(0, "Visual", { 
      bg = colors.bg_light,
      sp = colors.purple,
    })
    
    -- Indent scope highlights
    vim.api.nvim_set_hl(0, "IndentScope", { 
      fg = colors.fg_alt,
      sp = colors.fg_alt,
    })
    
    -- Function highlights for scope
    vim.api.nvim_set_hl(0, "Function", { 
      fg = colors.cyan,
      bold = true,
    })
    
    -- Hlslens virtual highlights
    vim.api.nvim_set_hl(0, "HlslensVirtual", { 
      fg = colors.yellow,
      bg = colors.bg,
      bold = true,
    })
  end,
})

-- Apply highlights immediately
vim.api.nvim_exec([[
  highlight SmoothCursor guifg=#7aa2f7 guibg=#7aa2f7 gui=bold
  highlight SmoothCursorSparkle guifg=#7dcfff guibg=#1a1b26 gui=bold guisp=#7dcfff
  highlight SmoothCursorFly guifg=#bb9af7 guibg=#1a1b26 gui=bold guisp=#bb9af7
  highlight CursorLine guibg=#24283b guisp=#7aa2f7
  highlight CursorWord guibg=#24283b gui=bold,underline guisp=#7aa2f7
  highlight Search guifg=#1a1b26 guibg=#e0af68 gui=bold
  highlight Visual guibg=#24283b guisp=#bb9af7
  highlight IndentScope guifg=#7982a9 guisp=#7982a9
  highlight Function guifg=#7dcfff gui=bold
  highlight HlslensVirtual guifg=#e0af68 guibg=#1a1b26 gui=bold
]], false)

-- Cursor animations configuration
vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Smooth cursor movement settings
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300

-- Disable cursor blinking in some cases for better animations
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
  end,
}) 