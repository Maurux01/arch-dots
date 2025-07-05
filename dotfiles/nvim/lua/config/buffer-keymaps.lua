-- Buffer Navigation Keymaps
-- Comprehensive buffer management and navigation

-- ============================================================================
-- BASIC BUFFER NAVIGATION (LazyVim Defaults)
-- ============================================================================

-- These are already provided by LazyVim, but documented here for reference:
-- <leader>bb - Switch to other buffer
-- <leader>` - Switch to other buffer
-- <leader><tab> - Switch to other buffer
-- <leader>bd - Close buffer
-- <leader>bD - Close buffer (force)

-- ============================================================================
-- ENHANCED BUFFER NAVIGATION
-- ============================================================================

-- Buffer cycling with Tab
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- Also work in insert mode for convenience
vim.keymap.set("i", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("i", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- Buffer navigation with numbers
vim.keymap.set("n", "<leader>1", "<cmd>buffer 1<cr>", { desc = "Buffer 1" })
vim.keymap.set("n", "<leader>2", "<cmd>buffer 2<cr>", { desc = "Buffer 2" })
vim.keymap.set("n", "<leader>3", "<cmd>buffer 3<cr>", { desc = "Buffer 3" })
vim.keymap.set("n", "<leader>4", "<cmd>buffer 4<cr>", { desc = "Buffer 4" })
vim.keymap.set("n", "<leader>5", "<cmd>buffer 5<cr>", { desc = "Buffer 5" })
vim.keymap.set("n", "<leader>6", "<cmd>buffer 6<cr>", { desc = "Buffer 6" })
vim.keymap.set("n", "<leader>7", "<cmd>buffer 7<cr>", { desc = "Buffer 7" })
vim.keymap.set("n", "<leader>8", "<cmd>buffer 8<cr>", { desc = "Buffer 8" })
vim.keymap.set("n", "<leader>9", "<cmd>buffer 9<cr>", { desc = "Buffer 9" })
vim.keymap.set("n", "<leader>0", "<cmd>buffer 10<cr>", { desc = "Buffer 10" })

-- Buffer management
vim.keymap.set("n", "<leader>bl", "<cmd>buffers<cr>", { desc = "List Buffers" })
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New Buffer" })
vim.keymap.set("n", "<leader>bs", "<cmd>w<cr>", { desc = "Save Buffer" })
vim.keymap.set("n", "<leader>ba", "<cmd>wall<cr>", { desc = "Save All Buffers" })

-- Close buffers
vim.keymap.set("n", "<leader>bc", "<cmd>close<cr>", { desc = "Close Window" })
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Close Other Buffers" })

-- ============================================================================
-- BUFFER PICKER (Telescope)
-- ============================================================================

-- Buffer picker with Telescope
vim.keymap.set("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Find Buffer" })

-- ============================================================================
-- BUFFER HELP
-- ============================================================================

-- Show buffer help
vim.keymap.set("n", "<leader>bh", function()
  local help_text = [[
📋 Buffer Navigation Keymaps:

🔄 Basic Navigation (LazyVim):
  <leader>bb    - Switch to other buffer
  <leader>`     - Switch to other buffer  
  <leader><tab> - Switch to other buffer

📁 Enhanced Navigation:
  <Tab>         - Next buffer
  <S-Tab>       - Previous buffer
  <leader>1-9   - Go to buffer 1-9
  <leader>0     - Go to buffer 10

🔧 Buffer Management:
  <leader>bl    - List all buffers
  <leader>bn    - New buffer
  <leader>bs    - Save current buffer
  <leader>ba    - Save all buffers
  <leader>bd    - Close buffer
  <leader>bD    - Force close buffer
  <leader>bc    - Close window
  <leader>bo    - Close other buffers

🔍 Buffer Finder:
  <leader>bf    - Find buffer with Telescope
  ]]
  
  vim.notify(help_text, vim.log.levels.INFO, {
    title = "Buffer Navigation Help",
    timeout = 8000,
  })
end, { desc = "Buffer Navigation Help" })

-- ============================================================================
-- BUFFER STATUS LINE
-- ============================================================================

-- Show current buffer info
vim.keymap.set("n", "<leader>bi", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(current_buf)
  local buf_number = current_buf
  local buf_count = #vim.api.nvim_list_bufs()
  
  local info = string.format("Buffer: %d/%d - %s", buf_number, buf_count, buf_name)
  vim.notify(info, vim.log.levels.INFO, {
    title = "Buffer Info",
    timeout = 3000,
  })
end, { desc = "Show Buffer Info" }) 