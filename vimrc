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
set dir=~/.vimswp//,/tmp//,.            " set swap file location

if has("persistent_undo")
    set undofile                        " save undo history
    set undodir=~/.vimund//,/tmp//,.    " set undo file location
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

noremap <leader>d :w\|Dispatch<cr>
noremap <leader>m :w\|make<cr>
noremap <leader>t :w\|make test<cr>
noremap <leader>c :w\|make clean<cr>

noremap <leader>fa :w\|!fab all<cr>
noremap <leader>fd :w\|!fab deploy<cr>
noremap <leader>ft :w\|!fab test<cr>

noremap <leader>e :w\|call CallScript()<cr>
noremap <leader>p :call ToggleProse()<cr>

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

    " Bundle management
    Bundle 'gmarik/vundle'

    " Fuzzy file finder
    Bundle 'kien/ctrlp.vim'

    " Textmate-like snippets
    Bundle 'msanders/snipmate.vim'

    " Git plugin
    Bundle 'tpope/vim-fugitive'

    " Asynchronous tasks
    Bundle 'tpope/vim-dispatch'
endif

" Settings
let g:ctrlp_clear_cache_on_exit = 0             " save ctrl+p cache

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
    elseif(l:filetype == "go")
        execute("!go run %")
    elseif(l:filetype == "c")
        execute("!gcc -Wall -o /tmp/a.out % && /tmp/a.out")
    elseif(l:filetype == "cpp")
        execute("!g++ -Wall -o /tmp/a.out % && /tmp/a.out")
    elseif(l:filetype == "cs")
        execute("!gmcs -out:/tmp/a.out % && mono /tmp/a.out")
    elseif(l:filetype == "java")
        execute("!javac -d /tmp % && java -classpath /tmp %:t:r")
    elseif(l:filetype == "scala")
        execute("!scalac -d /tmp % && scala -classpath /tmp %:t:r")
    elseif(l:filetype == "md" || l:filetype == "txt" || l:filetype == "markdown")
        execute("!pandoc -f Markdown -o /tmp/p.out.html -sS % && xdg-open /tmp/p.out.html")
    else
        execute("!./%")
    endif
 
endfunction

function! ToggleProse()
    if(!exists("b:prosemode"))
        let b:prosemode = 0
    endif

    if(b:prosemode == 0)
        let b:noprose_fo = &fo
        let b:prosemode = 1
        set fo+=a
        echom "Prose mode activated"
    else
        let b:prosemode = 0
        let &fo=b:noprose_fo
        echom "Prose mode deactivated"
    endif
endfunction
