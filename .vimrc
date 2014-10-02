" General settings
set nocompatible                        " ignore vi compatibility
set history=1000                        " save large command history
set nowrap                              " don't wrap lines
set noruler                             " don't show ruler
set title                               " change terminal title
set hidden                              " don't close hidden buffers
set expandtab smarttab ts=4 sw=4        " tab settings (4 spaces)
set incsearch ignorecase smartcase      " search settings (smart)
set wildmenu wildmode=longest:full      " tab completion (unix-y)
set backspace=indent,eol,start          " backspace settings (easy)
set dir=~/.vimswp//,/tmp//,.            " set swap file location

if has("persistent_undo")
    set undofile                        " save undo history
    set undodir=~/.vimund//,/tmp//,.    " set undo file location
endif

" Use j/k smash to leave insert mode.
inoremap jk <esc>
inoremap kj <esc>

" Use ; for ex commands (double for normal ;).
noremap ; :
noremap ;; ;

" Use , for custom user commands (double for normal ,).
let mapleader = ','
noremap ,, ,

" Switch mapping so ' jumps to row AND column.
nnoremap ' `
nnoremap ` '

noremap <leader>d :w\|Dispatch<cr>

noremap <leader>h :call WinMove('h')<cr>
noremap <leader>k :call WinMove('k')<cr>
noremap <leader>l :call WinMove('l')<cr>
noremap <leader>j :call WinMove('j')<cr>

function! WinMove(key)
    let t:curwin = winnr()

    " try to move
    exec "wincmd ".a:key

    " if that doesn't work, we're at the edge
    if(t:curwin == winnr())
        if(match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Use better plugin for % matching.
runtime macros/matchit.vim

" Activate other plugins (if pathogen installed).
silent! execute pathogen#infect()

" Detect plugins/autoindent based on filetype.
filetype plugin indent on

" Use syntax highlighting.
syntax on

silent! source ~/.vimrc_local
