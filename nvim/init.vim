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
set laststatus=2  " 2=show, 0=hide
set showtabline=1
set cmdheight=1
set cursorline
set nowrap

set background=dark

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
nnoremap <leader>ee :edit $MYVIMRC<Cr>
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap tn :tab new<CR>
map <leader>wn <C-W>w
map <leader>wp <C-W>W
nnoremap co :copen<CR>
nnoremap cc :ccl<CR>
nnoremap cn :cn<CR>
nnoremap cp :cp<CR>
nnoremap cw :q<CR>


lua << EOF
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'preservim/nerdtree'
    use {
        'nvim-telescope/telescope.nvim',
        -- branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} },
    }
    use 'morhetz/gruvbox'
    -- syntastic cause hang on start since it is blocking.
    -- https://github.com/vim-syntastic/syntastic/issues/1370
    use 'dense-analysis/ale'
    use 'vim-airline/vim-airline'

    use {
        'neovim/nvim-lspconfig',
        config = function() 
            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Disable inline diagnostic message. 
                vim.diagnostic.config({virtual_text = false})

                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap=true, silent=true, buffer=bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)

                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

                vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
            end

            local lsp_flags = {
              -- This is the default in Nvim 0.7+
              debounce_text_changes = 150,
            }
            require('lspconfig')['pyright'].setup{
                on_attach = on_attach,
                flags = lsp_flags,
            }
            require('lspconfig')['tsserver'].setup{
                on_attach = on_attach,
                flags = lsp_flags,
            }
            require('lspconfig')['rust_analyzer'].setup{
                on_attach = on_attach,
                flags = lsp_flags,
                -- Server-specific settings...
                settings = {
                  ["rust-analyzer"] = {}
                }
            }
        end
    }
    use 'folke/which-key.nvim'
end)
EOF

colorscheme gruvbox

nnoremap <leader><leader> :Telescope<cr>
nnoremap <leader>lb :Telescope buffers<cr>
nnoremap <leader>le :Telescope diagnostic<cr>

nnoremap <C-P> <cmd>lua require("telescope.builtin").find_files({previewer=false})<cr>
nnoremap f <cmd>lua require("telescope.builtin").live_grep({default_text=vim.fn.expand("<cword>"),previewer=false})<cr>
nnoremap <f2> :NERDTreeToggle<CR>
