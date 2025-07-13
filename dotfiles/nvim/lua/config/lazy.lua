local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- NVimX LazyVim plugin loader
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.custom" },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  install = { 
    colorscheme = { "tokyonight", "catppuccin", "gruvbox" },
    missing = true,
  },
  checker = { 
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = " ",
      config = " ",
      event = " ",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = " ",
      loaded = " ",
      not_loaded = " ",
      plugin = " ",
      runtime = " ",
      require = " ",
      source = " ",
      start = " ",
      task = " ",
      list = {
        " ",
        " ",
        " ",
        " ",
      },
    },
  },
})
