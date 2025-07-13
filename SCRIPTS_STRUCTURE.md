# 📁 Estructura de Scripts - Arch Dots

## 🎯 Scripts Principales (Raíz del proyecto)

### 1. **`install.sh`** - Instalación Principal
- **Función**: Instalación completa del sistema
- **Uso**: `./install.sh`
- **Incluye**: Hyprland, Neovim, herramientas multimedia, fuentes, etc.

### 2. **`uninstall.sh`** - Desinstalación Completa
- **Función**: Desinstalación completa con backup automático
- **Uso**: `./uninstall.sh`
- **Incluye**: Backup de configuraciones, eliminación de paquetes, limpieza

### 3. **`repair.sh`** - Reparación y Actualización
- **Función**: Reparación de problemas y actualización del sistema
- **Uso**: `./repair.sh`
- **Incluye**: Diagnóstico, reparación de paquetes, optimización

## 🔧 Scripts de Utilidad

### 4. **`security-manager.sh`** - Gestor de Seguridad
- **Función**: Configuración de seguridad del sistema
- **Uso**: `./security-manager.sh`

### 5. **`make-executable.sh`** - Permisos de Ejecución
- **Función**: Hacer ejecutables todos los scripts
- **Uso**: `./make-executable.sh`

### 6. **`utils.sh`** - Utilidades Comunes
- **Función**: Funciones compartidas entre scripts
- **Uso**: Importado por otros scripts

## 📂 Scripts Específicos por Componente

### Neovim (`dotfiles/nvim/`)
- **`install.sh`** - Instalación específica de Neovim

### Fish Shell (`dotfiles/fish/`)
- **`install.sh`** - Instalación específica de Fish

### Neofetch (`dotfiles/neofetch/`)
- **`install.sh`** - Instalación específica de Neofetch

### Wallpapers (`dotfiles/scripts/`)
- **`wallpaper-prev.sh`** - Cambiar wallpaper anterior
- **`wallpaper-next.sh`** - Cambiar wallpaper siguiente
- **`random-wallpaper.sh`** - Wallpaper aleatorio

### EWW Widgets (`dotfiles/eww/scripts/`)
- **`battery.sh`** - Información de batería
- **`brightness.sh`** - Control de brillo
- **`volume.sh`** - Control de volumen
- **`weather.sh`** - Información del clima

## 🗑️ Scripts Eliminados (Redundantes)

### Eliminados de `dotfiles/nvim/`:
- ❌ `install-monokai.sh` (funcionalidad integrada en `install.sh`)
- ❌ `install-monokai.ps1` (versión Windows redundante)
- ❌ `install-monokai-simple.ps1` (versión Windows redundante)
- ❌ `curl-install.sh` (funcionalidad integrada en `install.sh`)

### Eliminados de `dotfiles/scripts/`:
- ❌ `change-font.sh` (funcionalidad integrada en `install.sh`)
- ❌ `configure-waypaper.sh` (funcionalidad integrada en `install.sh`)
- ❌ `install-grub-theme.sh` (funcionalidad integrada en `install.sh`)

## 📋 Comandos de Uso

```bash
# Instalación completa
./install.sh

# Desinstalación con backup
./uninstall.sh

# Reparación y actualización
./repair.sh

# Configurar permisos de ejecución
./make-executable.sh

# Gestión de seguridad
./security-manager.sh
```

## ✅ Beneficios de la Limpieza

1. **Simplicidad**: Solo 3 scripts principales para operaciones básicas
2. **Mantenibilidad**: Menos archivos redundantes
3. **Claridad**: Estructura más organizada y comprensible
4. **Eficiencia**: Funcionalidades integradas en scripts principales
5. **Consistencia**: Mismo patrón para todas las operaciones

## 🔄 Flujo de Trabajo Recomendado

1. **Primera vez**: `./install.sh`
2. **Mantenimiento**: `./repair.sh`
3. **Problemas**: `./repair.sh` (diagnóstico automático)
4. **Desinstalación**: `./uninstall.sh` 