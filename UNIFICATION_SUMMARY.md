# 🚀 ARCH DOTS - UNIFICACIÓN DE SCRIPTS

## 📋 Resumen de Cambios

Se ha realizado una unificación completa de todos los scripts de instalación, desinstalación y mantenimiento en tres scripts principales:

### ✅ Scripts Unificados

1. **`install.sh`** - Instalador completo y unificado
2. **`uninstall.sh`** - Desinstalador completo con backup
3. **`repair.sh`** - Herramienta de reparación y mantenimiento

### 🗑️ Scripts Eliminados

Los siguientes scripts fueron eliminados y su funcionalidad integrada en los scripts unificados:

- `install-image-support.sh` → Integrado en `install.sh`
- `install-multimedia.sh` → Integrado en `install.sh`
- `fix-nvim.sh` → Integrado en `repair.sh`
- `fix-nvimx.sh` → Integrado en `repair.sh`
- `update-configs.sh` → Integrado en `repair.sh`
- `test-configs.sh` → Integrado en `repair.sh`

## 🔧 Funcionalidades de Cada Script

### 📦 `install.sh` - Instalador Unificado

**Características:**
- ✅ Instalación completa de Hyprland y componentes
- ✅ Instalación de paquetes core y AUR
- ✅ Configuración de herramientas multimedia (LMMS, Pixelorama, Upscayl)
- ✅ Soporte de imágenes en Neovim y Kitty
- ✅ Instalación de herramientas de captura de pantalla
- ✅ Configuración de fuentes personalizadas
- ✅ Copia de dotfiles a ubicaciones correctas
- ✅ Verificación completa de la instalación
- ✅ Configuración del sistema

**Uso:**
```bash
./install.sh
```

### 🗑️ `uninstall.sh` - Desinstalador Unificado

**Características:**
- ✅ Creación de backup completo antes de desinstalar
- ✅ Desinstalación de todos los paquetes (core + AUR)
- ✅ Eliminación de todas las configuraciones
- ✅ Restauración de configuraciones por defecto
- ✅ Limpieza completa del sistema
- ✅ Verificación de la desinstalación

**Uso:**
```bash
./uninstall.sh
```

### 🔧 `repair.sh` - Herramienta de Reparación

**Características:**
- ✅ **Diagnóstico** - Detecta paquetes faltantes, configuraciones y permisos
- ✅ **Reparación de paquetes** - Arregla paquetes rotos y AUR
- ✅ **Reparación de configuraciones** - Restaura configuraciones faltantes
- ✅ **Reparación de fuentes** - Reinstala fuentes personalizadas
- ✅ **Reparación de permisos** - Corrige permisos de archivos
- ✅ **Limpieza del sistema** - Limpia caché y archivos temporales
- ✅ **Limpieza de Neovim** - Limpia y reinstala plugins
- ✅ **Actualización del sistema** - Actualiza sistema y dotfiles
- ✅ **Verificación** - Verifica que todas las reparaciones fueron exitosas

**Opciones de uso:**
```bash
./repair.sh                    # Reparación completa
./repair.sh --diagnose         # Solo diagnosticar problemas
./repair.sh --repair           # Solo reparar problemas encontrados
./repair.sh --clean            # Solo limpiar sistema
./repair.sh --update           # Solo actualizar sistema y dotfiles
./repair.sh --info             # Mostrar información del sistema
./repair.sh --help             # Mostrar ayuda
```

## 🎯 Beneficios de la Unificación

### ✅ Ventajas

1. **Simplicidad** - Solo 3 scripts principales en lugar de 8+
2. **Consistencia** - Mismo estilo y estructura en todos los scripts
3. **Mantenimiento** - Más fácil de mantener y actualizar
4. **Documentación** - README actualizado con información clara
5. **Logging** - Todos los scripts generan logs detallados
6. **Verificación** - Verificación automática de todas las operaciones
7. **Backup** - Backup automático en desinstalación
8. **Modularidad** - Funciones organizadas por categorías

### 🔧 Mejoras Técnicas

1. **Estructura modular** - Funciones organizadas por secciones
2. **Manejo de errores** - Mejor manejo de errores y excepciones
3. **Logging detallado** - Logs con timestamps y niveles
4. **Verificación automática** - Verificación de éxito de operaciones
5. **Documentación inline** - Comentarios detallados en el código
6. **Colores en output** - Output colorido y fácil de leer
7. **Opciones flexibles** - Scripts con múltiples opciones de uso

## 📁 Estructura Final

```
arch-dots/
├── install.sh              # Instalador unificado
├── uninstall.sh            # Desinstalador unificado
├── repair.sh               # Herramienta de reparación
├── utils.sh                # Script de utilidades
├── make-executable.sh      # Script para hacer ejecutables
├── README.md               # Documentación principal
├── UNIFICATION_SUMMARY.md  # Este archivo
├── INTEGRATION_README.md   # Documentación de integración
├── LICENSE
└── dotfiles/               # Configuraciones
    ├── hypr/               # Hyprland
    ├── kitty/              # Terminal
    ├── nvim/               # Editor
    ├── fish/               # Shell
    ├── eww/                # Widgets
    ├── waybar/             # Barra de estado
    ├── wofi/               # Lanzador
    ├── mako/               # Notificaciones
    ├── swww/               # Daemon de wallpapers
    ├── hyprlock/           # Bloqueador de pantalla
    ├── fonts/              # Fuentes personalizadas
    ├── wallpapers/         # Colección de wallpapers
    ├── scripts/            # Scripts de utilidades
    └── ...
```

## 🚀 Uso Rápido

### Instalación
```bash
git clone https://github.com/mauruxu01/archriced.git
cd archriced
chmod +x install.sh uninstall.sh repair.sh utils.sh
./install.sh
```

### Desinstalación
```bash
./uninstall.sh
```

### Reparación
```bash
./repair.sh
```

### Diagnóstico
```bash
./repair.sh --diagnose
```

## 📝 Logs

Todos los scripts generan logs detallados:

- **Instalación:** `~/.archriced-install.log`
- **Desinstalación:** `~/.archriced-uninstall.log`
- **Reparación:** `~/.archriced-repair.log`

## 🎉 Resultado Final

La unificación ha resultado en:

1. **Código más limpio** - Estructura modular y bien organizada
2. **Mantenimiento más fácil** - Menos archivos que mantener
3. **Mejor documentación** - README actualizado y completo
4. **Funcionalidad mejorada** - Más opciones y mejor manejo de errores
5. **Experiencia de usuario mejorada** - Scripts más intuitivos y fáciles de usar

---

**¡La unificación está completa! 🎉** 