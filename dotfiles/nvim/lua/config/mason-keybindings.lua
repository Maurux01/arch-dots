-- Mason keybindings configuration
-- This file contains all Mason-related keybindings

local M = {}

-- Mason keybindings
M.mason_keybindings = {
    name = "Mason",
    m = { "<cmd>Mason<cr>", "Open Mason" },
    i = { "<cmd>MasonInstall<cr>", "Install package" },
    u = { "<cmd>MasonUninstall<cr>", "Uninstall package" },
    r = { "<cmd>MasonUninstallAll<cr>", "Uninstall all" },
    l = { "<cmd>MasonLog<cr>", "Show Mason log" },
    U = { "<cmd>MasonUpdate<cr>", "Update all packages" },
    c = { "<cmd>MasonCheckHealth<cr>", "Check health" },
}

-- Enhanced LSP keybindings with Mason integration
M.enhanced_lsp_keybindings = {
    name = "LSP",
    g = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show line diagnostics" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic" },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format buffer" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol" },
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type definition" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    w = { "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "Workspace symbol" },
}

return M 