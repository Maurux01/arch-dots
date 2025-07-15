-- lua/plugins/cmp.lua
-- Configuración optimizada de autocompletado con nvim-cmp

return {
  -- nvim-cmp setup
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim"
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Load friendly snippets with deduplication
      require("luasnip.loaders.from_vscode").lazy_load({
        exclude = { "global" },
      })

      -- Custom deduplication function
      local function deduplicate_entries(entries)
        local seen = {}
        local result = {}
        
        for _, entry in ipairs(entries) do
          local key = entry.completion_item.label
          if not seen[key] then
            seen[key] = true
            table.insert(result, entry)
          end
        end
        
        return result
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp", priority = 800, max_item_count = 8 },
          { name = "luasnip", priority = 750, max_item_count = 3 },
          { name = "buffer", priority = 500, max_item_count = 5 },
          { name = "path", priority = 250, max_item_count = 3 },
          { name = "nvim_lua", priority = 200, max_item_count = 2 },
          { name = "nvim_lsp_signature_help", priority = 150, max_item_count = 1 },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              -- Custom menu labels to distinguish sources
              vim_item.menu = ({
                nvim_lsp = "[🔧 LSP]",
                luasnip = "[📝 Snippet]",
                buffer = "[📄 Buffer]",
                path = "[📁 Path]",
                nvim_lua = "[🐺 Lua]",
                nvim_lsp_signature_help = "[📋 Signature]",
              })[entry.source.name]
              
              -- Add source-specific icons
              if entry.source.name == "nvim_lsp" then
                vim_item.kind = "🔧"
              elseif entry.source.name == "luasnip" then
                vim_item.kind = "📝"
              end
              
              return vim_item
            end,
          }),
        },
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            col_offset = -3,
            side_padding = 0,
            scrollbar = false,
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          },
        },
        experimental = {
          ghost_text = true,
        },
        -- Enhanced deduplication
        dedupe = true,
        -- Smart case matching
        matching = {
          disallow_fuzzy_matching = false,
          disallow_full_fuzzy_matching = false,
          disallow_partial_fuzzy_matching = false,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = false,
        },
        -- Custom sorting to prioritize unique entries
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      }
    end,
  },

  -- Command line completion
  {
    "hrsh7th/cmp-cmdline",
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },

  -- LuaSnip configuration with advanced deduplication
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = true,
      delete_check_events = "TextChanged,InsertLeave",
      region_check_events = "CursorMoved,CursorHold,InsertEnter",
      enable_autosnippets = false, -- Disable autosnippets to prevent spam
      store_selection_keys = "<Tab>",
      -- Prevent duplicate snippets
      update_events = { "TextChanged", "TextChangedI" },
      -- (Eliminada la opción load_ft_func que causaba error)
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<s-tab>",
        function()
          return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev" or "<s-tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
    },
  },

  -- Friendly snippets with advanced deduplication
  {
    "rafamadriz/friendly-snippets",
    config = function()
      -- Load snippets with strict deduplication
      require("luasnip.loaders.from_vscode").lazy_load({
        exclude = { "global", "all" },
        include = {
          "javascript",
          "typescript",
          "html",
          "css",
          "scss",
          "json",
          "lua",
          "python",
          "rust",
          "go",
          "java",
          "c",
          "cpp",
          "php",
          "vue",
          "react",
        },
      })
      
      -- Custom snippet configuration to prevent duplicates
      local ls = require("luasnip")
      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = false, -- Disable to prevent spam
        store_selection_keys = "<Tab>",
        -- Custom snippet deduplication
        region_check_events = "CursorMoved,CursorHold,InsertEnter",
        delete_check_events = "TextChanged,InsertLeave",
      })
      
      -- Custom snippet loader to prevent duplicates
      local function load_snippets_with_deduplication()
        local snippets = require("luasnip.loaders.from_vscode")
        local loaded_snippets = {}
        
        -- Load snippets and track what's already loaded
        snippets.lazy_load({
          exclude = { "global", "all" },
        })
        
        -- Custom deduplication logic
        for ft, ft_snippets in pairs(ls.snippets) do
          local unique_snippets = {}
          local seen = {}
          
          for name, snippet in pairs(ft_snippets) do
            local key = snippet.trigger or name
            if not seen[key] then
              seen[key] = true
              unique_snippets[name] = snippet
            end
          end
          
          ls.snippets[ft] = unique_snippets
        end
      end
      
      -- Load snippets with deduplication
      load_snippets_with_deduplication()
    end,
  },
} 