vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true })

-- Swap ; and :
vim.keymap.set('v', ';', ':', { noremap = true })
vim.keymap.set('v', ':', ';', { noremap = true })
vim.keymap.set('n', ';', ':', { noremap = true })
vim.keymap.set('n', ':', ';', { noremap = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })

vim.keymap.set({ 'v', 'n' }, '<leader>y', '"+y', {})
vim.keymap.set({ 'v', 'n' }, '<leader>Y', '"+Y', {})
vim.keymap.set({ 'v', 'n' }, '<leader>p', '"+p', {})
vim.keymap.set({ 'v', 'n' }, '<leader>P', '"+P', {})

-- Use escape to exit term mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Press <C-t> to fix a previous typo
vim.keymap.set('i', '<C-t>', '<c-g>u<Esc>[s1z=`]a<c-g>u', { noremap = true })
