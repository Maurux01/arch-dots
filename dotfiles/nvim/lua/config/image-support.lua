-- Image and SVG Support Configuration
-- Provides image and SVG preview and paste support for Neovim
local M = {}

function M.setup()
    -- Detect available backends
    local backends = {}
    
    -- Check for ueberzug
    if vim.fn.executable("ueberzug") == 1 then
        table.insert(backends, "ueberzug")
    end
    
    -- Check for kitty
    if vim.fn.executable("kitten") == 1 then
        table.insert(backends, "kitty")
    end
    
    -- Check for wezterm
    if vim.fn.executable("wezterm") == 1 then
        table.insert(backends, "wezterm")
    end
    
    -- Use the first available backend, or disable if none available
    local backend = backends[1] or "none"
    
    -- Setup image.nvim only if a backend is available
    if backend ~= "none" then
        local image_ok, image = pcall(require, "image")
        if image_ok then
            image.setup({
                backend = backend,
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
            
            print("Image support configured with backend: " .. backend)
        else
            print("⚠️  Image.nvim plugin not loaded yet")
        end
    else
        print("No image backend available. Image support disabled.")
        print("Install ueberzug, kitty, or wezterm for image support.")
    end

    -- Markdown preview plugin configuration
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
    vim.g.mkdp_page_title = " 1${name} 7"

    -- Image paste configuration
    vim.g.image_paste_backend = backend
    vim.g.image_paste_download_images = true
    local img_dir = vim.fn.expand("~/.local/share/nvim/images")
    local img_dir_resized = img_dir .. "/resized"
    local img_dir_backup = img_dir .. "/backup"
    local img_dir_backup_resized = img_dir_backup .. "/resized"
    vim.g.image_paste_download_dir = img_dir
    vim.g.image_paste_image_dir = img_dir
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
    vim.g.image_paste_image_resize_dir = img_dir_resized
    vim.g.image_paste_image_resize_backup = true
    vim.g.image_paste_image_resize_backup_dir = img_dir_backup
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
    vim.g.image_paste_image_resize_backup_resize_dir = img_dir_backup_resized

    -- Ensure directories exist before using them
    for _, dir in ipairs({img_dir, img_dir_resized, img_dir_backup, img_dir_backup_resized}) do
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end

    -- Filetype detection for images
    vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*.png,*.jpg,*.jpeg,*.gif,*.webp,*.svg",
        callback = function()
            vim.bo.filetype = "image"
        end,
    })
    vim.api.nvim_create_autocmd("BufRead", {
        pattern = "*.svg",
        callback = function()
            vim.bo.filetype = "svg"
        end,
    })

    print("Image and SVG support configured successfully!")
end

return M 