set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-eunuch'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'kien/ctrlp.vim'
call vundle#end()

" General settings
set history=1000                        " save large command history
set nowrap                              " don't wrap lines
set noruler                             " don't show ruler
set title                               " change terminal title
set nohidden                            " close hidden buffers
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

nnoremap <leader>q :wq<cr>
nnoremap <leader>e :e %:h/
nnoremap <leader>d :w\|Dispatch<cr>

nnoremap <leader>h :call WinMove('h')<cr>
nnoremap <leader>k :call WinMove('k')<cr>
nnoremap <leader>l :call WinMove('l')<cr>
nnoremap <leader>j :call WinMove('j')<cr>

nnoremap <leader>! :e! /tmp/vimcmd.out<cr>ggVGd!!

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

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore .git5_specs
      \ --ignore review
      \ -g ""'

silent! source ~/.vimrc_work
silent! source ~/.vimrc_local

" Detect plugins/autoindent based on filetype.
filetype plugin indent on

" Use syntax highlighting.
syntax on
