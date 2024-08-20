local opt = vim.opt

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

opt.clipboard = "unnamedplus" -- Use system clipboard

opt.mouse = "" -- Disable mouse support
opt.scrolloff = 5 -- Start scrolling when we're 5 lines away from margins
opt.gdefault = true -- Use global search and replace by default

opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers

opt.expandtab = true -- Convert tabs to spaces
opt.tabstop = 2 -- Number of spaces in a tab
opt.softtabstop = 2 -- Number of spaces in a soft tab
opt.shiftwidth = 2 -- Number of spaces to use for autoindent

opt.ignorecase = true -- Ignore case in search patterns
opt.undofile = true -- Enable persistent undo

opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

opt.pumheight = 10 -- Maximum number of entries in a popup
