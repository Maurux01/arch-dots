-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- NVimX options mejoradas
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.mouse = "a"

-- Font configuration for GUI
if vim.fn.has("gui_running") == 1 then
    vim.opt.guifont = "JetBrains Mono Nerd Font:h12"
    -- Alternative fonts (uncomment to use):
    -- vim.opt.guifont = "FiraCode Nerd Font:h12"
    -- vim.opt.guifont = "Cascadia Code Nerd Font:h12"
    -- vim.opt.guifont = "Hack Nerd Font:h12"
    -- vim.opt.guifont = "Source Code Pro Nerd Font:h12"
    -- vim.opt.guifont = "Ubuntu Mono Nerd Font:h12"
end

-- Configuraciones adicionales
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·" }
vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 10
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10
vim.opt.redrawtime = 1500
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.joinspaces = false
vim.opt.showmode = false
vim.opt.shortmess = "filnxtToOF"
vim.opt.ruler = false
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.showcmd = false
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore = "*.o,*.obj,*.dylib,*.bin,*.dll,*.exe"
vim.opt.wildignorecase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.equalalways = false
vim.opt.diffopt = "filler,iwhite,internal,algorithm:patience"
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.viewoptions = "folds,cursor,curdir,slash,unix"
vim.opt.virtualedit = "block"
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"
vim.opt.iskeyword = vim.opt.iskeyword + "-"
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2,min:20"
vim.opt.showbreak = "NONE"
vim.opt.inccommand = "nosplit"
vim.opt.smoothscroll = true
