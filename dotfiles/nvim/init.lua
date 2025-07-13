-- NVimX - Neovim config by Maurux01
-- https://github.com/Maurux01/NVimX

require("config.options")
require("config.keymaps")
require("config.lazy")

-- Load LSP configuration
local lsp = require("config.lsp")
lsp.setup()

local theme_persistence = require("config.theme-persistence")
theme_persistence.load_theme()
