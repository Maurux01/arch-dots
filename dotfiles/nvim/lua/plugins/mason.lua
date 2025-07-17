return [object Object]
  -- Mason - LSP, DAP, Linter, and Formatter installer[object Object]
 williamboman/mason.nvim",
    dependencies =[object Object]  williamboman/mason-lspconfig.nvim,
     jay-babu/mason-null-ls.nvim",
    },
    config = function()
      require("mason).setup({
        ui = [object Object]          border = "rounded,
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = ✗        },
        },
        max_concurrent_installers = 4      })

      -- Mason LSP Config
      require("mason-lspconfig).setup({
        ensure_installed = [object Object]
  lua_ls",
    tsserver,         html",
          cssls,
  jsonls",
    emmet_ls",
  yamlls",
    marksman,
         rust_analyzer",
          gopls",
   pyright",
  clangd,
         bashls",
        },
        automatic_installation = true,
      })

      -- Mason Null-ls (for linters and formatters)
      require("mason-null-ls).setup({
        ensure_installed = {
          -- Linters
    eslint_d",
  flake8",
      shellcheck",
    luacheck,       markdownlint",
          -- Formatters
    prettier,
  stylua",
          black",
          isort",
          shfmt,          rustfmt",
        },
        automatic_installation = true,
        automatic_setup = true,
      })
    end,
    keys = [object Object]
      { "<leader>mm,<cmd>Mason<cr>", desc = "Open Mason" },
      { "<leader>mi", <cmd>MasonInstall<cr>, desc=Install package" },
      { "<leader>mu", "<cmd>MasonUninstall<cr>", desc = Uninstall package" },
      { "<leader>mr", "<cmd>MasonUninstallAll<cr>", desc = "Uninstall all },
    },
  },

  -- Mason LSP Config[object Object]
 williamboman/mason-lspconfig.nvim",
    opts = [object Object]     handlers = [object Object]        -- Lua LSP
        lua_ls = function()
          require(lspconfig).lua_ls.setup({
            settings = {
              Lua =[object Object]       diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = {
                    [vim.fn.expand($VIMRUNTIME/lua")] = true,
                    [vim.fn.expand($VIMRUNTIME/lua/vim/lsp")] = true,
                  },
                },
              },
            },
          })
        end,
        -- TypeScript/JavaScript
        tsserver = function()
          require("lspconfig").tsserver.setup({
            settings = {
              typescript =[object Object]                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript =[object Object]                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          })
        end,
        -- HTML
        html = function()
          require("lspconfig").html.setup({
            settings = {
              html =[object Object]            format = {
                  templating = true,
                  wrapLineLength = 120,
                  wrapAttributes = "auto,               },
                suggest = {
                  html5 = true,
                },
              },
            },
          })
        end,
        -- CSS
        cssls = function()
          require(lspconfig").cssls.setup({
            settings = {
              css =[object Object]          validate = true,
                lint = {
                  unknownAtRules = "ignore,               },
              },
              less =[object Object]          validate = true,
                lint = {
                  unknownAtRules = "ignore,               },
              },
              scss =[object Object]          validate = true,
                lint = {
                  unknownAtRules = "ignore,               },
              },
            },
          })
        end,
        -- JSON
        jsonls = function()
          require("lspconfig).jsonls.setup({
            settings = {
              json =[object Object]            format = {
                  enable = true,
                },
                validate = { enable = true },
              },
            },
          })
        end,
        -- Emmet
        emmet_ls = function()
          require(lspconfig").emmet_ls.setup([object Object]         filetypes =[object Object]             html",css,scss,sassless", "javascript,       javascriptreact, ypescript", "typescriptreact,              vue,php,xml",xsl, haml, ug,
             slim", "erb",ejs"
            },
            init_options = {
              html =[object Object]           options = {
                  ["bem.enabled"] = true,
                },
              },
            },
          })
        end,
        -- Python
        pyright = function()
          require("lspconfig").pyright.setup({
            settings = {
              python =[object Object]          analysis = {
                  autoImportCompletions = true,
                  typeCheckingMode = "basic",
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,
        -- Rust
        rust_analyzer = function()
          require(lspconfig").rust_analyzer.setup({
            settings = [object Object]           rust-analyzer"] =[object Object]             checkOnSave = {
                  command = "clippy,               },
                cargo = {
                  allFeatures = true,
                },
              },
            },
          })
        end,
        -- Go
        gopls = function()
          require(lspconfig").gopls.setup({
            settings =[object Object]
              gopls =[object Object]          analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
              },
            },
          })
        end,
        -- C/C++
        clangd = function()
          require(lspconfig).clangd.setup({
            settings = [object Object]             clangd =[object Object]         arguments = {
             --background-index",
                --clang-tidy
                --header-insertion=iwyu",
             --completion-style=detailed",
               --function-arg-placeholders,               },
              },
            },
          })
        end,
        -- Bash
        bashls = function()
          require("lspconfig).bashls.setup({
            settings = {
              bashIde =[object Object]              globPattern =**/*@(.sh|.inc|.bash|.command)",
              },
            },
          })
        end,
      },
    },
  },

  -- Mason Null-ls
 [object Object]  jay-babu/mason-null-ls.nvim",
    opts = [object Object]     handlers = {
        -- Linters
        eslint_d = function()
          require("null-ls").register(require("null-ls.builtins.diagnostics.eslint_d"))
        end,
        flake8 = function()
          require("null-ls").register(require("null-ls.builtins.diagnostics.flake8      end,
        shellcheck = function()
          require("null-ls").register(require("null-ls.builtins.diagnostics.shellcheck"))
        end,
        luacheck = function()
          require("null-ls").register(require("null-ls.builtins.diagnostics.luacheck"))
        end,
        markdownlint = function()
          require("null-ls").register(require("null-ls.builtins.diagnostics.markdownlint"))
        end,
        -- Formatters
        prettier = function()
          require("null-ls").register(require("null-ls.builtins.formatting.prettier"))
        end,
        stylua = function()
          require("null-ls").register(require("null-ls.builtins.formatting.stylua"))
        end,
        black = function()
          require("null-ls").register(require("null-ls.builtins.formatting.black"))
        end,
        isort = function()
          require("null-ls").register(require("null-ls.builtins.formatting.isort"))
        end,
        shfmt = function()
          require("null-ls").register(require("null-ls.builtins.formatting.shfmt))
        end,
        rustfmt = function()
          require("null-ls").register(require("null-ls.builtins.formatting.rustfmt))
        end,
      },
    },
  },
} 