call plug#begin('~/.config/nvim/plugged')
Plug 'hhvm/vim-hack'
Plug getcwd()
call plug#end()

syntax enable
set mouse=a
set number
set nowrap

set ts=2 sts=2 sw=2 et
set autoindent
filetype plugin indent on
