" Gruvbox theme for Neovim
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set termguicolors
syntax enable
colorscheme gruvbox

" Plugins (usando vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
call plug#end() 