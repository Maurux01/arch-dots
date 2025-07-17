# 🚀 Arch Dots Installer

Script de instalación unificado y modular para configurar tu entorno de usuario completo en Arch Linux.

## ✨ Características

- **Instalación modular**: Instala solo los componentes que necesites
- **Detección inteligente**: Detecta instalaciones existentes para evitar duplicados
- **Respaldo automático**: Crea respaldos de configuraciones existentes
- **Soporte para flags**: Ejecuta solo partes específicas del script
- **Logging completo**: Registra todas las operaciones para debugging

## 🎯 Componentes Soportados

- **🐱 Kitty**: Terminal con configuración moderna, temas y scripts de kitten
- **📝 Neovim**: Editor con plugins y configuración avanzada
- **🖥️ Hyprland**: Compositor de ventanas moderno
- **🔒 Hyprlock**: Pantalla de bloqueo elegante
- **🎭 Tmux**: Terminal multiplexer con plugins y temas
- **🖼️ SDDM**: Gestor de inicio de sesión
- **🔤 Fuentes**: Nerd Fonts (JetBrainsMono, etc.)
- **🖼️ Wallpapers**: Imágenes de fondo organizadas

## 🚀 Uso

### Instalación completa
```bash
./install.sh
```

### Instalación selectiva
```bash
# Solo Kitty y Neovim
./install.sh --kitty --nvim

# Solo fuentes y wallpapers
./install.sh --fonts --wallpapers

# Solo Hyprland y componentes relacionados
./install.sh --hyprland --hyprlock --sddm
```

### Opciones disponibles
```bash
./install.sh --help
```

**Flags disponibles:**
- `--all`: Instalar todos los componentes (predeterminado)
- `--kitty`: Instalar solo Kitty
- `--nvim`: Instalar solo Neovim
- `--hyprland`: Instalar solo Hyprland
- `--hyprlock`: Instalar solo Hyprlock
- `--tmux`: Instalar solo Tmux
- `--sddm`: Instalar solo SDDM
- `--fonts`: Instalar solo fuentes
- `--wallpapers`: Instalar solo wallpapers
- `--help`: Mostrar ayuda

## 📋 Ejemplos de Uso

### Instalación en sistema limpio
```bash
# Clona tu repositorio
git clone https://github.com/maurux01archriced-1.git
cd archriced-1
# Instala todo
./install.sh
```

### Actualización selectiva
```bash
# Solo actualizar Kitty
./install.sh --kitty

# Actualizar editor y terminal
./install.sh --kitty --nvim

# Actualizar entorno de escritorio
./install.sh --hyprland --hyprlock --sddm
```

### Instalación por partes
```bash
# Primero las herramientas básicas
./install.sh --kitty --nvim --tmux

# Luego el entorno de escritorio
./install.sh --hyprland --hyprlock --sddm

# Finalmente recursos visuales
./install.sh --fonts --wallpapers
```

## 🔍 Logging y Debugging

El script crea logs detallados en:
- **Log file**: `~/.archriced-install.log`
- **Backup**: `~/.archriced-backup-YYYYMMDD-HHMMSS/`

### Verificar logs
```bash
tail -f ~/.archriced-install.log
```

### Revisar respaldo
```bash
ls ~/.archriced-backup-*
```

## ⚠️ Notas Importantes1**No ejecutar como root**: El script debe ejecutarse como usuario normal
2. **Solo Arch Linux**: Diseñado específicamente para Arch Linux
3. **Respaldo automático**: Se crea respaldo de configuraciones existentes
4. **Detección inteligente**: Evita reinstalar componentes ya instalados
5. **Permisos**: Se configuran automáticamente los permisos necesarios

## 🛠️ Troubleshooting

### Error: "No se encontró dotfiles/"
- Verifica que estés ejecutando el script desde el directorio raíz del repositorio
- Asegúrate de que la estructura de carpetas sea correcta

### Error: Dependencias faltantes"
- Instala git, sudo y pacman antes de ejecutar el script
- En Arch Linux: `sudo pacman -S git sudo`

### Error: "Permisos denegados"
- Asegúrate de que el script tenga permisos de ejecución: `chmod +x install.sh`
- Verifica que tu usuario tenga permisos sudo

### Componente no se instaló
- Revisa los logs: `tail ~/.archriced-install.log`
- Ejecuta solo ese componente: `./install.sh --componente`

---

**¡Disfruta tu entorno de desarrollo moderno y elegante! 🚀** 