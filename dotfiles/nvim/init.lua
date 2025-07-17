-- Modern IDE Neovim Configuration
-- Carga modular y sin errores

-- Opciones y variables globales
require("config.options")

-- Bootstrap Lazy.nvim y plugins
require("config.lazy")

-- Configuración modular
require("config.theme-toggle")
require("config.capture-utils")
require("config.telescope")
require("config.image-support")
require("config.autocmds")
require("config.performance")
require("config.cursor-highlights")

-- (Opcional) Colores personalizados para indentación rainbow
pcall(require, "config.indent-colors")

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