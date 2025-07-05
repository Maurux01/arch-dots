# 🔗 Integración de Repositorios - archriced

Este documento describe la integración de los siguientes repositorios en tu configuración principal de dotfiles:

## 📦 Repositorios Integrados

### 1. 🐱 [mykittydots](https://github.com/Maurux01/mykittydots)
**Configuración avanzada de Kitty Terminal**

#### Características integradas:
- ✅ **7 temas de colores**: Main, Moon, Tokyo Night, Catppuccin, Dracula, Gruvbox, Nord
- ✅ **Fuente JetBrains Mono Nerd Font** con soporte para iconos
- ✅ **Pestañas Powerline** con diseño inclinado
- ✅ **Atajos de teclado personalizados** para gestión de pestañas y ventanas
- ✅ **Script de cambio de temas** (`theme-switcher.sh`)
- ✅ **Configuración optimizada** para rendimiento y usabilidad

#### Archivos añadidos:
- `dotfiles/kitty/kitty.conf` - Configuración principal con múltiples temas
- `dotfiles/kitty/theme-switcher.sh` - Script para cambiar temas fácilmente

#### Uso del theme switcher:
```bash
# Cambiar a tema específico
~/.config/kitty/theme-switcher.sh main
~/.config/kitty/theme-switcher.sh tokyo
~/.config/kitty/theme-switcher.sh catppuccin

# Ver temas disponibles
~/.config/kitty/theme-switcher.sh list
```

---

### 2. 🎨 [fst-neofetch](https://github.com/Maurux01/fst-neofetch)
**Configuraciones para Neofetch y Fastfetch**

#### Características integradas:
- ✅ **Configuración de Neofetch** con iconos y colores vibrantes
- ✅ **Configuración de Fastfetch** con tema Tokyo Night
- ✅ **Información del sistema** optimizada para mostrar datos relevantes

#### Archivos añadidos:
- `dotfiles/neofetch/neofetch.conf` - Configuración de Neofetch
- `dotfiles/neofetch/fastfetch.jsonc` - Configuración de Fastfetch

#### Uso:
```bash
# Neofetch con nueva configuración
neofetch

# Fastfetch con nueva configuración
fastfetch
```

---

### 3. 📝 [VimX](https://github.com/Maurux01/VimX)
**Configuración avanzada de Neovim**

#### Características integradas:
- ✅ **Sistema de plugins con Lazy.nvim**
- ✅ **Configuraciones de LSP** para múltiples lenguajes
- ✅ **Atajos de teclado optimizados** para desarrollo
- ✅ **Temas y personalización** avanzada
- ✅ **Integración con herramientas de desarrollo**

#### Archivos añadidos:
- `dotfiles/nvim/init.lua` - Configuración principal
- `dotfiles/nvim/lua/` - Módulos de configuración
- `dotfiles/nvim/lazy-lock.json` - Lock de plugins
- `dotfiles/nvim/.neoconf.json` - Configuración de NeoConf
- `dotfiles/nvim/stylua.toml` - Configuración de Stylua

#### Características principales:
- **Lazy.nvim** como gestor de plugins
- **LSP** configurado para múltiples lenguajes
- **Telescope** para búsqueda y navegación
- **Treesitter** para syntax highlighting
- **Lualine** para barra de estado
- **Nvim-tree** para explorador de archivos

---

### 4. 🎯 [TmuXpert](https://github.com/Maurux01/TmuXpert)
**Configuración avanzada de Tmux**

#### Características integradas:
- ✅ **Plugin Manager (TPM)** con plugins esenciales
- ✅ **Barra de estado personalizada** con información del sistema
- ✅ **Atajos de teclado optimizados** (Ctrl+Space como prefix)
- ✅ **Gestión de sesiones** con Resurrect y Continuum
- ✅ **Scripts de monitoreo** del sistema
- ✅ **Integración perfecta** con Neovim

#### Archivos añadidos:
- `dotfiles/tmux/.tmux.conf` - Configuración principal
- `dotfiles/tmux/scripts/` - Scripts de monitoreo
  - `sysinfo.sh` - Información del sistema
  - `network.sh` - Estado de red
  - `disk.sh` - Uso de disco
  - `theme-switcher.sh` - Cambio de temas

#### Plugins incluidos:
- **tmux-resurrect** - Guardar/restaurar sesiones
- **tmux-continuum** - Auto-guardado cada 15 minutos
- **tmux-yank** - Copiar/pegar mejorado
- **tmux-fingers** - Detección de URLs/archivos
- **tmux-battery** - Indicador de batería
- **tmux-cpu** - Información de CPU

