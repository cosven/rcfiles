call pathogen#infect()

"""
:nnoremap <leader>feR :source $MYVIMRC<cr>
:nnoremap <leader>fed :o $MYVIMRC<cr>
"""



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

set encoding=utf-8
set fileencoding=utf-8

set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1

set fileformat=unix 
set fileformats=unix,dos,mac

set tw=200

if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
else
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
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

imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>

set number
set laststatus=2
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


let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd="ctags"
let Tlist_Use_Right_Window=1

nmap tl :TagbarClose<cr>:Tlist<cr>
nmap tb :TagbarToggle<CR>
let g:tagbar_ctags_bin="ctags"
let g:tagbar_width=30

if has("cscope")
  set csprg=cscope
  set csto=1
  set cst
  set nocsverb
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  set csverb
endif

set cscopequickfix=s-,c-,d-,i-,t-,e-

map <F2> :silent! NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
let g:indentLine_char = '|'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

map <F7> <leader>cc
map <C-F7> <leader>cu
let NERDSpaceDelims = 1

let g:pydiction_location = '~/.vim/complete-dict'
let g:pydiction_menu_height = 3

"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
let g:solarized_termcolors=256
set background=dark
colorscheme default

syntax on
filetype plugin on 
au BufEnter *.txt setlocal ft=txt
"set autochdir

" nmap <F8> :AuthorInfoDetect<CR>
"
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\
set t_Co=256

let g:bookmark_save_per_working_dir = 1
set guifont=Monaco:h14
set termencoding=utf-8
set hlsearch

let g:vimrc_author='ysw'
let g:vimrc_email='yinshaowen241@gmail.com'
let g:vimrc_homepage='http://www.cosven.com'
nmap <F4> :AuthorInfoDetect<cr>
nmap <C-F> :CtrlSF 

let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
autocmd Filetype gitcommit setlocal spell textwidth=72

set backspace=2
autocmd Filetype python map <buffer> <F8> :call Flake8()<CR>
let g:flake8_show_in_gutter=1
let g:flake8_max_line_length=80

autocmd filetype python setlocal colorcolumn=79
autocmd Filetype html setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype js setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype css setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype stylus setlocal shiftwidth=2 tabstop=2
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
autocmd BufNewFile,BufRead GHI_ISSUE_* setlocal filetype=ghmarkdown
set mouse=a

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

let g:todoSymbol = {
    \ "doing"  : "?",
    \ "open"   : "✖",
    \ "close"  : "✔︎"
    \ }

"""""""""""
" 键位映射
let g:mapleader = " "

let g:utl_cfg_hdl_scm_http_system = "silent !open '%u'"
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
behave mswin
let g:jsx_ext_required = 0
let g:syntastic_python_python_exec = '/usr/bin/env python3'
