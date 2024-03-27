return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  { "APZelos/blamer.nvim" },

  { "AndrewRadev/linediff.vim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  { "rcarriga/nvim-notify", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
}
