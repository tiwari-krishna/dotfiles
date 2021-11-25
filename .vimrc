call plug#begin('~/.vim/autoload/')
Plug 'tpope/vim-sensible'
Plug 'gmarik/Vundle.vim'     
Plug 'itchyny/lightline.vim' 
Plug 'suan/vim-instant-markdown'
Plug 'vimwiki/vimwiki' 
Plug 'vim-python/python-syntax' 
Plug 'junegunn/vim-emoji'
Plug 'vifm/vifm.vim' 
Plug 'scrooloose/nerdtree' 
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons' 

call plug#end()

set number
set wildmenu
set path+=**
syntax enable
set tabstop=4
set softtabstop=4
set expandtab
set showcmd
filetype indent off
set wildmenu
set lazyredraw
set showmatch
set nocompatible 
set number relativenumber 
set clipboard=unnamedplus
set nobackup  
set incsearch  
set hidden  

set laststatus=2
set noshowmode
let g:python_highlight_all = 1
