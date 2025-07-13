-- lua/plugins/which-key.lua
-- Configuración mejorada de which-key con todas las funciones organizadas

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    window = {
      border = "rounded",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 1, 2, 1, 2 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "left",
    },
    show_help = true,
    show_keys = true,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    
    -- Registrar todas las funciones organizadas por categorías
    wk.register({
      -- File operations
      f = {
        name = "Files",
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
        o = { "<cmd>Telescope oldfiles<cr>", "Old files" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        r = { "<cmd>Telescope resume<cr>", "Resume last search" },
        p = { "<cmd>Prettier<cr>", "Format with Prettier" },
      },
      
      -- Buffer management
      b = {
        name = "Buffers",
        d = { "<cmd>BufferLinePickClose<cr>", "Close buffer" },
        p = { "<cmd>BufferLinePick<cr>", "Pick buffer" },
      },
      
      -- Git operations
      g = {
        name = "Git",
        g = { "<cmd>LazyGit<cr>", "LazyGit" },
        c = { "<cmd>LazyGitConfig<cr>", "LazyGit Config" },
        f = { "<cmd>LazyGitFilter<cr>", "LazyGit Filter" },
        l = { "<cmd>LazyGitFilterCurrentFile<cr>", "LazyGit Filter Current File" },
        b = { "<cmd>Git blame<cr>", "Git blame" },
        d = { "<cmd>Gvdiffsplit<cr>", "Git diff" },
        s = { "<cmd>Git<cr>", "Git status" },
        o = { "<cmd>GitConflictChooseOurs<cr>", "Choose Ours" },
        t = { "<cmd>GitConflictChooseTheirs<cr>", "Choose Theirs" },
        B = { "<cmd>GitConflictChooseBoth<cr>", "Choose Both" },
        n = { "<cmd>GitConflictChooseNone<cr>", "Choose None" },
        p = { "<cmd>GitConflictPrevConflict<cr>", "Previous Conflict" },
        x = { "<cmd>GitConflictNextConflict<cr>", "Next Conflict" },
      },
      
      -- Terminal
      t = {
        name = "Terminal",
        t = { "<cmd>ToggleTerm<cr>", "Toggle terminal" },
        h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal terminal" },
        v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical terminal" },
        T = { "<cmd>ToggleTerm direction=tab<cr>", "Terminal in new tab" },
      },
      
      -- File explorer
      e = {
        name = "Explorer",
        e = { "<cmd>lua require('snacks').explorer.open()<cr>", "Open Snacks Explorer" },
        f = { "<cmd>NvimTreeFocus<cr>", "Focus file explorer" },
        c = { "<cmd>NvimTreeCollapse<cr>", "Collapse file explorer" },
        r = { "<cmd>NvimTreeRefresh<cr>", "Refresh file explorer" },
      },
      
      -- LSP and diagnostics
      l = {
        name = "LSP",
        g = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show line diagnostics" },
        j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic" },
        k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic" },
      },
      
      -- Window management
      s = {
        name = "Split/Window",
        v = { "<cmd>vsplit<cr>", "Vertical split" },
        h = { "<cmd>split<cr>", "Horizontal split" },
        e = { "<cmd>wincmd =<cr>", "Equalize windows" },
      },
      
      -- Theme and UI
      u = {
        name = "UI/Theme",
        t = { "<cmd>lua require('config.theme-toggle').toggle()<cr>", "Toggle Theme" },
        N = { "<cmd>lua require('config.theme-toggle').next()<cr>", "Next Theme" },
        p = { "<cmd>lua require('config.theme-toggle').prev()<cr>", "Previous Theme" },
        n = { "<cmd>lua require('noice').cmd('dismiss')<cr>", "Dismiss All Notifications" },
      },
      
      -- Sessions
      q = {
        name = "Sessions",
        s = { "<cmd>lua require('persistence').load()<cr>", "Restore session" },
        l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
        d = { "<cmd>lua require('persistence').stop()<cr>", "Don't save session" },
      },
      
      -- Noice (notifications)
      s = {
        name = "System",
        n = {
          name = "Noice",
          l = { "<cmd>lua require('noice').cmd('last')<cr>", "Noice Last Message" },
          h = { "<cmd>lua require('noice').cmd('history')<cr>", "Noice History" },
          a = { "<cmd>lua require('noice').cmd('all')<cr>", "Noice All" },
        },
      },
      
      -- Git signs
      r = {
        name = "Git Signs",
        h = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Git hunk" },
        p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Git hunk" },
      },
      
      t = {
        name = "Toggle",
        b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Git blame" },
        d = { "<cmd>Gitsigns toggle_deleted<cr>", "Toggle Git deleted" },
        w = { "<cmd>set wrap!<cr>", "Toggle wrap" },
        n = { "<cmd>set number!<cr>", "Toggle number" },
        r = { "<cmd>set relativenumber!<cr>", "Toggle relative number" },
        s = { "<cmd>set spell!<cr>", "Toggle spell" },
      },
      
      -- Quick operations
      w = { "<cmd>w<cr>", "Save" },
      W = { "<cmd>wa<cr>", "Save all" },
      Q = { "<cmd>qa!<cr>", "Quit all" },
      
      -- Search and replace
      s = {
        name = "Search",
        r = { ":%s/", "Search and replace" },
        R = { ":%s/<C-r><C-w>/", "Search and replace word under cursor" },
      },
      
      -- Clipboard
      y = { '"+y', "Yank to clipboard" },
      Y = { '"+yg_', "Yank line to clipboard" },
      p = { '"+p', "Paste from clipboard" },
      P = { '"+P', "Paste from clipboard before" },
      
      -- Navigation
      g = {
        name = "Navigation",
        p = { "<cmd>e#<cr>", "Go to previous file" },
      },
      
      -- Code capture and recording
      c = {
        name = "Capture/Code",
        i = { "<cmd>lua require('config.capture-utils').capture_buffer_as_image()<cr>", "Capture buffer as image" },
        c = { "<cmd>lua require('config.capture-utils').capture_code_block()<cr>", "Capture code block" },
        b = { "<cmd>lua require('config.capture-utils').create_ascii_box()<cr>", "Create ASCII box" },
        r = { "<cmd>lua require('config.capture-utils').toggle_recording_mode()<cr>", "Toggle screen recording" },
        t = { "<cmd>Twilight<cr>", "Toggle Twilight (focus mode)" },
        s = { "<cmd>SnipRun<cr>", "Run code snippet" },
        l = { "<cmd>SnipReset<cr>", "Clear snippet output" },
        v = { "<cmd>VBox<cr>", "Draw box around selection" },
      },
      
      -- AI Assistant
      a = {
        name = "AI Assistant",
        i = { "<cmd>ChatGPT<cr>", "Open ChatGPT" },
        e = { "<cmd>ChatGPTEditWithInstructions<cr>", "Edit with ChatGPT" },
        t = { "<cmd>ChatGPTRun explain_code<cr>", "Explain code" },
        f = { "<cmd>ChatGPTRun fix_bug<cr>", "Fix bug" },
        r = { "<cmd>ChatGPTRun review_code<cr>", "Review code" },
        o = { "<cmd>ChatGPTRun optimize_code<cr>", "Optimize code" },
        d = { "<cmd>ChatGPTRun add_tests<cr>", "Add tests" },
      },
      
      -- Refactoring
      r = {
        name = "Refactor",
        r = { "<cmd>lua require('refactoring').select_refactor()<cr>", "Select Refactor" },
        p = { "<cmd>lua require('refactoring').debug.printf({below = false})<cr>", "Debug Print" },
        v = { "<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>", "Debug Print Var" },
        c = { "<cmd>lua require('refactoring').debug.cleanup({})<cr>", "Debug Cleanup" },
      },
      
      -- Image support
      i = {
        name = "Image",
        i = { "<cmd>ImageInfo<cr>", "Show image info" },
        r = { "<cmd>ImageReload<cr>", "Reload image" },
        c = { "<cmd>ImageClear<cr>", "Clear image" },
        p = { "<cmd>ImagePaste<cr>", "Paste image" },
        d = { "<cmd>ImageDownload<cr>", "Download image" },
        s = { "<cmd>ImageSave<cr>", "Save image" },
      },
      
      -- Markdown
      m = {
        name = "Markdown",
        p = { "<cmd>MarkdownPreview<cr>", "Markdown preview" },
        s = { "<cmd>MarkdownPreviewStop<cr>", "Stop preview" },
        t = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle preview" },
      },
      
      -- Live Server
      l = {
        name = "Live Server",
        s = { "<cmd>lua require('config.live-server').toggle()<cr>", "Toggle Live Server" },
      },
      
      -- Comments
      ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", "Toggle comment line" },
      
      -- Lazy (plugin manager)
      E = { "<cmd>Lazy<cr>", "Open Lazy (Plugin Manager)" },
      
      -- Clear highlights
      n = {
        name = "Clear",
        h = { "<cmd>nohl<cr>", "Clear highlights" },
      },
      
      -- Buffer numbers (1-9)
      ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "Go to buffer 1" },
      ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "Go to buffer 2" },
      ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "Go to buffer 3" },
      ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "Go to buffer 4" },
      ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "Go to buffer 5" },
      ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "Go to buffer 6" },
      ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "Go to buffer 7" },
      ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "Go to buffer 8" },
      ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "Go to buffer 9" },
      
      -- Tab navigation
      tab = {
        name = "Tabs",
        n = { "<cmd>tabnew<cr>", "New tab" },
        c = { "<cmd>tabclose<cr>", "Close tab" },
        l = { "<cmd>tabnext<cr>", "Next tab" },
        h = { "<cmd>tabprevious<cr>", "Previous tab" },
      },
      
    }, { prefix = "<leader>" })
    
    -- Registrar teclas sin leader
    wk.register({
      -- Git signs navigation
      ["]c"] = { function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() require("gitsigns").next_hunk() end)
        return "<Ignore>"
      end, "Next Git hunk", { expr = true } },
      
      ["[c"] = { function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() require("gitsigns").prev_hunk() end)
        return "<Ignore>"
      end, "Previous Git hunk", { expr = true } },
      
      -- LSP
      gd = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
      gr = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
      K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
      
      -- Surround
      ys = { "<cmd>lua require('mini.surround').add()<cr>", "Add surround" },
      ds = { "<cmd>lua require('mini.surround').delete()<cr>", "Delete surround" },
      cs = { "<cmd>lua require('mini.surround').replace()<cr>", "Change surround" },
      
      -- Emmet
      ["<C-y>"] = { "<cmd>Emmet<cr>", "Emmet expand" },
    })
  end,
} 