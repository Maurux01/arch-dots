-- LSP y autocompletado
require('mason').setup()
require('mason-lspconfig').setup()
require('lspconfig').pyright.setup{}
require('lspconfig').tsserver.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').lua_ls.setup{}
require('lspconfig').clangd.setup{}
require('lspconfig').gopls.setup{}

-- nvim-cmp setup
local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}) 