-- Copilot and AI Completion Plugins - Configuración limpia
return {
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          markdown = true,
          help = true,
        },
        copilot_node_command = "node",
        server_opts_overrides = {},
      })
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "yes",
      debug = false,
      disable_extra_info = "no",
      language = "English",
      model = "gpt-4",
      temperature = 0.1,
      system_prompt = "You are a helpful assistant that helps with coding tasks.",
      user_prompt = "",
      max_output = 2000,
      context = "CopilotChatInContext",
      history_path = vim.fn.stdpath("data") .. "/copilotchat",
      chat_path = vim.fn.stdpath("data") .. "/copilotchat",
      separate_buffer = true,
      popup_type = "float",
      popup_border = "rounded",
      popup_width = 0.8,
      popup_height = 0.8,
      popup_row = 0.1,
      popup_col = 0.1,
      window_options = {
        relative = "editor",
        width = 80,
        height = 20,
        row = 0.1,
        col = 0.1,
        style = "minimal",
        border = "rounded",
      },
      keymaps = {
        close = "<C-c>",
        yank_last = "<C-y>",
        yank_last_code = "<C-k>",
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        toggle_settings = "<C-o>",
        new_session = "<C-n>",
        cycle_windows = "<Tab>",
        select_session = "<C-s>",
        rename_session = "r",
        delete_session = "d",
        draft_message = "<C-d>",
        toggle_message_role = "<C-r>",
        toggle_system_role_open = "<C-s>",
      },
    },
    build = function()
      vim.notify(
        "Please install 'CopilotChat.nvim' dependencies manually:\n"
          .. "npm install -g @githubnext/github-copilot-cli",
        vim.log.levels.WARN
      )
    end,
  },

  -- Auto pairs with AI suggestions
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "python",
        "bash",
        "rust",
        "go",
        "c",
        "cpp",
        "java",
        "php",
        "ruby",
        "sql",
        "xml",
        "toml",
        "dockerfile",
        "gitignore",
        "vim",
        "vimdoc",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autotag = { enable = true },
      context_commentstring = { enable = true },
    },
  },
} 