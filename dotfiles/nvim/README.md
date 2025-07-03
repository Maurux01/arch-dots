# Neovim IDE Config

Esta configuración convierte Neovim en una IDE moderna, rápida y visualmente atractiva, con:
- LSP y autocompletado para todos los lenguajes
- Animaciones suaves
- IA integrada (Copilot, Codeium, ChatGPT)
- Temas populares (Catppuccin, Gruvbox, Tokyo Night, Nord, Dracula, One Dark, Solarized, etc.)
- Keybinds fáciles de aprender (mezcla de VSCode y Vim)
- Árbol de archivos, barra de estado, iconos, fuzzy finder, git, terminal, snippets, y más

## Instalación
1. Abre Neovim y ejecuta `:Lazy sync` para instalar los plugins.
2. Cambia de tema con `<leader>cc`.
3. Consulta los atajos en `keybinds.md`.

## IA
- Copilot: requiere cuenta de GitHub y login en Neovim (`:Copilot setup`).
- Codeium: gratis, solo instala y funciona.
- ChatGPT: requiere API key (ver documentación del plugin).

## Personalización
- Edita los archivos en `lua/` para agregar o quitar plugins, cambiar keybinds, etc. 