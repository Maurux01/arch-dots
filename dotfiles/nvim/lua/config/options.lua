-- Enhanced options for modern IDE experience
-- Optimized for visual appeal and productivity

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Enhanced UI settings for modern IDE look
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "line"
opt.signcolumn = "yes:2"
opt.colorcolumn = "80,120"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.showbreak = "↪ "
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·", space = "·", eol = "↲" }

-- Enhanced search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.gdefault = true

-- Modern indentation settings
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.showmatch = true
opt.matchtime = 2

-- Enhanced file handling
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.hidden = true
opt.autoread = true
opt.autowrite = true
opt.autowriteall = true

-- Modern terminal settings
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3
opt.showtabline = 2
opt.winbar = "%=%m %f"

-- Enhanced behavior settings
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 10
opt.splitbelow = true
opt.splitright = true
opt.equalalways = false
opt.diffopt = "filler,iwhite,algorithm:patience"
opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

-- Performance optimizations
opt.synmaxcol = 240
opt.updatetime = 250
opt.timeoutlen = 30
opt.ttimeoutlen = 10
opt.redrawtime = 1500
-- opt.lazyredraw = false -- Disabled: causes issues with Noice plugin

-- Enhanced font settings for GUI
if vim.fn.has("gui_running") == 1 or vim.g.neovide or vim.g.goneovim then
  opt.guifont = "JetBrains Mono:h13"
end

-- Enhanced highlight groups for modern IDE appearance
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Enhanced cursor line
    vim.cmd([[hi CursorLine ctermbg=NONE guibg=NONE]])
    vim.cmd([[hi CursorLineNr ctermfg=Yellow guifg=Yellow gui=bold]])
    vim.cmd([[hi LineNr ctermfg=Gray guifg=Gray]])
    vim.cmd([[hi SignColumn ctermbg=NONE guibg=NONE]])
    
    -- Enhanced search highlighting
    vim.cmd([[hi Search ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black]])
    vim.cmd([[hi IncSearch ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black]])
    
    -- Enhanced visual selection
    vim.cmd([[hi Visual ctermbg=Blue guibg=Blue guifg=White]])
    vim.cmd([[hi VisualNOS ctermbg=Blue guibg=Blue guifg=White]])
    
    -- Enhanced status line
    vim.cmd([[hi StatusLine ctermbg=Blue ctermfg=White guibg=Blue guifg=White]])
    vim.cmd([[hi StatusLineNC ctermbg=Gray ctermfg=Black guibg=Gray guifg=Black]])
    
    -- Enhanced tab line
    vim.cmd([[hi TabLine ctermbg=Gray ctermfg=Black guibg=Gray guifg=Black]])
    vim.cmd([[hi TabLineSel ctermbg=Blue ctermfg=White guibg=Blue guifg=White]])
    vim.cmd([[hi TabLineFill ctermbg=Gray ctermfg=Black guibg=Gray guifg=Black]])
    
    -- Enhanced completion menu
    vim.cmd([[hi Pmenu ctermbg=Gray ctermfg=Black guibg=Gray guifg=Black]])
    vim.cmd([[hi PmenuSel ctermbg=Blue ctermfg=White guibg=Blue guifg=White]])
    vim.cmd([[hi PmenuSbar ctermbg=Gray guibg=Gray]])
    vim.cmd([[hi PmenuThumb ctermbg=DarkGray guibg=DarkGray]])
    
    -- Enhanced floating windows
    vim.cmd([[hi NormalFloat ctermbg=Gray guibg=Gray]])
    vim.cmd([[hi FloatBorder ctermbg=Gray ctermfg=Black guibg=Gray guifg=Black]])
    
    -- Enhanced special characters
    vim.cmd([[hi NonText ctermfg=Gray guifg=Gray]])
    vim.cmd([[hi SpecialKey ctermfg=Gray guifg=Gray]])
    
    -- Enhanced diff highlighting
    vim.cmd([[hi DiffAdd ctermbg=Green ctermfg=Black guibg=Green guifg=Black]])
    vim.cmd([[hi DiffChange ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black]])
    vim.cmd([[hi DiffDelete ctermbg=Red ctermfg=Black guibg=Red guifg=Black]])
    vim.cmd([[hi DiffText ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black]])
  end,
})

-- Enhanced window appearance
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Set window title
    vim.opt.title = true
    vim.opt.titlestring = "%<%F%=%([%[object Object]Tlist_Get_Tagname_By_Line()}]%)"
    
    -- Enhanced window appearance
    if vim.fn.has("gui_running") == 1 then
      vim.opt.guioptions = "egmrti"
    end
  end,
})

-- Enhanced file type specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    opt.wrap = true
    opt.linebreak = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "own" },
  callback = function()
    opt.spell = true
    opt.spelllang = "en_us"
  end,
})

-- Enhanced buffer settings
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
