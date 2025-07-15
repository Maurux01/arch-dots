-- Test script para verificar el dashboard
-- Ejecutar con: nvim --headless -l test-dashboard.lua

print("🔍 Diagnóstico del Dashboard...")

-- Verificar si el plugin se puede cargar
local ok, dashboard = pcall(require, "dashboard")
if not ok then
  print("❌ Error: No se puede cargar el plugin dashboard-nvim")
  print("   Error:", dashboard)
  os.exit(1)
else
  print("✅ Plugin dashboard-nvim cargado correctamente")
end

-- Verificar configuración
local config = dashboard.get_config()
if config then
  print("✅ Configuración del dashboard encontrada")
  print("   Tema:", config.theme or "no especificado")
else
  print("❌ No se encontró configuración del dashboard")
end

-- Verificar comandos disponibles
local has_dashboard_cmd = vim.fn.exists(":Dashboard") > 0
if has_dashboard_cmd then
  print("✅ Comando :Dashboard disponible")
else
  print("❌ Comando :Dashboard no disponible")
end

-- Verificar plugins cargados
local lazy_stats = require("lazy").stats()
print("📊 Plugins cargados:", lazy_stats.count)
print("⏱️  Tiempo de carga:", string.format("%.2fms", lazy_stats.startuptime * 1000))

print("\n🎯 Para probar el dashboard:")
print("   1. Ejecuta: nvim")
print("   2. El dashboard debería aparecer automáticamente")
print("   3. Si no aparece, ejecuta: :Dashboard")
print("   4. O usa el atajo: <leader>d") 