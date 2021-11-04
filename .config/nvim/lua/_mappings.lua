local map = vim.api.nvim_set_keymap

-- Remap space as leader key
-- map('', '<Space>', '<Nop>', {noremap = true, silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'",
    {noremap = true, expr = true, silent = true})
map('n', 'j', "v:count == 0 ? 'gj' : 'j'",
    {noremap = true, expr = true, silent = true})

-- Swap ; and :
map('v', ';', ':', {noremap = true})
map('v', ':', ';', {noremap = true})
map('n', ';', ':', {noremap = true})
map('n', ':', ';', {noremap = true})
map('i', 'jk', '<Esc>', {noremap = true})

-- " " Copy to clipboard
-- map('x', '"+y', 'y:call system("wl-copy", @")<cr>', {noremap=true})
-- map('n', '"+p', ':let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p', {noremap=true})
-- map('n', '"*p', ':let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p', {noremap=true})

map('v', '<leader>y', '"+y', {})
map('n', '<leader>Y', '"+yg_', {})
map('n', '<leader>y', '"+y', {})
map('n', '<leader>yy', '"+yy', {})

-- " Paste from clipboard
map('n', '<leader>p', '"+p', {})
map('n', '<leader>P', '"+P', {})
map('v', '<leader>p', '"+p', {})
map('v', '<leader>P', '"+P', {})

-- Shift-Alt-j/k deletes blank line below/above, and Alt-j/k inserts.
map('n', '<silent><A-J>', 'm`:silent +g/\\m^\\s*$/d<CR>``:noh<CR>',
    {noremap = true})
map('n', '<silent><A-K>', 'm`:silent -g/\\m^\\s*$/d<CR>``:noh<CR>',
    {noremap = true})
map('n', '<silent><A-j>', ':set paste<CR>m`o<Esc>``:set nopaste<CR>',
    {noremap = true})
map('n', '<silent><A-k>', ':set paste<CR>m`O<Esc>``:set nopaste<CR>',
    {noremap = true})

-- Use escape to exit term mode
map('t', '<Esc>', '<C-\\><C-n>', {noremap = true})

-- Press <C-t> to fix a previous typo
map('i', '<C-t>', '<c-g>u<Esc>[s1z=`]a<c-g>u', {noremap = true})
