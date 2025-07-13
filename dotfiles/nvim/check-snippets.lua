-- check-snippets.lua
-- Script de diagnóstico para verificar y limpiar snippets duplicados

local function check_snippets()
  print("🔍 Verificando snippets duplicados...")
  
  local ls = require("luasnip")
  local snippets = ls.snippets
  
  local total_snippets = 0
  local duplicate_snippets = 0
  local cleaned_snippets = 0
  
  for filetype, ft_snippets in pairs(snippets) do
    print("\n📁 Filetype: " .. filetype)
    
    local seen = {}
    local unique_snippets = {}
    local duplicates = {}
    
    for name, snippet in pairs(ft_snippets) do
      local key = snippet.trigger or name
      total_snippets = total_snippets + 1
      
      if seen[key] then
        duplicate_snippets = duplicate_snippets + 1
        table.insert(duplicates, { name = name, trigger = key })
        print("  ❌ Duplicado: " .. name .. " (trigger: " .. key .. ")")
      else
        seen[key] = true
        unique_snippets[name] = snippet
      end
    end
    
    -- Limpiar duplicados
    if #duplicates > 0 then
      print("  🧹 Limpiando " .. #duplicates .. " duplicados...")
      ls.snippets[filetype] = unique_snippets
      cleaned_snippets = cleaned_snippets + #duplicates
    else
      print("  ✅ Sin duplicados")
    end
  end
  
  print("\n" .. "=" .. string.rep("=", 50))
  print("📊 RESUMEN DE SNIPPETS")
  print("=" .. string.rep("=", 50))
  print("Total de snippets: " .. total_snippets)
  print("Duplicados encontrados: " .. duplicate_snippets)
  print("Duplicados limpiados: " .. cleaned_snippets)
  print("Snippets únicos restantes: " .. (total_snippets - cleaned_snippets))
  
  if cleaned_snippets > 0 then
    print("\n✅ Snippets duplicados limpiados exitosamente!")
  else
    print("\n✅ No se encontraron duplicados.")
  end
end

local function check_cmp_sources()
  print("\n🔍 Verificando fuentes de CMP...")
  
  local cmp = require("cmp")
  local sources = cmp.get_config().sources
  
  print("Fuentes configuradas:")
  for i, source in ipairs(sources) do
    print("  " .. i .. ". " .. source.name .. " (prioridad: " .. source.priority .. ", max: " .. (source.max_item_count or "∞") .. ")")
  end
end

local function test_completion()
  print("\n🧪 Probando completación...")
  
  -- Simular completación para verificar duplicados
  local cmp = require("cmp")
  local entries = {}
  
  -- Simular entradas de diferentes fuentes
  local test_entries = {
    { label = "h2", source = "luasnip" },
    { label = "h2", source = "nvim_lsp" },
    { label = "div", source = "luasnip" },
    { label = "div", source = "copilot" },
    { label = "console.log", source = "codeium" },
    { label = "console.log", source = "nvim_lsp" },
  }
  
  for _, entry in ipairs(test_entries) do
    table.insert(entries, {
      completion_item = { label = entry.label },
      source = { name = entry.source }
    })
  end
  
  print("Entradas de prueba:")
  for i, entry in ipairs(entries) do
    print("  " .. i .. ". " .. entry.completion_item.label .. " [" .. entry.source.name .. "]")
  end
  
  -- Aplicar deduplicación
  local seen = {}
  local unique_entries = {}
  
  for _, entry in ipairs(entries) do
    local key = entry.completion_item.label
    if not seen[key] then
      seen[key] = true
      table.insert(unique_entries, entry)
    end
  end
  
  print("\nEntradas únicas después de deduplicación:")
  for i, entry in ipairs(unique_entries) do
    print("  " .. i .. ". " .. entry.completion_item.label .. " [" .. entry.source.name .. "]")
  end
end

local function show_help()
  print([[
🔧 DIAGNÓSTICO DE SNIPPETS

Comandos disponibles:
  :lua require("check-snippets").check_snippets()     - Verificar y limpiar duplicados
  :lua require("check-snippets").check_cmp_sources()  - Verificar fuentes de CMP
  :lua require("check-snippets").test_completion()    - Probar completación
  :lua require("check-snippets").show_help()          - Mostrar esta ayuda

Problemas comunes:
  - Snippets duplicados en HTML (h1, h2, div, etc.)
  - Múltiples sugerencias para la misma función
  - Spam de completación de AI

Soluciones aplicadas:
  ✅ Deduplicación automática
  ✅ Límites en fuentes de AI
  ✅ Desactivación de autosnippets
  ✅ Priorización inteligente
  ✅ Filtros por tipo de archivo
]])
end

-- Exportar funciones
return {
  check_snippets = check_snippets,
  check_cmp_sources = check_cmp_sources,
  test_completion = test_completion,
  show_help = show_help,
} 