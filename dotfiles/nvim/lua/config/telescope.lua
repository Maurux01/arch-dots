-- =============================================================================
-- TELESCOPE CONFIGURATION - Custom file finder
-- =============================================================================

local telescope = require('telescope')
local actions = require('telescope.actions')

-- Custom file finder that slides from the right
local function custom_file_finder()
  telescope.extensions.file_browser.file_browser({
    path = vim.fn.expand('%:p:h'),
    cwd = vim.fn.getcwd(),
    dir_icon = "📁",
    dir_icon_hl = "Directory",
    display_stat = { date = true },
    git_status = true,
    use_fd = true,
    respect_gitignore = true,
    hidden = true,
    grouped = true,
    initial_mode = "normal",
    layout_config = {
      width = 0.85,
      height = 0.95,
      preview_cutoff = 120,
      prompt_position = "top",
      horizontal = {
        preview_width = 0.65,
        results_width = 0.35,
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
      anchor = "E", -- Anchor to the right side
      placement = "E", -- Place on the right side
    },
    layout_strategy = "horizontal",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    color_devicons = true,
    set_env = { COLORTERM = "truecolor" },
    file_ignore_patterns = {
      "node_modules",
      ".git",
      ".cache",
      "dist",
      "build",
      "*.pyc",
      "__pycache__",
      ".DS_Store",
    },
    attach_mappings = function(prompt_bufnr, map)
      local function set_prompt_to_entry_value()
        local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
        local current_line = vim.api.nvim_win_get_cursor(0)[1]
        vim.api.nvim_buf_set_lines(0, current_line - 1, current_line, false, { entry.value })
      end

      map("i", "<c-t>", set_prompt_to_entry_value)
      map("i", "<c-v>", actions.select_vertical)
      map("i", "<c-s>", actions.select_horizontal)
      map("i", "<c-t>", actions.select_tab)
      map("i", "<c-y>", actions.preview_scrolling_up)
      map("i", "<c-e>", actions.preview_scrolling_down)
      map("i", "<c-u>", actions.results_scrolling_up)
      map("i", "<c-d>", actions.results_scrolling_down)

      return true
    end,
  })
end

-- Alternative: Simple file finder with right-side layout
local function simple_file_finder()
  telescope.find_files({
    layout_config = {
      width = 0.8,
      height = 0.9,
      anchor = "E", -- Anchor to the right
      placement = "E", -- Place on the right
      horizontal = {
        preview_width = 0.6,
        results_width = 0.4,
        mirror = false,
      },
    },
    layout_strategy = "horizontal",
    find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden" },
    file_ignore_patterns = {
      "node_modules",
      ".git",
      ".cache",
      "dist",
      "build",
      "*.pyc",
      "__pycache__",
      ".DS_Store",
    },
  })
end

-- Register the custom functions
vim.api.nvim_create_user_command('FileFinder', custom_file_finder, {})
vim.api.nvim_create_user_command('SimpleFileFinder', simple_file_finder, {})

-- Configure telescope defaults
telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "❯ ",
    path_display = { "truncate" },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    color_devicons = true,
    set_env = { COLORTERM = "truecolor" },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },
      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      hidden = true,
      no_ignore = false,
      no_ignore_parent = false,
      layout_config = {
        width = 0.8,
        height = 0.9,
        anchor = "E",
        placement = "E",
        horizontal = {
          preview_width = 0.6,
          results_width = 0.4,
          mirror = false,
        },
      },
    },
    live_grep = {
      additional_args = function()
        return { "--hidden" }
      end,
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<C-w>"] = function()
            vim.cmd('normal vbd')
          end,
        },
        ["n"] = {
          ["N"] = require("telescope").extensions.file_browser.actions.create,
          ["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end,
        },
      },
    },
  },
})

-- Load extensions
telescope.load_extension("file_browser") 