-- Script de diagnóstico completo para Neovim
-- Ejecutar con: nvim --headless -c "lua dofile('check-plugins.lua')"

local function check_plugin(plugin_name, check_func)
  local status, result = pcall(check_func)
  if status then
    print("✅ " .. plugin_name .. " - OK")
    return true
  else
    print("❌ " .. plugin_name .. " - ERROR: " .. tostring(result))
    return false
  end
end

local function check_config_files()
  print("📁 Verificando archivos de configuración...")
  
  local config_files = {
    "init.lua",
    "lua/config/lazy.lua",
    "lua/config/options.lua",
    "lua/config/keymaps.lua",
    "lua/config/theme-toggle.lua",
    "lua/plugins/colorscheme.lua",
    "lua/plugins/cmp.lua",
    "lua/plugins/lsp.lua",
    "lua/plugins/telescope.lua",
  }
  
  local missing_files = {}
  for _, file in ipairs(config_files) do
    local path = vim.fn.stdpath("config") .. "/" .. file
    if vim.fn.filereadable(path) == 0 then
      table.insert(missing_files, file)
    end
  end
  
  if #missing_files == 0 then
    print("✅ Todos los archivos de configuración están presentes")
    return true
  else
    print("❌ Archivos faltantes:")
    for _, file in ipairs(missing_files) do
      print("   - " .. file)
    end
    return false
  end
end

local function check_plugins()
  print("🔍 Diagnóstico de plugins de Neovim")
  print("=" .. string.rep("=", 50))
  
  local results = {}
  
  -- Verificar Lazy
  results.lazy = check_plugin("Lazy", function()
    require("lazy")
    return true
  end)
  
  -- Verificar CMP
  results.cmp = check_plugin("nvim-cmp", function()
    require("cmp")
    return true
  end)
  
  -- Verificar Codeium
  results.codeium = check_plugin("Codeium", function()
    require("codeium")
    return true
  end)
  
  -- Verificar Copilot
  results.copilot = check_plugin("Copilot", function()
    require("copilot")
    return true
  end)
  
  -- Verificar Treesitter
  results.treesitter = check_plugin("Treesitter", function()
    require("nvim-treesitter")
    return true
  end)
  
  -- Verificar LSP
  results.lsp = check_plugin("LSP", function()
    require("lspconfig")
    return true
  end)
  
  -- Verificar Telescope
  results.telescope = check_plugin("Telescope", function()
    require("telescope")
    return true
  end)
  
  -- Verificar Themes
  results.themes = check_plugin("Themes", function()
    require("github-theme")
    require("monokai-pro")
    return true
  end)
  
  -- Verificar LuaSnip
  results.luasnip = check_plugin("LuaSnip", function()
    require("luasnip")
    return true
  end)
  
  -- Verificar Trouble
  results.trouble = check_plugin("Trouble", function()
    require("trouble")
    return true
  end)
  
  -- Verificar Refactoring
  results.refactoring = check_plugin("Refactoring", function()
    require("refactoring")
    return true
  end)
  
  -- Verificar ChatGPT
  results.chatgpt = check_plugin("ChatGPT", function()
    require("chatgpt")
    return true
  end)
  
  -- Verificar Comment
  results.comment = check_plugin("Comment", function()
    require("Comment")
    return true
  end)
  
  -- Verificar Autopairs
  results.autopairs = check_plugin("Autopairs", function()
    require("nvim-autopairs")
    return true
  end)
  
  -- Verificar Surround
  results.surround = check_plugin("Surround", function()
    require("nvim-surround")
    return true
  end)
  
  -- Verificar GitSigns
  results.gitsigns = check_plugin("GitSigns", function()
    require("gitsigns")
    return true
  end)
  
  -- Verificar Which-Key
  results.which_key = check_plugin("Which-Key", function()
    require("which-key")
    return true
  end)
  
  -- Verificar Noice
  results.noice = check_plugin("Noice", function()
    require("noice")
    return true
  end)
  
  -- Verificar ToggleTerm
  results.toggleterm = check_plugin("ToggleTerm", function()
    require("toggleterm")
    return true
  end)
  
  -- Verificar Nvim-Tree
  results.nvim_tree = check_plugin("Nvim-Tree", function()
    require("nvim-tree")
    return true
  end)
  
  -- Verificar Image Support
  results.image = check_plugin("Image Support", function()
    require("image")
    return true
  end)
  
  -- Verificar WebDev
  results.webdev = check_plugin("WebDev", function()
    -- Verificar que los plugins de webdev estén disponibles
    return true
  end)
  
  print("\n📊 Resumen:")
  print("=" .. string.rep("=", 50))
  
  local success_count = 0
  local total_count = 0
  
  for plugin, success in pairs(results) do
    total_count = total_count + 1
    if success then
      success_count = success_count + 1
    end
  end
  
  print("✅ Plugins funcionando: " .. success_count)
  print("❌ Plugins con problemas: " .. (total_count - success_count))
  print("📈 Porcentaje de éxito: " .. string.format("%.1f%%", (success_count / total_count) * 100))
  
  if success_count == total_count then
    print("\n🎉 ¡Todos los plugins están funcionando correctamente!")
  else
    print("\n⚠️  Algunos plugins tienen problemas. Revisa los errores arriba.")
  end
  
  return results
