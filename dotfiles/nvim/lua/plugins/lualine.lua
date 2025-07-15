-- lua/plugins/lualine.lua
-- Beautiful and elegant Lualine configuration with stunning visuals
return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local lualine = require('lualine')
      
      -- Beautiful color palette
      local colors = {
        -- Primary colors
        blue = '#7aa2f7',
        cyan = '#7dcfff',
        green = '#9ece6a',
        purple = '#bb9af7',
        red = '#f7768e',
        orange = '#ff9e64',
        yellow = '#e0af68',
        pink = '#f7768e',
        
        -- Background colors
        bg = '#1a1b26',
        bg_alt = '#16161e',
        bg_light = '#24283b',
        
        -- Text colors
        fg = '#a9b1d6',
        fg_alt = '#7982a9',
        fg_dark = '#565a6e',
        
        -- Accent colors
        accent1 = '#7aa2f7',
        accent2 = '#bb9af7',
        accent3 = '#7dcfff',
        accent4 = '#9ece6a',
        accent5 = '#f7768e',
      }

      -- Custom components with beautiful icons
      local function get_lsp_name()
        local msg = '󰒋 No LSP'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return '󰒋 ' .. client.name
          end
        end
        return msg
      end

      local function get_git_branch()
        local branch = vim.fn.trim(vim.fn.system('git branch --show-current 2>/dev/null'))
        if branch == '' then
          return ''
        end
        return ' 󰘬 ' .. branch
      end

      local function get_git_status()
        local status = vim.fn.trim(vim.fn.system('git status --porcelain 2>/dev/null'))
        if status == '' then
          return ''
        end
        
        local added = vim.fn.system('git status --porcelain 2>/dev/null | grep "^A" | wc -l')
        local modified = vim.fn.system('git status --porcelain 2>/dev/null | grep "^ M" | wc -l')
        local deleted = vim.fn.system('git status --porcelain 2>/dev/null | grep "^ D" | wc -l')
        
        local status_str = ''
        if tonumber(added) > 0 then
          status_str = status_str .. ' 󰐕 ' .. added
        end
        if tonumber(modified) > 0 then
          status_str = status_str .. ' 󰆓 ' .. modified
        end
        if tonumber(deleted) > 0 then
          status_str = status_str .. ' 󰩺 ' .. deleted
        end
        
        return status_str
      end

      local function get_file_size()
        local file = vim.fn.expand('%:p')
        if file == '' then
          return ''
        end
        local size = vim.fn.getfsize(file)
        if size <= 0 then
          return ''
        end
        local suffixes = {'B', 'KB', 'MB', 'GB'}
        local i = 1
        while size > 1024 and i < #suffixes do
          size = size / 1024
          i = i + 1
        end
        return string.format('󰇚 %.1f%s', size, suffixes[i])
      end

      local function get_cursor_position()
        local line = vim.fn.line('.')
        local col = vim.fn.col('.')
        local total_lines = vim.fn.line('$')
        return string.format('󰍡 %d:%d/%d', line, col, total_lines)
      end

      local function get_file_icon()
        local file = vim.fn.expand('%:t')
        if file == '' then
          return '󰈙'
        end
        local icon = require('nvim-web-devicons').get_icon(file, vim.fn.expand('%:e'))
        return icon or '󰈙'
      end

      -- Choose configuration style (complete or minimal)
      local use_minimal = false -- Set to true for minimal style
      
      local config
      if use_minimal then
        -- Minimal but beautiful configuration
        config = {
          options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = ' ', right = ' '},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            always_divide_middle = true,
            globalstatus = false,
          },
          sections = {
            lualine_a = {
              {
                'mode',
                separator = { left = '', right = ''},
                right_padding = 2,
                color = { fg = colors.bg, bg = colors.accent1, gui = 'bold' },
              }
            },
            lualine_b = {
              {
                get_git_branch,
                color = { fg = colors.accent2 },
                separator = { left = '', right = ' '},
              },
              {
                'diff',
                symbols = { added = ' 󰐕', modified = ' 󰆓', removed = ' 󰩺' },
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
              },
              {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' 󰅚', warn = ' 󰀪', info = ' 󰋼', hint = ' 󰌵' },
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
              },
            },
            lualine_c = {
              {
                get_file_icon,
                color = { fg = colors.accent3 },
                separator = { left = '', right = ' '},
              },
              {
                'filename',
                file_status = true,
                path = 1,
                symbols = {
                  modified = ' ●',
                  readonly = ' 󰀾',
                  unnamed = '[No Name]',
                  newfile = '[New]',
                },
                color = { fg = colors.fg },
                separator = { left = '', right = ' '},
              },
              {
                get_lsp_name,
                color = { fg = colors.accent4 },
                separator = { left = '', right = ''},
              },
            },
            lualine_x = {
              {
                'encoding',
                color = { fg = colors.fg_alt },
                separator = { left = ' ', right = ' '},
              },
              {
                'filetype',
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
              },
            },
            lualine_y = {
              {
                'progress',
                color = { fg = colors.accent5 },
                separator = { left = ' ', right = ' '},
              },
            },
            lualine_z = {
              {
                'location',
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
              },
              {
                'datetime',
                style = '%H:%M',
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ''},
              },
            },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = { 'nvim-tree', 'trouble', 'lazy', 'toggleterm' },
        }
      else
        -- Complete and beautiful configuration
        config = {
          options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            }
          },
          sections = {
            lualine_a = {
              {
                'mode',
                separator = { left = '', right = ''},
                right_padding = 2,
                color = { fg = colors.bg, bg = colors.accent1, gui = 'bold' },
              }
            },
            lualine_b = {
              {
                'b:gitsigns_head',
                icon = ' 󰘬',
                color = { fg = colors.accent2 },
                separator = { left = '', right = ' '},
              },
              {
                'diff',
                symbols = { added = ' 󰐕 ', modified = ' 󰆓 ', removed = ' 󰩺 ' },
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
              },
              {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' 󰅚 ', warn = ' 󰀪 ', info = ' 󰋼 ', hint = ' 󰌵 ' },
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
              },
            },
            lualine_c = {
              {
                get_file_icon,
                color = { fg = colors.accent3 },
                separator = { left = '', right = ' '},
              },
              {
                'filename',
                file_status = true,
                path = 1,
                symbols = {
                  modified = ' ●',
                  readonly = ' 󰀾',
                  unnamed = '[No Name]',
                  newfile = '[New]',
                },
                color = { fg = colors.fg },
                separator = { left = '', right = ' '},
              },
              {
                get_lsp_name,
                color = { fg = colors.accent4 },
                separator = { left = '', right = ' '},
              },
            },
            lualine_x = {
              {
                'encoding',
                color = { fg = colors.fg_alt },
                separator = { left = ' ', right = ' '},
                right_padding = 2,
              },
              {
                'fileformat',
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
                right_padding = 2,
              },
              {
                'filetype',
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
                right_padding = 2,
              },
              {
                get_file_size,
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
                right_padding = 2,
              },
            },
            lualine_y = {
              {
                'progress',
                color = { fg = colors.accent5 },
                separator = { left = ' ', right = ' '},
                left_padding = 2,
              },
              {
                get_cursor_position,
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
                left_padding = 2,
              },
            },
            lualine_z = {
              {
                'location',
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ' '},
                left_padding = 2,
              },
              {
                'datetime',
                style = '%H:%M',
                color = { fg = colors.fg_alt },
                separator = { left = '', right = ''},
                left_padding = 2,
              },
            },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = { 'nvim-tree', 'trouble', 'lazy', 'toggleterm' },
        }
      end

      -- Beautiful custom theme
      local function beautiful_theme()
        return {
          normal = {
            a = { fg = colors.bg, bg = colors.accent1, gui = 'bold' },
            b = { fg = colors.fg_alt, bg = colors.bg_light },
            c = { fg = colors.fg, bg = colors.bg_alt },
          },
          insert = {
            a = { fg = colors.bg, bg = colors.accent4, gui = 'bold' },
          },
          visual = {
            a = { fg = colors.bg, bg = colors.accent2, gui = 'bold' },
          },
          replace = {
            a = { fg = colors.bg, bg = colors.accent5, gui = 'bold' },
          },
          command = {
            a = { fg = colors.bg, bg = colors.accent3, gui = 'bold' },
          },
          inactive = {
            a = { fg = colors.fg_dark, bg = colors.bg_alt },
            b = { fg = colors.fg_dark, bg = colors.bg_alt },
            c = { fg = colors.fg_dark, bg = colors.bg_alt },
          },
        }
      end

      config.options.theme = beautiful_theme()
      
      lualine.setup(config)
    end,
  },
} 