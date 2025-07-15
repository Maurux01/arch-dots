return {
  -- Image support for Neovim
  {
    "3rd/image.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = true,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    },
    keys = {
      { "<leader>ii", "<cmd>ImageInfo<cr>", desc = "Show image info" },
      { "<leader>ir", "<cmd>ImageReload<cr>", desc = "Reload image" },
      { "<leader>ic", "<cmd>ImageClear<cr>", desc = "Clear image" },
    },
  },

  -- SVG support and preview
  {
    "mhinz/vim-startify",
    config = function()
      -- tu configuración aquí, por ejemplo:
      vim.g.startify_bookmarks = {
        { i = "~/.config/nvim/init.lua", desc = "Neovim config" },
        { i = "~/.config/hypr/hyprland.conf", desc = "Hyprland config" },
      }
    end,
  },

  -- Markdown image preview
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    opts = {
      mkdp_filetypes = { "markdown" },
      mkdp_theme = "dark",
      mkdp_auto_start = false,
      mkdp_auto_close = true,
      mkdp_refresh_slow = false,
      mkdp_command_for_global = false,
      mkdp_open_to_the_world = false,
      mkdp_open_ip = "",
      mkdp_echo_preview_url = false,
      mkdp_browserfunc = "",
      mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = false,
        sync_scroll_type = "middle",
        hide_yaml_meta = true,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = false,
        toc = {},
      },
      mkdp_markdown_css = "",
      mkdp_highlight_css = "",
      mkdp_port = "",
      mkdp_page_title = "「${name}」",
      mkdp_filetypes = { "markdown" },
    },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop preview" },
      { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle preview" },
    },
  },

  -- Image paste support
  {
    "evanpurkhiser/image-paste.nvim",
    opts = {
      default_options = {
        backend = "kitty",
        download_images = true,
        download_dir = "~/.local/share/nvim/images",
        image_dir = "~/.local/share/nvim/images",
        image_name_template = "{timestamp}_{random_string}",
        image_extension = "png",
        image_quality = 90,
        image_format = "png",
        image_max_width = 1920,
        image_max_height = 1080,
        image_resize = true,
        image_resize_algorithm = "lanczos",
        image_resize_filter = "lanczos",
        image_resize_sampling = 1,
        image_resize_interpolation = "lanczos",
        image_resize_quality = 90,
        image_resize_format = "png",
        image_resize_extension = "png",
        image_resize_name_template = "{original_name}_resized",
        image_resize_dir = "~/.local/share/nvim/images/resized",
        image_resize_backup = true,
        image_resize_backup_dir = "~/.local/share/nvim/images/backup",
        image_resize_backup_format = "png",
        image_resize_backup_extension = "png",
        image_resize_backup_name_template = "{original_name}_backup",
        image_resize_backup_quality = 90,
        image_resize_backup_interpolation = "lanczos",
        image_resize_backup_sampling = 1,
        image_resize_backup_filter = "lanczos",
        image_resize_backup_algorithm = "lanczos",
        image_resize_backup_max_width = 1920,
        image_resize_backup_max_height = 1080,
        image_resize_backup_resize = true,
        image_resize_backup_resize_algorithm = "lanczos",
        image_resize_backup_resize_filter = "lanczos",
        image_resize_backup_resize_sampling = 1,
        image_resize_backup_resize_interpolation = "lanczos",
        image_resize_backup_resize_quality = 90,
        image_resize_backup_resize_format = "png",
        image_resize_backup_resize_extension = "png",
        image_resize_backup_resize_name_template = "{original_name}_backup_resized",
        image_resize_backup_resize_dir = "~/.local/share/nvim/images/backup/resized",
      },
    },
    keys = {
      { "<leader>ip", "<cmd>ImagePaste<cr>", desc = "Paste image" },
      { "<leader>id", "<cmd>ImageDownload<cr>", desc = "Download image" },
      { "<leader>is", "<cmd>ImageSave<cr>", desc = "Save image" },
    },
  },

  -- SVG support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "python",
        "bash",
        "rust",
        "go",
        "xml",  -- For SVG support
      },
    },
  },

  -- File type detection for images
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
  },
} 