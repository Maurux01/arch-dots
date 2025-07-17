return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = false,
        show_buffer_close_icons = true,
        show_close_icon = false,
        color_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("nvim-web-devicons")
          local ret = (diag.error and icons.get_icon("DiagnosticError", nil, true) .. diag.error .. " " or "")
            .. (diag.warning and icons.get_icon("DiagnosticWarn", nil, true) .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
      custom_areas = {
        right = function()
          local result = {}
          local error = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          local warning = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          local info = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
          local hint = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })

          if #error > 0 then
            table.insert(result, { text = " " .. #error, guifg = "#ff6b6b" })
          end
          if #warning > 0 then
            table.insert(result, { text = " " .. #warning, guifg = "#feca57" })
          end
          if #info > 0 then
            table.insert(result, { text = " " .. #info, guifg = "#48dbfb" })
          end
          if #hint > 0 then
            table.insert(result, { text = " " .. #hint, guifg = "#c8d6e5" })
          end
          return result
        end,
      },
    },
  },
} 