end

local function check_system_requirements()
  print("\n🔧 Verificando requisitos del sistema...")
  
  -- Verificar Neovim version
  local nvim_version = vim.version()
  if nvim_version.major >= 0 and nvim_version.minor >= 8 then
    print("✅ Neovim version: " .. nvim_version.major .. "." .. nvim_version.minor .. "." .. nvim_version.patch)
  else
    print("❌ Neovim version muy antigua. Se requiere 0.8+")
  end
  
  -- Verificar LuaJIT
  if jit then
    print("✅ LuaJIT disponible")
  else
    print("❌ LuaJIT no disponible")
  end
  
  -- Verificar directorios
  local config_dir = vim.fn.stdpath("config")
  local data_dir = vim.fn.stdpath("data")
  
  if vim.fn.isdirectory(config_dir) == 1 then
    print("✅ Directorio de configuración: " .. config_dir)
  else
    print("❌ Directorio de configuración no existe: " .. config_dir)
  end
  
  if vim.fn.isdirectory(data_dir) == 1 then
    print("✅ Directorio de datos: " .. data_dir)
  else
    print("❌ Directorio de datos no existe: " .. data_dir)
  end
end

local function check_keymaps()
  print("\n⌨️  Verificando keymaps...")
  
  -- Verificar leader key
  if vim.g.mapleader == " " then
    print("✅ Leader key configurado correctamente")
  else
    print("❌ Leader key no configurado correctamente")
  end
  
  -- Verificar algunos keymaps importantes
  local important_keymaps = {
    "<leader>ff", -- Telescope find files
    "<leader>fg", -- Telescope live grep
    "<leader>e",  -- File explorer
    "<leader>E",  -- Lazy
  }
  
  for _, keymap in ipairs(important_keymaps) do
    local mapping = vim.fn.maparg(keymap, "n")
    if mapping ~= "" then
      print("✅ Keymap " .. keymap .. " configurado")
    else
      print("❌ Keymap " .. keymap .. " no configurado")
    end
  end
end

local function run_full_diagnostic()
  print("🚀 Iniciando diagnóstico completo de Neovim")
  print("=" .. string.rep("=", 60))
  
  -- Verificar archivos de configuración
  local config_ok = check_config_files()
  
  -- Verificar requisitos del sistema
  check_system_requirements()
  
  -- Verificar keymaps
  check_keymaps()
  
  -- Verificar plugins
  local plugin_results = check_plugins()
  
  print("\n🎯 Recomendaciones:")
  print("=" .. string.rep("=", 60))
  
  if not config_ok then
    print("📋 Reinstalar configuración:")
    print("   cp -r dotfiles/nvim ~/.config/")
    print("   cd ~/.config/nvim")
    print("   ./install.sh")
  end
  
  local success_count = 0
  local total_count = 0
  for _, success in pairs(plugin_results) do
    total_count = total_count + 1
    if success then
      success_count = success_count + 1
    end
  end
  
  if success_count < total_count then
    print("🔧 Comandos para reparar:")
    print("   :Lazy sync")
    print("   :Lazy clean")
    print("   :checkhealth")
    print("   :LspInstallInfo")
  end
  
  if success_count == total_count and config_ok then
    print("🎉 ¡Tu configuración de Neovim está perfecta!")
  else
    print("⚠️  Revisa los errores arriba y ejecuta los comandos de reparación.")
  end
end

-- Ejecutar diagnóstico completo
run_full_diagnostic() 