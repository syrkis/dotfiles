call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot', {'branch': 'master'}
Plug 'godlygeek/tabular', {'branch': 'master'}
Plug 'lervag/vimtex', {'branch': 'master'}


call plug#end()

" syntax
" syntax on

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

augroup markdown
  autocmd!
  " Trigger for Markdown files
  autocmd FileType markdown call MarkdownSettings()
augroup END

function! MarkdownSettings()
  " Minimalistic settings for Markdown
  setlocal nonumber        " Hide line numbers
  setlocal norelativenumber
  setlocal noshowmode      " Don't show mode like -- INSERT --
  setlocal nocursorline    " Disable cursor line
  setlocal foldenable      " Enable folding
  setlocal nofoldenable    " But start with folds open
  setlocal colorcolumn=0   " No color column
  setlocal wrap            " Enable text wrapping
  setlocal showbreak=      " Set wrapped line indicator to empty or something subtle
  setlocal linebreak       " Wrap lines at word (not in the middle)
  setlocal foldmethod=manual
  setlocal laststatus=0    " Hide the status line
  setlocal noruler         " Hide the ruler
  setlocal syntax=
  setlocal breakindent     " Make wrapped lines visually distinct

  " Remap navigation keys for wrapped lines
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk

  " Create a silent save function
  function! SilentSave()
    silent! write
    " Clear the command line to remove any residual messages
    redraw!
  endfunction

  " Silent mappings for :w and :write to the SilentSave function for Markdown files
  nnoremap <silent> <buffer> :w :call SilentSave()<CR>
  nnoremap <silent> <buffer> :write :call SilentSave()<CR>
endfunction
