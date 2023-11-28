-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.g.blamer_enabled = true
vim.diagnostic.config({ virtual_text = false })

local opt = vim.opt

opt.relativenumber = false
opt.tabstop = 4
