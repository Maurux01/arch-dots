# Arch Dots - Configuración de Hyprland

Una configuración completa y moderna de Hyprland para Arch Linux con un sistema de login dinámico basado en wallpapers.

## 🚀 Características

- **Hyprland** - Compositor Wayland moderno y rápido
- **Login dinámico** - Tema de bloqueo que se adapta a tu wallpaper
- **EWW widgets** - Widgets personalizables para el escritorio
- **Waybar** - Barra de estado minimalista
- **Kitty** - Terminal GPU-accelerated
- **Neovim** - Editor configurado con LSP y plugins
- **Fish Shell** - Shell interactivo con autocompletado
- **Gaming optimizado** - Steam, Lutris, Wine, GameMode
- **Desarrollo** - Node.js, Python, Rust, Go, Java
- **Hyperlock** - Bloqueador de pantalla nativo de Hyprland

## 📦 Instalación

### Instalación completa automática

```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/archriced.git
cd archriced

# Ejecutar instalación completa
./install.sh
```

El script de instalación:
- ✅ Actualiza el sistema
- ✅ Instala todas las dependencias
- ✅ Configura Hyprland y componentes
- ✅ Instala utilidades del sistema
- ✅ Configura herramientas de desarrollo
- ✅ Instala fuentes y temas
- ✅ Configura Hyperlock
- ✅ Copia todos los dotfiles
- ✅ Configura el sistema

### Desinstalación completa

```bash
# Desinstalar todo
./uninstall.sh
```

El script de desinstalación:
- ✅ Crea un backup completo
- ✅ Desinstala todos los paquetes
- ✅ Elimina configuraciones
- ✅ Restaura configuraciones por defecto
- ✅ Limpia el sistema

## 🎨 Características del Login Dinámico

El sistema de login dinámico analiza automáticamente tu wallpaper y genera un tema de bloqueo que se adapta a los colores dominantes.

### Funciones incluidas:

- **Análisis de wallpaper** - Extrae colores dominantes
- **Generación de tema** - Crea temas de swaylock automáticamente
- **Rotación automática** - Cambia wallpapers automáticamente
- **Widget de control** - EWW widget para gestionar wallpapers

### Comandos útiles:

```bash
# Bloquear pantalla con tema dinámico
./utils.sh lock

# Cambiar wallpaper manualmente
./utils.sh wallpaper

# Iniciar daemon de rotación automática
./utils.sh wallpaper-daemon

# Analizar wallpaper actual
./utils.sh analyze-wallpaper
```

## 🛠️ Scripts de Utilidades

### `utils.sh`

Script principal de utilidades con múltiples funciones:

```bash
# Ver todas las opciones
./utils.sh

# Gestión de wallpapers
./utils.sh wallpaper [comando]
./utils.sh wallpaper-daemon [start|stop|status]

# Bloqueo de pantalla
./utils.sh lock

# Mantenimiento del sistema
./utils.sh maintenance

# Información del sistema
./utils.sh info

# Análisis de wallpapers
./utils.sh analyze-wallpaper [ruta]
```

### Hyperlock

Bloqueador de pantalla nativo de Hyprland:

```bash
# Bloquear pantalla
hyperlock

# Configurar Hyperlock
nano ~/.config/hyperlock/config.toml

# Ver estado de Hyperlock
systemctl --user status hyperlock
```

### Portapapeles e Historial

Sistema completo de portapapeles con historial:

```bash
# Abrir historial de CopyQ
SUPER + V

# Abrir historial de cliphist
SUPER + SHIFT + V

# Alternativa para cliphist
SUPER + CTRL + V

# Capturar pantalla al portapapeles
SUPER + SHIFT + S
```

**Herramientas incluidas:**
- **CopyQ** - Gestor avanzado de portapapeles con GUI
- **cliphist** - Historial de portapapeles en terminal
- **wl-clipboard** - Herramientas de portapapeles para Wayland

## 🎮 Gaming

Configuración optimizada para gaming:

- **Steam** - Plataforma de juegos
- **Lutris** - Gestor de juegos
- **Wine** - Compatibilidad con Windows
- **GameMode** - Optimización automática
- **MangoHud** - Overlay de rendimiento
- **Heroic Games Launcher** - Epic Games Store

## 💻 Desarrollo

Herramientas de desarrollo incluidas:

