-- Test script para verificar el dashboard
-- Ejecutar con: nvim --headless -l test-dashboard.lua

-- Verificar si el plugin está instalado
local ok, dashboard = pcall(require, "dashboard")
if not ok then
  print("❌ Error: No se puede cargar el plugin dashboard-nvim")
  print("   Asegúrate de que esté instalado correctamente")
  os.exit(1)
end

print("✅ Plugin dashboard-nvim cargado correctamente")

-- Verificar configuración
local config = dashboard.get_config()
if config then
  print("✅ Configuración del dashboard encontrada")
  print("   Tema: " .. (config.theme or "no configurado"))
else
  print("❌ No se encontró configuración del dashboard")
end

-- Verificar dependencias
local ok_icons, _ = pcall(require, "nvim-web-devicons")
if ok_icons then
  print("✅ Dependencia nvim-web-devicons cargada")
else
  print("❌ Error: nvim-web-devicons no está disponible")
end

print("\n🎯 Para probar el dashboard:")
print("   1. Abre Neovim sin argumentos: nvim")
print("   2. El dashboard debería aparecer automáticamente")
print("   3. Si no aparece, ejecuta: :Dashboard")
print("   4. Para forzar la recarga: :Lazy sync") 