call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot', {'branch': 'master'}

call plug#end()


" Use system clipboard by default
set clipboard+=unnamedplus

" Enable line numbers
set number

" Set tab indentation to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Set the color scheme (you'll need to install your color scheme of choice)
" colorscheme desert

