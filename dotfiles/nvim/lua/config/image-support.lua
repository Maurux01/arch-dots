-- Image and SVG Support Configuration
local M = {}

-- Function to setup image support
function M.setup()
    -- Configure image.nvim
    require("image").setup({
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
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
    })

    -- Configure markdown preview
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_auto_start = false
    vim.g.mkdp_auto_close = true
    vim.g.mkdp_refresh_slow = false
    vim.g.mkdp_command_for_global = false
    vim.g.mkdp_open_to_the_world = false
    vim.g.mkdp_open_ip = ""
    vim.g.mkdp_echo_preview_url = false
    vim.g.mkdp_browserfunc = ""
    vim.g.mkdp_preview_options = {
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
    }
    vim.g.mkdp_markdown_css = ""
    vim.g.mkdp_highlight_css = ""
    vim.g.mkdp_port = ""
    vim.g.mkdp_page_title = "「${name}」"

    -- Configure image paste
    vim.g.image_paste_backend = "kitty"
    vim.g.image_paste_download_images = true
    vim.g.image_paste_download_dir = "~/.local/share/nvim/images"
    vim.g.image_paste_image_dir = "~/.local/share/nvim/images"
    vim.g.image_paste_image_name_template = "{timestamp}_{random_string}"
    vim.g.image_paste_image_extension = "png"
    vim.g.image_paste_image_quality = 90
    vim.g.image_paste_image_format = "png"
    vim.g.image_paste_image_max_width = 1920
    vim.g.image_paste_image_max_height = 1080
    vim.g.image_paste_image_resize = true
    vim.g.image_paste_image_resize_algorithm = "lanczos"
    vim.g.image_paste_image_resize_filter = "lanczos"
    vim.g.image_paste_image_resize_sampling = 1
    vim.g.image_paste_image_resize_interpolation = "lanczos"
    vim.g.image_paste_image_resize_quality = 90
    vim.g.image_paste_image_resize_format = "png"
    vim.g.image_paste_image_resize_extension = "png"
    vim.g.image_paste_image_resize_name_template = "{original_name}_resized"
    vim.g.image_paste_image_resize_dir = "~/.local/share/nvim/images/resized"
    vim.g.image_paste_image_resize_backup = true
    vim.g.image_paste_image_resize_backup_dir = "~/.local/share/nvim/images/backup"
    vim.g.image_paste_image_resize_backup_format = "png"
    vim.g.image_paste_image_resize_backup_extension = "png"
    vim.g.image_paste_image_resize_backup_name_template = "{original_name}_backup"
    vim.g.image_paste_image_resize_backup_quality = 90
    vim.g.image_paste_image_resize_backup_interpolation = "lanczos"
    vim.g.image_paste_image_resize_backup_sampling = 1
    vim.g.image_paste_image_resize_backup_filter = "lanczos"
    vim.g.image_paste_image_resize_backup_algorithm = "lanczos"
    vim.g.image_paste_image_resize_backup_max_width = 1920
    vim.g.image_paste_image_resize_backup_max_height = 1080
    vim.g.image_paste_image_resize_backup_resize = true
    vim.g.image_paste_image_resize_backup_resize_algorithm = "lanczos"
    vim.g.image_paste_image_resize_backup_resize_filter = "lanczos"
    vim.g.image_paste_image_resize_backup_resize_sampling = 1
    vim.g.image_paste_image_resize_backup_resize_interpolation = "lanczos"
    vim.g.image_paste_image_resize_backup_resize_quality = 90
    vim.g.image_paste_image_resize_backup_resize_format = "png"
    vim.g.image_paste_image_resize_backup_resize_extension = "png"
    vim.g.image_paste_image_resize_backup_resize_name_template = "{original_name}_backup_resized"
    vim.g.image_paste_image_resize_backup_resize_dir = "~/.local/share/nvim/images/backup/resized"

    -- Create directories for images
    vim.fn.mkdir(vim.fn.expand("~/.local/share/nvim/images"), "p")
    vim.fn.mkdir(vim.fn.expand("~/.local/share/nvim/images/resized"), "p")
    vim.fn.mkdir(vim.fn.expand("~/.local/share/nvim/images/backup"), "p")
    vim.fn.mkdir(vim.fn.expand("~/.local/share/nvim/images/backup/resized"), "p")

    -- Add filetype detection for images
    vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*.png,*.jpg,*.jpeg,*.gif,*.webp,*.svg",
        callback = function()
            vim.bo.filetype = "image"
        end,
    })

    -- Add filetype detection for SVG
    vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*.svg",
        callback = function()
            vim.bo.filetype = "svg"
        end,
    })

    print("Image and SVG support configured successfully!")
end

-- Initialize image support
M.setup()

return M 