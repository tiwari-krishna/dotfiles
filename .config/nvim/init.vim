call plug#begin('$HOME/.config/nvim/autoload/')
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'gmarik/Vundle.vim'
Plug 'suan/vim-instant-markdown'
Plug 'vimwiki/vimwiki'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'kovetskiy/sxhkd-vim'
Plug 'junegunn/goyo.vim'
Plug 'vim-python/python-syntax'
Plug 'junegunn/vim-emoji'
Plug 'vifm/vifm.vim'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'lervag/vimtex'
call plug#end()

set number relativenumber
set path+=**
set showcmd
syntax enable
set noshowmode
set wildmenu
set incsearch
set hidden
set clipboard=unnamedplus
set nobackup
set nocompatible
set showmatch
set expandtab
filetype indent on
set laststatus=2
set lazyredraw
set tabstop=4
set softtabstop=4
let g:python_highlight_all = 1
