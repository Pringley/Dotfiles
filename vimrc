""""""""""""""""""""
" GENERAL SETTINGS "
""""""""""""""""""""
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

if has("persistent_undo")
    set undofile                        " save undo history
endif

syntax on                               " Use syntax highlighting.

"""""""""""""""""""""
" PERSONAL MAPPINGS "
"""""""""""""""""""""

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

noremap <leader>w :w<cr>
noremap <leader>q :wq<cr>

noremap <leader>m :w\|make<cr>
noremap <leader>t :w\|make test<cr>
noremap <leader>c :w\|make clean<cr>

noremap <leader>fa :w\|!fab all<cr>
noremap <leader>fd :w\|!fab deploy<cr>
noremap <leader>ft :w\|!fab test<cr>

noremap <leader>e :w\|call CallScript()<cr>
noremap <leader>h :call WinMove('h')<cr>
noremap <leader>k :call WinMove('k')<cr>
noremap <leader>l :call WinMove('l')<cr>
noremap <leader>j :call WinMove('j')<cr>

"""""""""""
" PLUGINS "
"""""""""""

" Use better plugin for % matching
runtime macros/matchit.vim

" Temporarily turn off filetype (for Vundle).
filetype off

" Use Vundle for bundle management (if installed).
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if filereadable(vundle_readme)
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gmarik/vundle'
    Bundle 'kien/ctrlp.vim'
    Bundle 'msanders/snipmate.vim'
endif

" Detect plugins/autoindent based on filetype.
filetype plugin indent on

"""""""""""""""""""""
" DEFINED FUNCTIONS "
"""""""""""""""""""""

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

function! CallScript()
    execute("w")
 
    let l:filetype = expand("%:e")
    if(l:filetype == "py")
        execute("!python %")
    elseif(l:filetype == "rb")
        execute("!ruby %")
    elseif(l:filetype == "sh")
        execute("!bash %")
    elseif(l:filetype == "c")
        execute("!gcc -Wall -o /tmp/a.out % && /tmp/a.out")
    elseif(l:filetype == "cpp")
        execute("!g++ -Wall -o /tmp/a.out % && /tmp/a.out")
    elseif(l:filetype == "java")
        execute("!javac -d /tmp % && java -classpath /tmp %:t:r")
    elseif(l:filetype == "scala")
        execute("!scalac -d /tmp % && scala -classpath /tmp %:t:r")
    else
        echom "Unsupported type".l:filetype
    endif
 
endfunction
