-- lua/plugins/lualine.lua
-- Unified Lualine configuration with comprehensive features and animations
return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local lualine = require('lualine')
      
      -- Colors for different modes
      local colors = {
        blue = '#61afef',
        green = '#98c379',
        purple = '#c678dd',
        red1 = '#e06c75',
        red2 = '#be5046',
        yellow = '#e5c07b',
        gray1 = '#5c6370',
        gray2 = '#2c323c',
        gray3 = '#3e4452',
      }

      -- Custom components
      local function get_lsp_name()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
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
        return string.format('%.1f%s', size, suffixes[i])
      end

      local function get_cursor_position()
        local line = vim.fn.line('.')
        local col = vim.fn.col('.')
        local total_lines = vim.fn.line('$')
        return string.format('%d:%d/%d', line, col, total_lines)
      end

      -- Choose configuration style (complete or minimal)
      local use_minimal = false -- Set to true for minimal style
      
      local config
      if use_minimal then
        -- Minimal configuration
        config = {
          options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '|', right = '|'},
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
              }
            },
            lualine_b = {
              {
                get_git_branch,
                color = { fg = colors.purple },
              },
              {
                'diff',
                symbols = { added = ' 󰐕', modified = ' 󰆓', removed = ' 󰩺' },
                color = { fg = colors.gray },
              },
              {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' 󰅚', warn = ' 󰀪', info = ' 󰋼', hint = ' 󰌵' },
                color = { fg = colors.gray },
              },
            },
            lualine_c = {
              {
                'filename',
                file_status = true,
                path = 1,
                symbols = {
                  modified = ' ●',
                  readonly = ' 󰀾',
                  unnamed = '[No Name]',
                  newfile = '[New]',
                }
              },
              {
                get_lsp_name,
                icon = ' 󰒋',
                color = { fg = colors.blue },
              },
            },
            lualine_x = {
              {
                'encoding',
                separator = { left = '', right = ''},
                right_padding = 2,
              },
              {
                'filetype',
                separator = { left = '', right = ''},
                right_padding = 2,
              },
            },
            lualine_y = {
              {
                'progress',
                separator = { left = '', right = ''},
                left_padding = 2,
              },
            },
            lualine_z = {
              {
                'location',
                separator = { left = '', right = ''},
                left_padding = 2,
              },
              {
                'datetime',
                style = '%H:%M',
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
      else
        -- Complete configuration
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
              }
            },
            lualine_b = {
              {
                'b:gitsigns_head',
                icon = ' 󰘬',
                color = { fg = colors.purple },
              },
              {
                'diff',
                symbols = { added = ' 󰐕 ', modified = ' 󰆓 ', removed = ' 󰩺 ' },
                color = { fg = colors.gray1 },
              },
              {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' 󰅚 ', warn = ' 󰀪 ', info = ' 󰋼 ', hint = ' 󰌵 ' },
                color = { fg = colors.gray1 },
              },
            },
            lualine_c = {
              {
                'filename',
                file_status = true,
                path = 1,
                symbols = {
                  modified = ' ●',
                  readonly = ' 󰀾',
                  unnamed = '[No Name]',
                  newfile = '[New]',
                }
              },
              {
                get_lsp_name,
                icon = ' 󰒋',
                color = { fg = colors.blue },
              },
            },
            lualine_x = {
              {
                'encoding',
                separator = { left = '', right = ''},
                right_padding = 2,
              },
              {
                'fileformat',
                separator = { left = '', right = ''},
                right_padding = 2,
              },
              {
                'filetype',
                separator = { left = '', right = ''},
                right_padding = 2,
              },
              {
                get_file_size,
                separator = { left = '', right = ''},
                right_padding = 2,
              },
            },
            lualine_y = {
              {
                'progress',
                separator = { left = '', right = ''},
                left_padding = 2,
              },
              {
                get_cursor_position,
                separator = { left = '', right = ''},
                left_padding = 2,
              },
            },
            lualine_z = {
              {
                'location',
                separator = { left = '', right = ''},
                left_padding = 2,
              },
              {
                'datetime',
                style = '%H:%M',
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

      -- Customize colors for different modes
      local function custom_theme()
        return {
          normal = {
            a = { fg = colors.gray2, bg = colors.blue, gui = 'bold' },
            b = { fg = colors.gray1, bg = colors.gray3 },
            c = { fg = colors.gray1, bg = colors.gray3 },
          },
          insert = {
            a = { fg = colors.gray2, bg = colors.green, gui = 'bold' },
          },
          visual = {
            a = { fg = colors.gray2, bg = colors.purple, gui = 'bold' },
          },
          replace = {
            a = { fg = colors.gray2, bg = colors.red1, gui = 'bold' },
          },
          command = {
            a = { fg = colors.gray2, bg = colors.yellow, gui = 'bold' },
          },
          inactive = {
            a = { fg = colors.gray1, bg = 'NONE' },
            b = { fg = colors.gray1, bg = 'NONE' },
            c = { fg = colors.gray1, bg = 'NONE' },
          },
        }
      end

      config.options.theme = custom_theme()
      
      lualine.setup(config)
    end,
  },
} 