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

  -- REST Client for HTTP requests
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "http", "rest" },
    opts = {
      -- Puedes personalizar aquí las opciones de rest.nvim
      result_split_horizontal = false,
      skip_ssl_verification = false,
      highlight = {
        enable = true,
        timeout = 150,
      },
      jump_to_request = false,
      env_file = ".env",
      custom_dynamic_variables = {},
      yank_dry_run = true,
    },
    config = function(_, opts)
      require("rest-nvim").setup(opts)
      -- Keymap para enviar la petición actual
      vim.keymap.set("n", "<leader>rr", require("rest-nvim").run, { desc = "Enviar petición HTTP" })
      vim.keymap.set("n", "<leader>rp", require("rest-nvim").run_last, { desc = "Repetir última petición HTTP" })
    end,
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