- **Node.js & npm** - JavaScript runtime
- **Python & pip** - Python interpreter
- **Rust** - Rust programming language
- **Go** - Go programming language
- **Java JDK** - Java development kit
- **GCC & CMake** - Compiladores y build tools
- **Git** - Control de versiones
- **LazyGit** - TUI para Git
- **Neovim** - Editor configurado con LSP

## ⌨️ Atajos de Teclado

### Hyprland
- `SUPER + RETURN` - Abrir terminal
- `SUPER + D` - Lanzador de aplicaciones
- `SUPER + Q` - Cerrar ventana
- `SUPER + SHIFT + L` - Bloquear pantalla
- `SUPER + SHIFT + C` - Recargar configuración
- `SUPER + SHIFT + Q` - Salir de Hyprland

### Navegación
- `SUPER + HJKL` - Navegar entre ventanas
- `SUPER + 1-9` - Cambiar workspace
- `SUPER + SHIFT + HJKL` - Mover ventanas
- `SUPER + SHIFT + 1-9` - Mover ventana a workspace

### Multimedia
- `XF86AudioPlay` - Play/Pause
- `XF86AudioNext` - Siguiente canción
- `XF86AudioPrev` - Canción anterior
- `XF86AudioMute` - Silenciar
- `XF86AudioRaiseVolume` - Subir volumen
- `XF86AudioLowerVolume` - Bajar volumen

### Portapapeles
- `SUPER + V` - Abrir historial CopyQ
- `SUPER + SHIFT + V` - Abrir historial cliphist
- `SUPER + CTRL + V` - Alternativa cliphist
- `SUPER + SHIFT + S` - Capturar pantalla al portapapeles

## 🎨 Temas y Personalización

### Temas incluidos:
- **Catppuccin** - Tema oscuro moderno
- **Papirus** - Iconos consistentes
- **Bibata** - Cursor animado

### Fuentes:
- **JetBrains Mono** - Fuente de programación
- **Fira Code** - Fuente con ligaduras
- **Noto Fonts** - Fuentes universales

## 🔧 Configuración

### Archivos principales:
- `~/.config/hypr/hyprland.conf` - Configuración de Hyprland
- `~/.config/waybar/config` - Configuración de Waybar
- `~/.config/eww/eww.yuck` - Widgets EWW
- `~/.config/kitty/kitty.conf` - Configuración de terminal
- `~/.config/nvim/init.lua` - Configuración de Neovim

### Personalización:
1. Edita los archivos de configuración
2. Recarga Hyprland con `SUPER + SHIFT + C`
3. Los cambios se aplican inmediatamente

## 🐛 Solución de Problemas

### Problemas comunes:

**Hyprland no inicia:**
```bash
# Verificar logs
journalctl --user -f

# Verificar configuración
./utils.sh info
```

**Wallpapers no cambian:**
```bash
# Verificar swww
./utils.sh info

# Reiniciar daemon
./utils.sh wallpaper-daemon restart
```

**Hyperlock no funciona:**
```bash
# Verificar instalación
./utils.sh info

# Reconfigurar Hyperlock
yay -S hyperlock --noconfirm
```

### Logs útiles:
- `~/.local/share/hyprland/hyprland.log` - Logs de Hyprland
- `./utils.sh debug` - Debug completo
- `journalctl --user -f` - Logs del usuario

## 📁 Estructura del Proyecto

```
archriced/
├── install.sh              # Instalación completa
├── uninstall.sh            # Desinstalación completa
├── utils.sh                # Utilidades principales
├── README.md               # Documentación
└── dotfiles/               # Configuraciones
    ├── hypr/               # Hyprland
    ├── waybar/             # Barra de estado
    ├── eww/                # Widgets
    ├── kitty/              # Terminal
    ├── nvim/               # Editor
    ├── fish/               # Shell
    └── wallpapers/         # Wallpapers de ejemplo
```

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🙏 Agradecimientos

- [Hyprland](https://hyprland.org/) - Compositor Wayland
- [EWW](https://github.com/elkowar/eww) - Widgets para Wayland
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Paleta de colores
- [JaKooLit](https://github.com/JaKooLit/Arch-Hyprland) - Inspiración para scripts

## 📞 Soporte

Si tienes problemas o preguntas:

1. Revisa la sección de [Solución de Problemas](#-solución-de-problemas)
2. Ejecuta `./utils.sh debug` y comparte los logs
3. Abre un issue en GitHub con información detallada

---

**¡Disfruta tu nueva configuración de Hyprland! 🎉** 