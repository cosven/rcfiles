call plug#begin()

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --clang-completer' }
" Plug 'ctrlpvim/ctrlp.vim'

" vim-molokai
Plug 'tomasr/molokai'

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)']  }
Plug 'godlygeek/tabular'

" Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
" Plug 'suan/vim-instant-markdown'
" Plug 'scrooloose/syntastic'  " tow slow
"
" 不会用，每次一有错误，光标就看不见了。fuck!!!
" Plug 'w0rp/ale'
" Plug 'neomake/neomake'
" Plug 'vim-airline/vim-airline'
Plug 'kshenoy/vim-signature'
Plug 'lepture/vim-jinja'
Plug 'kien/rainbow_parentheses.vim'
Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
" Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/vim-tomorrow-theme'

" themes
Plug 'altercation/vim-colors-solarized'


" Plug 'CodeFalling/fcitx-vim-osx'
" Add plugins to &runtimepath
call plug#end()

source ~/coding/rcfiles/base.vim

" to support true color
set termguicolors

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

let NERDTreeIgnore = ['\.pyc$', 'eggs', 'old-eggs', '\.egg-info$', 'bin']
let g:indentLine_char = '|'

let NERDSpaceDelims = 1

let g:pydiction_location = '~/.vim/complete-dict'
let g:pydiction_menu_height = 3

" comment this to enable 24-bit color
" set t_Co=256
syntax on
" set background=dark
colorscheme Tomorrow-Night-Bright

filetype plugin on
au BufEnter *.txt setlocal ft=txt
"set autochdir

" nmap <F8> :AuthorInfoDetect<CR>
"
set fillchars=vert:\|

let g:bookmark_save_per_working_dir = 1
set termencoding=utf-8
set hlsearch

" nmap <C-P> :CtrlP<CR>
nmap <C-P> :FZF<CR>
" let $FZF_DEFAULT_COMMAND = 'git ls-files'
let $FZF_DEFAULT_COMMAND = 'ag -l'

autocmd Filetype gitcommit setlocal spell textwidth=72

set backspace=2
let g:flake8_show_in_gutter=1

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



set wildignore+=*/node_modules/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" let g:airline#extensions#tabline#enabled = 1

"""""""""""
" YouCompleteMe 配置
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>ju :YcmCompleter GoToReferences<CR>

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:deoplete#auto_completion_start_length = 2

" let g:jedi#completions_enabled = 0
" let g:jedi#usages_command = "<leader>ju"
" let g:jedi#goto_definitions_command = "<leader>jd"
" let g:jedi#rename_command = "<leader>jr"
" let g:jedi#goto_assignments_command = "<leader>jg"
" let g:jedi#documentation_command = "<leader>js"

autocmd BufWinEnter '__doc__' setlocal bufhidden=delete


source ~/coding/rcfiles/common.vim
