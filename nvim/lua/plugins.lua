vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'preservim/nerdtree'
    use 'morhetz/gruvbox'
    -- syntastic cause hang on start since it is blocking.
    -- https://github.com/vim-syntastic/syntastic/issues/1370
    use 'dense-analysis/ale'
    use 'vim-airline/vim-airline'

    use 'neovim/nvim-lspconfig'
    use 'folke/which-key.nvim'
end)
