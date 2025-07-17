-- Modern IDE Neovim Configuration
-- Carga modular y sin errores

local function safe_require(mod)
  local ok, result = pcall(require, mod)
  if not ok then
    vim.schedule(function()
      vim.notify('Error cargando módulo: '..mod..'\n'..result, vim.log.levels.ERROR)
    end)
  end
  return result
end

-- Opciones y variables globales
safe_require("config.options")

-- Bootstrap Lazy.nvim y plugins
safe_require("config.lazy")

-- Configuración modular (cargar después de Lazy)
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
        -- Cargar configuraciones después de que los plugins estén listos
        safe_require("config.theme-toggle")
        safe_require("config.capture-utils")
        
        -- Cargar telescope con setup
        local telescope = safe_require("config.telescope")
        if telescope and telescope.setup then
            telescope.setup()
        end
        
        -- Cargar image-support con setup
        local image = safe_require("config.image-support")
        if image and image.setup then
            image.setup()
        end
        
        safe_require("config.autocmds")
        safe_require("config.performance")
        safe_require("config.cursor-highlights")
        
        -- (Opcional) Colores personalizados para indentación rainbow
        safe_require("config.indent-colors")
    end,
    once = true,
})

-- Cargar configuraciones básicas inmediatamente (que no dependen de plugins)
safe_require("config.autocmds")
safe_require("config.performance")

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