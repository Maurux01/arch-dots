-- Script de diagnóstico para plugins de Neovim
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
end

-- Ejecutar diagnóstico
check_plugins() 