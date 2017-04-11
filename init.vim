call plug#begin()

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" On-demand loading
Plug 'scrooloose/nerdtree'

" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'neovim/python-client'

Plug 'scrooloose/nerdcommenter'
Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'rking/ag.vim'
Plug 'majutsushi/tagbar'
Plug 'joshdick/onedark.vim'
Plug 'godlygeek/tabular'
Plug 'suan/vim-instant-markdown'
Plug 'junegunn/goyo.vim'
Plug 'lepture/vim-jinja'
Plug 'kshenoy/vim-signature'
Plug 'cosven/feeluown.vim'
Plug 'ntpeters/vim-better-whitespace'

" themes
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'nanotech/jellybeans.vim'
Plug 'rakr/vim-one'
Plug 'jacoborus/tender.vim'

" Add plugins to &runtimepath
call plug#end()

let g:mapleader = " "
map <F2> :silent! NERDTreeToggle<CR>

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

set nonumber
set showtabline=1
set laststatus=-1
set cmdheight=1
set nocursorline

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
let NERDTreeIgnore = ['\.pyc$', 'eggs', 'old-eggs', '\.egg-info$', 'bin']
let g:indentLine_char = '|'

let NERDSpaceDelims = 1

let g:pydiction_location = '~/.vim/complete-dict'
let g:pydiction_menu_height = 3

set termguicolors
set background=dark
colorscheme molokai
set background=dark

syntax on
filetype plugin on
au BufEnter *.txt setlocal ft=txt
"set autochdir

" nmap <F8> :AuthorInfoDetect<CR>
"
set fillchars+=stl:\ ,stlnc:\
set t_Co=256

let g:bookmark_save_per_working_dir = 1
set termencoding=utf-8
set hlsearch

let g:vimrc_author='ysw'
let g:vimrc_email='yinshaowen241@gmail.com'
let g:vimrc_homepage='http://www.cosven.com'
nmap <F4> :AuthorInfoDetect<cr>
" nmap <C-F> :CtrlSF
"
nmap <C-P> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'git ls-files'

autocmd Filetype gitcommit setlocal spell textwidth=72

set backspace=2
autocmd Filetype python map <buffer> <F8> :call Flake8()<CR>
let g:flake8_show_in_gutter=1

autocmd filetype python setlocal colorcolumn=80
autocmd Filetype html setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype javascript setlocal textwidth=79 shiftwidth=2 tabstop=2
autocmd Filetype css setlocal textwidth=200 shiftwidth=2 tabstop=2
autocmd Filetype stylus setlocal shiftwidth=2 tabstop=2
" augroup markdown
"     au!
"     au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
" augroup END
autocmd BufNewFile,BufRead GHI_ISSUE_* setlocal filetype=ghmarkdown
autocmd BufNewFile,BufRead Jenkinsfile* setlocal filetype=groovy
autocmd BufEnter * EnableStripWhitespaceOnSave
set mouse=a

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

let g:utl_cfg_hdl_scm_http_system = "silent !open '%u'"
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 0
let g:vim_json_syntax_conceal = 0
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_html_tidy_ignore_errors = [
            \ 'trimming empty <i>',
            \ 'trimming empty <span>',
            \ '<input> proprietary attribute \"autocomplete\"',
            \ 'proprietary attribute \"role\"',
            \ 'proprietary attribute \"hidden\"',
            \ 'proprietary attribute \"ng-',
            \ '<svg> is not recognized!',
            \ 'discarding unexpected <svg>',
            \ 'discarding unexpected </svg>',
            \ '<rect> is not recognized!',
            \ 'discarding unexpected <rect>'
            \ ]

" let g:airline#extensions#tabline#enabled = 1
if (g:isGUI)
    let g:airline_powerline_fonts = 0
else
    let g:airline_powerline_fonts = 0
endif
let g:airline_theme='gruvbox'

set wildignore+=*/node_modules/*


"""""""""""
" YouCompleteMe 配置
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>jr :YcmCompleter GoToReferences<CR>

autocmd! BufWritePost * Neomake
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:deoplete#auto_completion_start_length = 1

let g:jedi#completions_enabled = 0
let g:jedi#usages_command = "<leader>ju"
let g:jedi#goto_definitions_command = "<leader>jd"
let g:jedi#rename_command = "<leader>jr"
let g:jedi#goto_assignments_command = "<leader>jg"
let g:jedi#documentation_command = "<leader>js"

autocmd BufWinEnter '__doc__' setlocal bufhidden=delete

nnoremap <leader>er :source $MYVIMRC<CR>
nnoremap <leader>ee :edit $MYVIMRC<Cr>

nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
nnoremap <leader>bk :bdelete<cr>
nnoremap <leader>bl :buffers<cr>

nnoremap <leader>f :Ag

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
