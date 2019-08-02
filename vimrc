let g:mapleader = " "

set nocompatible
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
set fileformat=unix
set fileformats=unix,dos,mac
set tw=200
set termencoding=utf-8
set hlsearch
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
set autoread
set writebackup
set nobackup
set ignorecase
set smartcase
set nonumber
set laststatus=2
set showtabline=1
set cmdheight=1
set cursorline
set nowrap

" https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/issues/31
set t_BE=

filetype on
filetype plugin on
filetype plugin indent on
syntax on

autocmd filetype python setlocal colorcolumn=80
autocmd Filetype html setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype javascript setlocal textwidth=79 shiftwidth=2 tabstop=2
autocmd Filetype css setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype stylus setlocal shiftwidth=2 tabstop=2

""""""""""""""""""""""""""""""""""
" shortcut keys with leader prefix
""""""""""""""""""""""""""""""""""

nmap cS :%s/\s\+$//g<cr>:noh<cr>
nmap cM :%s/\r$//g<cr>:noh<cr>
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
nnoremap <leader>bk :bdelete<cr>
nnoremap <leader>bl :buffers<cr>
nnoremap <leader>ee :edit $MYVIMRC<Cr>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <F2> :silent! NERDTreeToggle<CR>
nnoremap tt :silent! NERDTreeToggle<CR>
nnoremap tn :tab new<CR>
nmap tl :TagbarClose<cr>:Tlist<cr>
nmap tb :TagbarToggle<CR>
map <leader>wn <C-W>w
map <leader>wp <C-W>W
nnoremap co :copen<CR>
nnoremap cc :ccl<CR>
nnoremap cn :cn<CR>
nnoremap cp :cp<CR>
nnoremap cw :q<CR>

""""""""""""""""""""""""""""""""""

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

if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
else
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif

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
