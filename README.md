# 🐧 Arch Dots: The Ultimate Automated Arch Linux + Hyprland Rice

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-FF0080?style=for-the-badge&logo=hyprland&logoColor=white)](https://hyprland.org/)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Fish Shell](https://img.shields.io/badge/Fish_Shell-FF6B6B?style=for-the-badge&logo=fish&logoColor=white)](https://fishshell.com/)

> **Una configuración completa y automatizada para Arch Linux con Hyprland, Neovim IDE, y todas las herramientas que necesitas para desarrollo, gaming y productividad.**

## ✨ Características

### 🎨 **Entorno Visual**
- **Hyprland** - Compositor Wayland moderno con animaciones fluidas
- **Waybar** - Barra de estado personalizable
- **Eww** - Widgets personalizados (clima, batería, música, etc.)
- **Mako** - Notificaciones elegantes
- **Wofi** - Lanzador de aplicaciones
- **Swww** - Fondos de pantalla animados
- **Kitty** - Terminal emulator con soporte GPU
- **Tema Catppuccin** - Colores hermosos y consistentes

### 💻 **Desarrollo**
- **Neovim IDE** - Editor completo con LSP, autocompletado, IA
- **Fish Shell** - Shell moderna con autocompletado inteligente
- **Herramientas CLI** - bat, fd, ripgrep, fzf, lazygit, yazi
- **Lenguajes** - Python, Node.js, Rust, Go, Java, C/C++
- **Git** - Configuración optimizada con GitHub CLI

### 🎮 **Gaming & Multimedia**
- **Steam** - Plataforma de gaming
- **Heroic Games Launcher** - Epic Games Store
- **OBS Studio** - Streaming y grabación
- **GIMP, Kdenlive, Inkscape** - Edición multimedia
- **Blender** - Modelado 3D
- **Discord** - Comunicación

### 🛠️ **Productividad**
- **Ferdium** - Gestor de aplicaciones web
- **AppFlowy** - Notas y gestión de proyectos
- **Insomnia** - Cliente API
- **Beekeeper Studio** - Gestor de bases de datos
- **VSCodium** - Editor de código alternativo

## 🚀 Instalación Rápida

### 1. **Clonar el repositorio**
```bash
git clone https://github.com/youruser/arch-dots.git
cd arch-dots
```

### 2. **Ejecutar el instalador**
```bash
chmod +x install.sh
./install.sh
```

### 3. **Seleccionar componentes**
El instalador te permitirá elegir:
- ✅ **Todo el entorno** (recomendado)
- 🎨 **Componentes visuales** (Hyprland, Waybar, etc.)
- 🛠️ **Herramientas extra** (yazi, lazygit, etc.)
- 💻 **Lenguajes de programación** (Python, Node, Rust, etc.)
- 📝 **Neovim IDE** completo
- 🎮 **Apps creativas, gaming y utilidades**

### 4. **Reiniciar y disfrutar**
```bash
# Reinicia tu sesión y selecciona Hyprland
```

## 📋 Requisitos del Sistema

### **Mínimos**
- Arch Linux (reciente)
- 4GB RAM
- 20GB espacio libre
- GPU compatible con Wayland

### **Recomendados**
- 8GB+ RAM
- SSD
- GPU moderna (NVIDIA/AMD/Intel)
- Conexión a internet estable

## 🎯 Componentes Principales

| Componente | Descripción | Configuración |
|------------|-------------|---------------|
| **Hyprland** | Compositor Wayland | `~/.config/hypr/hyprland.conf` |
| **Waybar** | Barra de estado | `~/.config/waybar/` |
| **Eww** | Widgets | `~/.config/eww/` |
| **Neovim** | IDE completo | `~/.config/nvim/` |
| **Fish** | Shell moderna | `~/.config/fish/config.fish` |
| **Kitty** | Terminal | `~/.config/kitty/kitty.conf` |

## 🎨 Personalización

### **Temas y Colores**
- Cambia el tema en `~/.config/hypr/hyprland.conf`
- Modifica colores en `~/.config/eww/style.scss`
- Personaliza Waybar en `~/.config/waybar/style.css`

### **Widgets Eww**
- Clima: `~/.config/eww/scripts/weather.sh`
- Batería: `~/.config/eww/scripts/battery.sh`
- Volumen: `~/.config/eww/scripts/volume.sh`

### **Fondos de Pantalla**
```bash
# Agrega tus wallpapers
cp tu-wallpaper.jpg ~/Pictures/wallpapers/
# Edita ~/.config/hypr/hyprland.conf para cambiar
```

## 🛠️ Scripts de Utilidades

### **Script Principal de Utilidades**
```bash
# Navegar al directorio
cd ~/github/arch-dots

# Usar el script de utilidades
./dotfiles/scripts/utils.sh [comando]
```

### **Comandos Disponibles**
```bash
./dotfiles/scripts/utils.sh update    # Actualizar sistema
./dotfiles/scripts/utils.sh clean     # Limpiar sistema
./dotfiles/scripts/utils.sh check     # Verificar estado
./dotfiles/scripts/utils.sh firewall  # Configurar firewall
./dotfiles/scripts/utils.sh optimize  # Optimizar sistema
./dotfiles/scripts/utils.sh info      # Información del sistema
./dotfiles/scripts/utils.sh aur pkg   # Instalar paquetes AUR
```

### **Backup Automático**
```bash
# Función integrada en Fish
dotbackup

# O usar el script directamente
./dotfiles/scripts/backup.sh
```

## 🔧 Configuración Post-Instalación

### **1. Configurar Git**
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

### **2. Instalar Fuentes (si es necesario)**
```bash
./dotfiles/scripts/postinstall.sh
```

### **3. Configurar Clima (opcional)**
```bash
# Editar ~/.config/eww/scripts/weather.sh
export WEATHER_CITY="Tu Ciudad"
export WEATHER_API_KEY="tu-api-key"  # Opcional
```

### **4. Personalizar Keybinds**
Edita `~/.config/hypr/hyprland.conf` para modificar atajos de teclado.

## 🎮 Gaming Setup

### **Steam**
- Instalado automáticamente
- Configuración optimizada para Wayland
- Soporte para controladores

### **Heroic Games Launcher**
```bash
# Instalar desde AUR si no se instaló
./dotfiles/scripts/utils.sh aur heroic-games-launcher
```

### **Optimizaciones de Gaming**
- FPS counter integrado
- Configuración de GPU optimizada
- Soporte para GameMode

## 💻 Desarrollo

### **Neovim IDE**
- **LSP** para todos los lenguajes principales
- **Autocompletado** inteligente
- **IA** con GitHub Copilot y Codeium
- **Telescope** para búsqueda rápida
- **Git** integrado con gitsigns
- **Terminal** integrado

### **Lenguajes Soportados**
- **Python** - LSP, formateo, debugging
- **JavaScript/TypeScript** - LSP, npm, debugging
- **Rust** - Cargo, LSP, formateo
- **Go** - Go modules, LSP
- **C/C++** - Clang, debugging
- **Java** - Maven/Gradle, debugging

### **Herramientas de Desarrollo**
```bash
# Búsqueda de archivos
fd "archivo"

# Búsqueda en contenido
rg "texto"

# Navegación inteligente
z

# Git visual
lazygit

# Gestor de archivos
yazi
```

## 🔍 Troubleshooting

### **Problemas Comunes**

#### **Hyprland no inicia**
```bash
# Verificar logs
journalctl --user -u hyprland

# Verificar dependencias
pacman -Q hyprland waybar mako
```

#### **Eww widgets no aparecen**
```bash
# Reiniciar eww
eww kill
eww daemon
eww open-many main-bar

# Verificar permisos
chmod +x ~/.config/eww/scripts/*.sh
```

#### **Neovim plugins no cargan**
```bash
# Abrir Neovim y esperar
nvim

# Verificar Lazy.nvim
:Lazy sync
```

#### **Fish shell no funciona**
```bash
# Cambiar shell manualmente
chsh -s $(which fish)

# Verificar Oh My Fish
omf install bobthefish
```

#### **Paquetes AUR no se instalan**
```bash
# Instalar yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# O usar el script de utilidades
./dotfiles/scripts/utils.sh aur paquete
```

### **Logs Útiles**
```bash
# Hyprland
journalctl --user -u hyprland -f

# Waybar
waybar -l debug

# Eww
eww logs

# Sistema
journalctl -f
```

### **Recuperación**
```bash
# Restaurar configuración
cd ~/github/arch-dots
git checkout -- .

# Reinstalar componentes
./install.sh
```

## 📚 Recursos Adicionales

### **Documentación Oficial**
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Neovim Docs](https://neovim.io/doc/)
- [Fish Shell](https://fishshell.com/docs/current/)
- [Arch Wiki](https://wiki.archlinux.org/)

### **Comunidad**
- [r/hyprland](https://reddit.com/r/hyprland)
- [r/neovim](https://reddit.com/r/neovim)
- [r/archlinux](https://reddit.com/r/archlinux)

## 🤝 Contribución

¡Las contribuciones son bienvenidas! 

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

## 🙏 Agradecimientos

- [Hyprland](https://hyprland.org/) - Compositor Wayland
- [Neovim](https://neovim.io/) - Editor de código
- [Fish Shell](https://fishshell.com/) - Shell moderna
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Paleta de colores
- Comunidad de Arch Linux

---

**⭐ Si te gusta este proyecto, ¡dale una estrella!**

**🐛 ¿Encontraste un bug? [Abre un issue](https://github.com/youruser/arch-dots/issues)**

**💡 ¿Tienes una idea? [Sugiere una feature](https://github.com/youruser/arch-dots/discussions)** 

## **✅ MEJORAS IMPLEMENTADAS:**

### **1. Scripts Mejorados**
- ✅ **`install.sh`** - Más robusto, sin dependencias de fzf
- ✅ **`postinstall.sh`** - Más fuentes, mejor manejo de errores
- ✅ **`backup.sh`** - Verificaciones de seguridad, mejor feedback
- ✅ **`utils.sh`** - **NUEVO** script de utilidades completo

### **2. Configuraciones Mejoradas**
- ✅ **Hyprland** - Tema Catppuccin completo, más keybinds, gestos
- ✅ **Fish Shell** - Más aliases, funciones útiles, mejor tema
- ✅ **Weather Script** - Soporte para OpenWeatherMap API
- ✅ **Eww Scripts** - Mejor manejo de errores

### **3. Documentación Mejorada**
- ✅ **README.md** - Completamente reescrito con emojis y estructura clara
- ✅ **Scripts README** - Documentación detallada de todos los scripts
- ✅ **Troubleshooting** - Sección expandida con soluciones

### **4. Nuevas Funcionalidades**
- ✅ **Script de utilidades** con 8 comandos diferentes
- ✅ **Más fuentes** Nerd Fonts
- ✅ **Mejor manejo de AUR** paquetes
- ✅ **Funciones de Fish** integradas
- ✅ **Configuración de firewall** automática

## **🚀 EL REPOSITORIO AHORA INCLUYE:**

### **Scripts Principales:**
- `install.sh` - Instalador principal mejorado
- `postinstall.sh` - Configuración post-instalación
- `backup.sh` - Backup automático
- `utils.sh` - **NUEVO** script de utilidades

### **Funcionalidades del Script de Utilidades:**
```bash
./dotfiles/scripts/utils.sh update    # Actualizar sistema
./dotfiles/scripts/utils.sh clean     # Limpiar sistema  
./dotfiles/scripts/utils.sh check     # Verificar estado
./dotfiles/scripts/utils.sh firewall  # Configurar firewall
./dotfiles/scripts/utils.sh optimize  # Optimizar sistema
./dotfiles/scripts/utils.sh info      # Información del sistema
./dotfiles/scripts/utils.sh aur pkg   # Instalar paquetes AUR
```

### **Funciones de Fish Integradas:**
```bash
dotbackup    # Backup rápido
update       # Actualizar sistema
search       # Buscar paquetes
install      # Instalar paquetes
remove       # Desinstalar paquetes
sysinfo      # Información del sistema
weather      # Clima en terminal
```

## **🎯 BENEFICIOS DE LAS MEJORAS:**

1. **Más Robusto** - Mejor manejo de errores y verificaciones
2. **Más Fácil de Usar** - Documentación clara y comandos intuitivos
3. **Más Completo** - Scripts de utilidades para mantenimiento
4. **Más Personalizable** - Configuraciones avanzadas disponibles
5. **Mejor Documentado** - READMEs detallados y troubleshooting

## **📋 PRÓXIMOS PASOS:**

1. **Probar en Arch Linux real** - El script está listo para usar
2. **Personalizar configuraciones** - Ajustar temas y keybinds
3. **Usar los scripts de utilidades** - Para mantenimiento del sistema
4. **Contribuir** - Agregar más funcionalidades según necesites

¡Tu repositorio ahora es **mucho más profesional, robusto y fácil de usar**! 🚀 