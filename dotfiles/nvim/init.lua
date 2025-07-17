-- Modern IDE Neovim Configuration
-- Carga modular y sin errores

-- Opciones y variables globales
pcall(require, "config.options")

-- Bootstrap Lazy.nvim y plugins
pcall(require, "config.lazy")

-- Configuración modular (cargar después de Lazy)
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
        -- Cargar configuraciones después de que los plugins estén listos
        pcall(require, "config.theme-toggle")
        pcall(require, "config.capture-utils")
        
        -- Cargar telescope con setup
        local telescope_ok, telescope = pcall(require, "config.telescope")
        if telescope_ok then
            telescope.setup()
        end
        
        -- Cargar image-support con setup
        local image_ok, image = pcall(require, "config.image-support")
        if image_ok then
            image.setup()
        end
        
        pcall(require, "config.autocmds")
        pcall(require, "config.performance")
        pcall(require, "config.cursor-highlights")
        
        -- (Opcional) Colores personalizados para indentación rainbow
        pcall(require, "config.indent-colors")
    end,
    once = true,
})

-- Cargar configuraciones básicas inmediatamente (que no dependen de plugins)
pcall(require, "config.autocmds")
pcall(require, "config.performance")

-- Mensaje de bienvenida moderno
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 then
            vim.defer_fn(function()
                print("🚀 Bienvenido a tu Modern Neovim IDE!")
                print("📁 <leader>f para buscar archivos")
                print("🔍 <leader>g para buscar en archivos")
                print("📋 <C-\\> para terminal integrada")
                print("🎨 <leader>1/2/3 para cambiar de tema")
                print("❓ <leader>? para ayuda")
            end, 100)
        end
    end,
    nested = true,
}) 