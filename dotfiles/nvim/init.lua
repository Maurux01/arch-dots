-- Modern IDE Neovim Configuration
-- Enhanced with dashboard, themes, autocompletion, and modern features

-- Bootstrap lazy.nvim and load configurations
require("config.lazy")
require("config.theme-toggle")
require("config.capture-utils")
require("config.telescope")
require("config.image-support")
require("config.autocmds")
require("config.performance")
require("config.cursor-highlights")

-- Enhanced startup experience
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only show dashboard if no files were opened
    if vim.fn.argc() == 0 then
      -- Set up modern IDE appearance
      vim.defer_fn(function()
        -- Enhanced welcome message
        print("🚀 Welcome to Modern Neovim IDE!")
        print("📁 Use <leader>f to find files")
        print("🔍 Use <leader>g to search in files")
        print("📋 Use <C-\\> to open terminal")
        print("🎨 Use <leader>1/2/3o switch themes")
        print("❓ Use <leader>? for help")
      end, 100)
    end
  end,
  nested = true,
})

-- Disable LazyVim's default dashboard in favor of alpha-nvim
vim.g.lazyvim_dashboard = false

-- Enhanced performance settings
vim.g.loaded_netrw = 1vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat =1.g.loaded_rrhelper = 1g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1m.g.loaded_vimball = 1m.g.loaded_vimballPlugin = 1vim.g.loaded_zip = 1g.loaded_zipPlugin = 1

-- Modern IDE features
vim.g.autoformat_enabled = true
vim.g.codelens_enabled = true
vim.g.inlay_hint_enabled = true

-- Enhanced status line
vim.g.lualine_theme =auto"

-- Better file type detection
vim.g.markdown_fenced_languages = {
  "html",
 javascript",
 typescript",
  css",
  scss",
 json,python",
 bash",
  "lua",
}

-- Enhanced completion settings
vim.g.completion_enable_auto_popup = 1vim.g.completion_matching_strategy_list = { "exact, substring", "fuzzy" }

-- Modern terminal integration
vim.g.terminal_color_0 = "#073642m.g.terminal_color_1 = "#dc322m.g.terminal_color_2 = "#85990m.g.terminal_color_3 = "#b5890m.g.terminal_color_4 = "#268bd2"
vim.g.terminal_color_5 = "#d33682m.g.terminal_color_6 = "#2aa198m.g.terminal_color_7 = "#eee8d5"
vim.g.terminal_color_8 = "#002b36m.g.terminal_color_9 = "#cb4b16m.g.terminal_color_10 = "#586e75m.g.terminal_color_11 = "#657b83m.g.terminal_color_12 = "#839496m.g.terminal_color_13 = "#6c71c4"
vim.g.terminal_color_14 = "#93a1a1"
vim.g.terminal_color_15f6e3

-- Enhanced autocommands for modern IDE experience
vim.api.nvim_create_autocmd(TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300  end,
})

-- Auto-save on focus lost
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~=then
      vim.cmd("silent write)   end
  end,
})

-- Enhanced file type specific settings
vim.api.nvim_create_autocmd("FileType, {
  pattern = { "javascript, ript", javascriptreact",typescriptreact" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType, {
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType, [object Object]  pattern = { c cppuda" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

-- Enhanced buffer management
vim.api.nvim_create_autocmd(BufWritePre", {
  callback = function()
    -- Auto-format on save if enabled
    if vim.g.autoformat_enabled then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- Modern IDE keybindings
vim.api.nvim_create_autocmd("User, {
  pattern = LazyVimKeymaps",
  callback = function()
    -- Additional modern IDE keybindings
    local map = vim.keymap.set
    
    -- Enhanced navigation
    map("n,<leader>w, cmd>w<CR>", { desc = Save file" })
    map("n,<leader>q, cmd>q<CR>, { desc =Quit" })
    map("n,<leader>Q,<cmd>qa!<CR>", [object Object] desc = "Quit all" })
    
    -- Enhanced window management
    map(n, "<leader>sv, <cmd>vsplit<CR>, { desc = Split vertically" })
    map(n, "<leader>sh,<cmd>split<CR>, { desc = Split horizontally" })
    map(n, "<leader>sc,<cmd>close<CR>, { desc = Close window" })
    
    -- Enhanced buffer management
    map(n, "<leader>bn", "<cmd>bn<CR>", { desc =Next buffer" })
    map(n, "<leader>bp", "<cmd>bp<CR>", { desc =Previous buffer" })
    map(n, "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })
    
    -- Enhanced theme switching
    map("n,<leader>1,<cmd>colorscheme tokyonight<CR>, { desc = Tokyo Night theme" })
    map("n,<leader>2,<cmd>colorscheme catppuccin<CR>,[object Object]desc = Catppuccin theme" })
    map("n,<leader>3,<cmd>colorscheme gruvbox<CR>", { desc = "Gruvbox theme" })
    
    -- Enhanced terminal shortcuts
    map(n, "<leader>tt",<cmd>ToggleTerm<CR>", { desc =Toggle terminal" })
    map(n, "<leader>tg",<cmd>GitTerm<CR>", { desc = Git terminal" })
    map(n, "<leader>tl",<cmd>LazyGit<CR>", { desc = LazyGit" })
    
    -- Enhanced search and replace
    map(n, <leader>sr", :%s/, { desc = "Search and replace" })
    map(n, <leader>sw,*Ncgn", { desc = Search word under cursor" })
  end,
})
