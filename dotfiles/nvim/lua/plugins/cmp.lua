-- Optimized nvim-cmp configuration for modern IDE experience
-- Enhanced with better visual appearance, performance, and features

return {
  -- nvim-cmp setup with modern IDE features
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
      "onsails/lspkind.nvim",
      "windwp/nvim-autopairs",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Load friendly snippets with better organization
      require("luasnip.loaders.from_vscode").lazy_load({
        exclude = { "global" },
      })

      -- Enhanced completion configuration
      return {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
          keyword_length = 1,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
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
          ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp", priority = 100, max_item_count = 10 },
          { name = "luasnip", priority = 750, max_item_count = 5 },
          { name = "buffer", priority = 50, max_item_count = 8 },
          { name = "path", priority = 250, max_item_count = 5 },
          { name = "nvim_lua", priority = 20, max_item_count = 3 },
          { name = "nvim_lsp_signature_help", priority = 150, max_item_count = 2 },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 60,
            ellipsis_char = "…",
            before = function(entry, vim_item)
              -- Enhanced menu labels with icons
              vim_item.menu = ({
                nvim_lsp = "🔧 LSP",
                luasnip = "📝 Snippet",
                buffer = "📄 Buffer",
                path = "📁 Path",
                nvim_lua = "🐺 Lua",
                nvim_lsp_signature_help = "📋 Signature",
              })[entry.source.name]
              
              -- Add source-specific styling
              if entry.source.name == "nvim_lsp" then
                vim_item.kind = "🔧"
              elseif entry.source.name == "luasnip" then
                vim_item.kind = "📝"
              elseif entry.source.name == "buffer" then
                vim_item.kind = "📄"
              elseif entry.source.name == "path" then
                vim_item.kind = "📁"
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
            relative = "cursor",
            row = 1,
            col = 0,
            width = 60,
            height = 10,
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            max_width = 80,
            max_height = 20,
          },
        },
        experimental = {
          ghost_text = {
            hl_group = "Comment",
          },
        },
        -- Enhanced performance settings
        performance = {
          debounce = 300,
          throttle = 500,
          max_view_entries = 20,
        },
        -- Smart case matching
        matching = {
          disallow_fuzzy_matching = false,
          disallow_full_fuzzy_matching = false,
          disallow_partial_fuzzy_matching = false,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = false,
        },
        -- Enhanced sorting
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
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)
      
      -- Command line completion setup
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

  -- Enhanced LuaSnip configuration
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = true,
      delete_check_events = "TextChanged,InsertLeave",
      region_check_events = "CursorMoved,CursorHold,InsertEnter",
      enable_autosnippets = false,
      store_selection_keys = "<Tab>",
      update_events = { "TextChanged", "TextChangedI" },
      -- Enhanced snippet configuration
      snip_env = {
        s = require("luasnip.nodes.snippet").S,
        sn = require("luasnip.nodes.snippet").SN,
        t = require("luasnip.nodes.textNode").T,
        f = require("luasnip.nodes.functionNode").F,
        i = require("luasnip.nodes.insertNode").I,
        c = require("luasnip.nodes.choiceNode").C,
        d = require("luasnip.nodes.dynamicNode").D,
        r = require("luasnip.nodes.restoreNode").R,
        l = require(luasnip.extras).lambda,
        rep = require(luasnip.extras).rep,
        p = require(luasnip.extras).partial,
        m = require(luasnip.extras).match,
        n = require(luasnip.extras).nonempty,
        dl = require(luasnip.extras).dynamic_lambda,
        fmt = require("luasnip.extras.fmt").fmt,
        fmta = require("luasnip.extras.fmt").fmta,
        conds = require("luasnip.extras.expand_conditions"),
        postfix = require("luasnip.extras.postfix").postfix,
        types = require("luasnip.util.types"),
        parse = require("luasnip.util.parser").parse_snippet,
        js = require(luasnip.extras).join,
      },
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
      {
        "<C-j>",
        function()
          if require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          end
        end,
        mode = { "i", "s" },
      },
      {
        "<C-k>",
        function()
          if require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          end
        end,
        mode = { "i", "s" },
      },
    },
  },

  -- Enhanced friendly snippets
  {
    "rafamadriz/friendly-snippets",
    config = function()
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
          "markdown",
          "yaml",
          "toml",
          "dockerfile",
          "bash",
          "sh",
        },
      })
    end,
  },

  -- Enhanced autopairs integration
  {
    "windwp/nvim-autopairs",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        typescript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "(", "[", "<", "$", "`", "'" },
        pattern = string.gsub([[ [%%%)%>%]%)%}%,] ]], "%s+", "),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
      -- Enhanced autopairs behavior
      enable_check_bracket_line = true,
      enable_moveright = true,
      enable_afterquote = true,
      enable_endwise = true,
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      
      -- Integrate with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
} 