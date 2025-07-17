-- lua/plugins/webdev.lua
-- Plugins y configuración para desarrollo web moderno (frontend y backend)

return {
  -- Live Server (recarga en caliente)
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
    keys = {
      { "<leader>ls", ":LiveServerStart<CR>", desc = "Iniciar Live Server" },
      { "<leader>le", ":LiveServerStop<CR>", desc = "Detener Live Server" },
    },
  },

  -- Peticiones HTTP tipo Postman
  {
    "rest-nvim/rest.nvim",
    ft = { "http" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = true,
        skip_ssl_verification = false,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_http_info = true,
          show_headers = true,
        },
      })
    end,
    keys = {
      { "<leader>rr", "<Plug>RestNvim", desc = "Ejecutar petición HTTP" },
      { "<leader>rp", "<Plug>RestNvimPreview", desc = "Previsualizar petición HTTP" },
      { "<leader>rl", "<Plug>RestNvimLast", desc = "Repetir última petición HTTP" },
    },
  },

  -- Autocompletado y snippets para frameworks modernos
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    config = true,
  },
  {
    "mlaursen/vim-react-snippets",
    ft = { "javascriptreact", "typescriptreact", "javascript", "typescript" },
  },
  {
    "xabikos/vscode-react-javascript-snippets",
    ft = { "javascriptreact", "typescriptreact" },
  },
  {
    "dsznajder/vscode-es7-javascript-react-snippets",
    build = "npm install --legacy-peer-deps && npm run build --if-present",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript", "typescriptreact" },
    config = function()
      require("typescript").setup({
        server = {
          on_attach = function(client, bufnr)
            -- Opcional: formateo automático al guardar
            if client.server_capabilities.documentFormattingProvider then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end
          end,
        },
      })
    end,
  },

  -- Prettier y ESLint (formateo y linting)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = true,
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lint").linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        svelte = { "eslint_d" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
} 