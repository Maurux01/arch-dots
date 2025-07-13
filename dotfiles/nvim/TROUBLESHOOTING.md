# 🔧 Solución de Problemas - Neovim

## 🚨 Problemas Comunes y Soluciones

### 1. **Plugins de IA no funcionan**

#### Codeium
```bash
# Verificar instalación
nvim --headless -c "lua print(require('codeium'))"

# Si hay error, reinstalar:
# 1. Eliminar plugin
rm -rf ~/.local/share/nvim/lazy/codeium.nvim
# 2. Reinstalar con Lazy
:Lazy sync
```

#### Copilot
```bash
# Verificar autenticación
:checkhealth copilot

# Si no está autenticado:
# 1. Instalar GitHub CLI
sudo pacman -S github-cli
# 2. Autenticarse
gh auth login
# 3. Instalar Copilot CLI
npm install -g @githubnext/github-copilot-cli
```

### 2. **Temas no se cargan**

#### Monokai Pro
```lua
-- Verificar en Neovim:
:colorscheme monokai-pro

-- Si hay error, verificar instalación:
:Lazy sync
```

#### GitHub Theme
```lua
-- Verificar en Neovim:
:colorscheme github_dark

-- Si hay error:
:Lazy sync
```

### 3. **LSP no funciona**

#### Verificar LSP
```lua
-- En Neovim:
:LspInfo
:LspLog

-- Verificar servidores instalados:
:LspInstallInfo
```

#### Instalar LSP servers manualmente
```bash
# Para diferentes lenguajes
npm install -g typescript typescript-language-server
npm install -g @tailwindcss/language-server
npm install -g @astrojs/language-server
npm install -g svelte-language-server
npm install -g vscode-langservers-extracted
npm install -g @prisma/language-server
npm install -g emmet-ls
npm install -g @fsouza/prettierd
npm install -g eslint_d
npm install -g @typescript-eslint/parser
npm install -g @typescript-eslint/eslint-plugin
npm install -g eslint-config-prettier
npm install -g eslint-plugin-prettier
npm install -g prettier
npm install -g stylelint
npm install -g stylelint-config-standard
npm install -g stylelint-config-prettier
npm install -g stylelint-config-recommended
npm install -g stylelint-config-recommended-scss
npm install -g stylelint-config-recommended-vue
npm install -g stylelint-config-standard
npm install -g stylelint-config-standard-scss
npm install -g stylelint-config-standard-vue
npm install -g stylelint-config-standard-html
npm install -g stylelint-config-standard-js
npm install -g stylelint-config-standard-json
npm install -g stylelint-config-standard-markdown
npm install -g stylelint-config-standard-yaml
npm install -g stylelint-config-standard-toml
npm install -g stylelint-config-standard-css
npm install -g stylelint-config-standard-less
npm install -g stylelint-config-standard-sass
npm install -g stylelint-config-standard-stylus
npm install -g stylelint-config-standard-postcss
npm install -g stylelint-config-standard-scss
npm install -g stylelint-config-standard-vue
npm install -g stylelint-config-standard-html
npm install -g stylelint-config-standard-js
npm install -g stylelint-config-standard-json
npm install -g stylelint-config-standard-markdown
npm install -g stylelint-config-standard-yaml
npm install -g stylelint-config-standard-toml
npm install -g stylelint-config-standard-css
npm install -g stylelint-config-standard-less
npm install -g stylelint-config-standard-sass
npm install -g stylelint-config-standard-stylus
npm install -g stylelint-config-standard-postcss
```

### 4. **CMP (Autocompletado) no funciona**

#### Verificar CMP
```lua
-- En Neovim:
:CmpStatus

-- Verificar fuentes:
:CmpSources
```

#### Problemas comunes de CMP
```lua
-- Si CMP no aparece, verificar:
:checkhealth cmp

-- Si hay conflictos con Tab:
-- Verificar keymaps en keymaps.lua
```

### 5. **Telescope no funciona**

#### Verificar Telescope
```lua
-- En Neovim:
:Telescope find_files

-- Si hay error:
:checkhealth telescope
```

#### Dependencias faltantes
```bash
# Instalar fd (faster than find)
sudo pacman -S fd

# Instalar ripgrep
sudo pacman -S ripgrep

# Instalar bat (para preview)
sudo pacman -S bat
```

### 6. **Treesitter no funciona**

#### Verificar Treesitter
```lua
-- En Neovim:
:TSInstallInfo
:TSUpdate

-- Verificar parsers instalados:
:TSInstall lua
:TSInstall javascript
:TSInstall typescript
:TSInstall python
:TSInstall rust
:TSInstall go
:TSInstall c
:TSInstall cpp
:TSInstall java
:TSInstall php
:TSInstall ruby
:TSInstall sql
:TSInstall xml
:TSInstall toml
:TSInstall dockerfile
:TSInstall gitignore
:TSInstall vim
:TSInstall vimdoc
```

### 7. **Problemas de rendimiento**

#### Optimizar Neovim
```lua
-- Verificar plugins lentos:
:Lazy profile

-- Limpiar caché:
:Lazy clean

-- Actualizar todos los plugins:
:Lazy sync
```

#### Configuración de rendimiento
```lua
-- En init.lua, agregar:
vim.opt.updatetime = 100
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240
```

### 8. **Problemas de fuentes**

#### Verificar fuentes
```bash
# Verificar fuentes instaladas
fc-list | grep -i "nerd"

# Instalar fuentes Nerd Fonts
sudo pacman -S nerd-fonts-complete
```

### 9. **Problemas de permisos**

#### Verificar permisos
```bash
# Verificar permisos de Neovim
ls -la ~/.config/nvim/
ls -la ~/.local/share/nvim/

# Corregir permisos si es necesario
chmod -R 755 ~/.config/nvim/
chmod -R 755 ~/.local/share/nvim/
```

### 10. **Diagnóstico completo**

#### Script de diagnóstico
```bash
# Ejecutar diagnóstico completo
nvim --headless -c "lua dofile('check-plugins.lua')"
```

#### Comandos de verificación
```lua
-- En Neovim:
:checkhealth
:Lazy health
:LspInfo
:CmpStatus
:Telescope find_files
:TSInstallInfo
```

## 🔧 Comandos útiles

### Verificar estado de plugins
```lua
:Lazy
:Lazy sync
:Lazy clean
:Lazy log
:Lazy profile
```

### Verificar LSP
```lua
:LspInfo
:LspLog
:LspInstallInfo
:LspStart
:LspStop
:LspRestart
```

### Verificar Treesitter
```lua
:TSInstallInfo
:TSUpdate
:TSBufToggle highlight
:TSBufToggle indent
:TSBufToggle autotag
```

### Verificar Telescope
```lua
:Telescope find_files
:Telescope live_grep
:Telescope buffers
:Telescope help_tags
```

## 📞 Obtener ayuda

1. **Verificar logs**: `:Lazy log`
2. **Verificar salud**: `:checkhealth`
3. **Diagnóstico**: Ejecutar `check-plugins.lua`
4. **Reinstalar**: `:Lazy clean` seguido de `:Lazy sync`

## 🎯 Soluciones rápidas

### Si nada funciona:
```bash
# 1. Limpiar todo
rm -rf ~/.local/share/nvim
rm -rf ~/.config/nvim

# 2. Reinstalar
cp -r dotfiles/nvim ~/.config/
cd ~/.config/nvim
./install.sh
``` 