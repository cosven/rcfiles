let g:mapleader = " "

if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

set nocompatible

" set encoding=utf-8
set fileencoding=utf-8

set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1

set fileformat=unix
set fileformats=unix,dos,mac

set tw=200

" https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/issues/31
set t_BE=

if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
else
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif

filetype on
filetype plugin on
filetype plugin indent on
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab

set foldenable
set foldmethod=indent
set foldlevelstart=99

set synmaxcol=128
set lazyredraw

" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
set autoread

nmap cS :%s/\s\+$//g<cr>:noh<cr>

nmap cM :%s/\r$//g<cr>:noh<cr>

set ignorecase
set smartcase

set nonumber
set laststatus=2
set showtabline=1
set cmdheight=1
set cursorline


set nowrap

if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

set writebackup
set nobackup

autocmd filetype python setlocal colorcolumn=80
autocmd Filetype html setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype javascript setlocal textwidth=79 shiftwidth=2 tabstop=2
autocmd Filetype css setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype stylus setlocal shiftwidth=2 tabstop=2


