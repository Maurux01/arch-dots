-- AI Assistant Keymaps
-- These keymaps provide easy access to AI features

-- Copilot keymaps (Insert mode)
vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", { desc = "Copilot Next Suggestion" })
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { desc = "Copilot Previous Suggestion" })
vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept)", { desc = "Copilot Accept Suggestion" })
vim.keymap.set("i", "<C-h>", "<Plug>(copilot-dismiss)", { desc = "Copilot Dismiss Suggestion" })

-- Copilot keymaps (Normal mode)
vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<cr>", { desc = "Copilot Panel" })
vim.keymap.set("n", "<leader>cs", "<cmd>Copilot status<cr>", { desc = "Copilot Status" })

-- Copilot Chat keymaps
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Copilot Chat" })
vim.keymap.set("n", "<leader>ct", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot Chat" })

-- Codeium keymaps (if available)
vim.keymap.set("i", "<C-;>", function()
  if pcall(require, "codeium") then
    require("codeium").Accept()
  end
end, { desc = "Codeium Accept" })

-- AI Helpers
vim.keymap.set("n", "<leader>ai", function()
  -- Show AI help
  local help_text = [[
🤖 AI Assistant Keymaps:

Copilot (Insert Mode):
  <C-j> - Next suggestion
  <C-k> - Previous suggestion  
  <C-l> - Accept suggestion
  <C-h> - Dismiss suggestion

Copilot (Normal Mode):
  <leader>cp - Open panel
  <leader>cs - Show status

Copilot Chat:
  <leader>cc - Open chat
  <leader>ct - Toggle chat

Codeium:
  <C-;> - Accept suggestion
  ]]
  
  vim.notify(help_text, vim.log.levels.INFO, {
    title = "AI Keymaps",
    timeout = 10000,
  })
end, { desc = "Show AI Keymaps Help" })

local function tbl_index(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end
  return nil
end 