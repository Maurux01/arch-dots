# 🚀 Arch Dots Installer - Mejorado

Script de instalación unificado y modular para configurar tu entorno de usuario completo en Arch Linux.

## ✨ Características

- **Instalación modular**: Instala solo los componentes que necesites
- **Detección inteligente**: Detecta instalaciones existentes para evitar duplicados
- **Respaldo automático**: Crea respaldos de configuraciones existentes
- **Soporte para flags**: Ejecuta solo partes específicas del script
- **Logging completo**: Registra todas las operaciones para debugging
- **Verificación final**: Confirma que todo se instaló correctamente

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
./install-improved.sh
```

### Instalación selectiva
```bash
# Solo Kitty y Neovim
./install-improved.sh --kitty --nvim

# Solo fuentes y wallpapers
./install-improved.sh --fonts --wallpapers

# Solo Hyprland y componentes relacionados
./install-improved.sh --hyprland --hyprlock --sddm
```

### Opciones disponibles
```bash
./install-improved.sh --help
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

## 📁 Estructura de Dotfiles

El script espera la siguiente estructura en tu repositorio:

```
archriced-1
├── dotfiles/
│   ├── kitty/
│   │   ├── kitty.conf
│   │   ├── theme-switcher.sh
│   │   └── kitten-scripts/
│   ├── nvim/
│   │   ├── init.lua
│   │   └── lua/
│   ├── hypr/
│   │   ├── hyprland.conf
│   │   └── assets/
│   ├── hyprlock/
│   │   ├── hyprlock.conf
│   │   └── assets/
│   ├── tmux/
│   │   ├── tmux.conf
│   │   ├── plugins/
│   │   └── scripts/
│   ├── sddm/
│   │   └── themes/
│   ├── fonts/
│   ├── wallpapers/
│   └── fish/
│       └── config.fish
└── install-improved.sh
```

## 🔧 Funcionamiento

###1ficaciones iniciales
- Detecta si estás en Arch Linux
- Verifica dependencias básicas (git, sudo, pacman)
- Crea respaldo de configuraciones existentes

### 2. Instalación base
- Actualiza el sistema
- Instala AUR helper (yay)
- Instala compilador C
- Instala paquetes core

###3ión de componentes
- **Kitty**: Instala kitty, copia configuración y scripts de kitten
- **Neovim**: Instala neovim, copia configuración y plugins
- **Hyprland**: Instala hyprland, copia configuración y assets
- **Hyprlock**: Instala hyprlock, copia configuración y assets
- **Tmux**: Instala tmux, TPM, copia configuración y scripts
- **SDDM**: Instala sddm, habilita servicio, copia configuración
- **Fuentes**: Instala Nerd Fonts, copia fuentes personalizadas
- **Wallpapers**: Copia wallpapers a ~/Pictures/wallpapers

### 4raciones adicionales
- Configura Fish shell
- Configura permisos de sistema
- Configura NetworkManager

### 5. Verificación final
- Verifica que todos los componentes se instalaron correctamente
- Muestra resumen de instalación
- Proporciona comandos útiles

## 📋 Ejemplos de Uso

### Instalación en sistema limpio
```bash
# Clona tu repositorio
git clone https://github.com/maurux01archriced-1.git
cd archriced-1
# Instala todo
./install-improved.sh
```

### Actualización selectiva
```bash
# Solo actualizar Kitty
./install-improved.sh --kitty

# Actualizar editor y terminal
./install-improved.sh --kitty --nvim

# Actualizar entorno de escritorio
./install-improved.sh --hyprland --hyprlock --sddm
```

### Instalación por partes
```bash
# Primero las herramientas básicas
./install-improved.sh --kitty --nvim --tmux

# Luego el entorno de escritorio
./install-improved.sh --hyprland --hyprlock --sddm

# Finalmente recursos visuales
./install-improved.sh --fonts --wallpapers
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
- Asegúrate de que el script tenga permisos de ejecución: `chmod +x install-improved.sh`
- Verifica que tu usuario tenga permisos sudo

### Componente no se instaló
- Revisa los logs: `tail ~/.archriced-install.log`
- Ejecuta solo ese componente: `./install-improved.sh --componente`

## 🎨 Personalización

### Agregar nuevos componentes
1 Crea la función `install_nuevo_componente()`
2. Agrega la verificación en `verify_installation()`
3. Añade el flag correspondiente en `process_args()`

### Modificar configuraciones
- Edita los archivos en `dotfiles/`
- Ejecuta el script con el flag correspondiente
- Los cambios se aplicarán automáticamente

## 📞 Soporte

Si encuentras problemas:
1Revisa los logs en `~/.archriced-install.log`
2 que la estructura de dotfiles sea correcta
3. Ejecuta el script con flags específicos para aislar el problema4Revisa el respaldo en caso de que algo se haya roto

---

**¡Disfruta tu entorno de desarrollo moderno y elegante! 🚀** 