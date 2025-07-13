-- lua/plugins/webdev.lua
-- Configuración específica para desarrollo web con prevención de duplicaciones

return {
  -- HTML/CSS/JS development tools
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "scss", "sass", "less", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "php", "xml", "xsl", "haml", "jade", "pug", "slim", "erb", "ejs" },
    config = function()
      -- Configuración de Emmet para evitar conflictos con snippets
      vim.g.user_emmet_mode = 'a'
      vim.g.user_emmet_leader_key = '<C-e>'
      vim.g.user_emmet_settings = {
        html = {
          default_attributes = {
            option = { value = vim.null },
            textarea = { id = vim.null, name = vim.null, cols = 10, rows = 10 },
          },
          snippets = {
            ['!'] = '<!DOCTYPE html>\n<html lang="${lang}">\n<head>\n\t<meta charset="${charset}">\n\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n\t<title>${title}</title>\n</head>\n<body>\n\t${child}|\n</body>\n</html>',
          },
        },
        css = {
          default_attributes = {
            a = { href = '' },
          },
        },
        javascript = {
          default_attributes = {
            b = { class = 'btn' },
          },
        },
      }
    end,
  },

  -- Prettier for code formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        sass = { "prettier" },
        less = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- HTML preview
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        style = "dark",
        width = 120,
      })
    end,
  },

  -- Live server for web development
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    config = function()
      require("live-server").setup({
        port = 3000,
        browser = "google-chrome",
        open = true,
        file = "index.html",
        wait = 1000,
        mount = {},
        logLevel = 2,
        middleware = {},
      })
    end,
  },

  -- Web development snippets (custom, sin duplicaciones)
  {
    "rafamadriz/friendly-snippets",
    config = function()
      -- Cargar solo snippets específicos para web development
      require("luasnip.loaders.from_vscode").lazy_load({
        include = {
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "json",
        },
        exclude = { "global", "all", "lua", "python", "rust", "go", "java", "c", "cpp", "php" },
      })

      -- Configuración específica para evitar duplicaciones en HTML
      local ls = require("luasnip")
      
      -- Función para limpiar snippets duplicados específicamente para HTML
      local function clean_html_snippets()
        if ls.snippets.html then
          local seen = {}
          local unique_snippets = {}
          
          for name, snippet in pairs(ls.snippets.html) do
            local key = snippet.trigger or name
            if not seen[key] then
              seen[key] = true
              unique_snippets[name] = snippet
            end
          end
          
          ls.snippets.html = unique_snippets
        end
      end
      
      -- Aplicar limpieza después de cargar snippets
      vim.defer_fn(clean_html_snippets, 100)
    end,
  },

  -- CSS color preview
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_named_colors = true,
        enable_tailwind = true,
      })
    end,
  },

  -- Tailwind CSS support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configuración específica para CSS/HTML
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            less = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        html = {
          settings = {
            html = {
              format = {
                templating = true,
                wrapLineLength = 120,
                wrapAttributes = "auto",
              },
              suggest = {
                html5 = true,
              },
            },
          },
        },
        emmet_ls = {
          filetypes = { 
            "html", "css", "scss", "sass", "less", 
            "javascript", "javascriptreact", "typescript", "typescriptreact", 
            "vue", "php", "xml", "xsl", "haml", "jade", "pug", "slim", "erb", "ejs" 
          },
          init_options = {
            html = {
              options = {
                ["bem.enabled"] = true,
              },
            },
          },
        },
      },
    },
  },

  -- Keymaps específicos para desarrollo web
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Web development specific keymaps
      { "<leader>wh", "<cmd>Telescope live_grep search_dirs={\"src\",\"public\",\"components\"}<cr>", desc = "Search web files" },
      { "<leader>wf", "<cmd>Telescope find_files search_dirs={\"src\",\"public\",\"components\"}<cr>", desc = "Find web files" },
      { "<leader>ws", "<cmd>LiveServerStart<cr>", desc = "Start live server" },
      { "<leader>wt", "<cmd>LiveServerStop<cr>", desc = "Stop live server" },
      { "<leader>wr", "<cmd>LiveServerRestart<cr>", desc = "Restart live server" },
    },
  },
} 