#### Atajos principales:
- `Ctrl+Space` - Prefix (en lugar de Ctrl+b)
- `Ctrl+h/j/k/l` - Navegación entre paneles (sin prefix)
- `Ctrl+1-9` - Cambiar a ventana específica
- `v` - Split vertical
- `s` - Split horizontal
- `z` - Toggle zoom
- `S` - Guardar sesión
- `R` - Restaurar sesión

---

## 🚀 Instalación

### Instalación automática (recomendada):
```bash
# Clonar el repositorio
git clone https://github.com/Maurux01/archriced.git
cd archriced

# Ejecutar instalador
chmod +x install.sh
./install.sh
```

### Instalación manual:
```bash
# 1. Kitty Terminal
mkdir -p ~/.config/kitty
cp dotfiles/kitty/kitty.conf ~/.config/kitty/
cp dotfiles/kitty/theme-switcher.sh ~/.config/kitty/
chmod +x ~/.config/kitty/theme-switcher.sh

# 2. Tmux
cp dotfiles/tmux/.tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux/scripts
cp dotfiles/tmux/scripts/*.sh ~/.tmux/scripts/
chmod +x ~/.tmux/scripts/*.sh

# 3. Neovim
mkdir -p ~/.config/nvim
cp -r dotfiles/nvim/* ~/.config/nvim/

# 4. Neofetch/Fastfetch
mkdir -p ~/.config/neofetch ~/.config/fastfetch
cp dotfiles/neofetch/neofetch.conf ~/.config/neofetch/
cp dotfiles/neofetch/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
```

---

## 🔧 Configuración Post-Instalación

### Tmux Plugins:
```bash
# Iniciar tmux
tmux

# Instalar plugins (desde dentro de tmux)
# Presiona Ctrl+Space, luego I (mayúscula)
```

### Neovim Plugins:
```bash
# Abrir Neovim
nvim

# Los plugins se instalarán automáticamente en el primer inicio
```

### Kitty Themes:
```bash
# Cambiar tema
~/.config/kitty/theme-switcher.sh tokyo

# Ver temas disponibles
~/.config/kitty/theme-switcher.sh list
```

---

## 🎨 Temas Disponibles

### Kitty Terminal:
1. **Main** - Rose-pine inspirado (por defecto)
2. **Moon** - Variante más oscura
3. **Tokyo Night** - Tema moderno con azules
4. **Catppuccin Mocha** - Tema cálido con colores pastel
5. **Dracula** - Tema clásico con colores vibrantes
6. **Gruvbox** - Tema retro inspirado
7. **Nord** - Tema minimalista ártico

### Tmux:
- Barra de estado con tema Catppuccin
- Información del sistema en tiempo real
- Indicadores de batería, CPU, red y disco

---

## 🛠️ Herramientas Incluidas

### Terminal:
- **Kitty** - Terminal GPU-accelerated
- **JetBrains Mono Nerd Font** - Fuente con iconos

### Desarrollo:
- **Neovim** - Editor con configuración avanzada
- **Tmux** - Multiplexor de terminal
- **Lazy.nvim** - Gestor de plugins
- **LSP** - Language Server Protocol

### Sistema:
- **Neofetch/Fastfetch** - Información del sistema
- **Scripts de monitoreo** - CPU, memoria, red, disco

---

## 🔄 Actualizaciones

Para actualizar las configuraciones:

```bash
# Actualizar repositorio principal
git pull origin main

# Reinstalar configuraciones
./install.sh
```

---

## 📝 Notas Importantes

1. **Fuentes**: Asegúrate de tener instalada JetBrains Mono Nerd Font
2. **Plugins**: Los plugins de tmux se instalan automáticamente con TPM
3. **Temas**: Puedes cambiar temas de Kitty sin reiniciar la terminal
4. **Sesiones**: Tmux guarda automáticamente las sesiones cada 15 minutos
5. **Integración**: Todas las configuraciones están optimizadas para trabajar juntas

---

## 🐛 Solución de Problemas

### Kitty:
```bash
# Verificar configuración
kitty --config ~/.config/kitty/kitty.conf

# Cambiar tema
~/.config/kitty/theme-switcher.sh main
```

### Tmux:
```bash
# Recargar configuración
tmux source ~/.tmux.conf

# Instalar plugins manualmente
prefix + I
```

### Neovim:
```bash
# Verificar plugins
:Lazy

# Actualizar plugins
:Lazy sync
```

---

## 📞 Soporte

Si encuentras problemas o tienes preguntas:

1. Revisa la documentación de cada repositorio original
2. Verifica que todas las dependencias estén instaladas
3. Comprueba los logs de error en cada aplicación
4. Abre un issue en el repositorio correspondiente

---

**¡Disfruta de tu entorno de desarrollo optimizado! 🚀** 