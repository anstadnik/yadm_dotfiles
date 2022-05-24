vim.o.tabstop = 2
vim.g.noexpandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.inccommand = 'split' -- Incremental live completion
vim.o.hlsearch = true -- Set highlight on search
vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true
vim.o.hidden = true -- Do not save when switching buffers
-- vim.o.mouse = 'a' --Enable mouse mode
vim.o.breakindent = true -- Enable break indent
vim.cmd('set undofile')

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- vim.g.laststatus = 3

vim.o.updatetime = 250 -- Decrease update time
vim.wo.signcolumn = 'yes'

vim.o.lazyredraw = true
vim.o.incsearch = true
vim.o.modeline = false
vim.o.textwidth = 80
vim.o.gdefault = true
vim.o.scrolloff = 7
vim.o.sidescrolloff = 5
-- vim.o.colorcolumn='81'

vim.g.tex_flavor = 'latex'

vim.o.foldenable = true
vim.o.foldlevelstart = 1
vim.o.foldnestmax = 2
-- vim.o.foldmethod=expr
-- vim.o.foldexpr=nvim_treesitter#foldexpr()
-- au TermOpen * setlocal nonumber norelativenumber
-- packadd cfilter
-- vim.o.keymap=ukrainian-enhanced
vim.o.keymap = 'russian-jcukenwin'
vim.o.iminsert = 0
vim.o.completeopt = 'menu,menuone'
-- vim.o.completeopt = 'menu,menuone,noinsert'
vim.o.diffopt = 'internal,filler,closeoff,vertical'
if vim.env.THEME == 'light' then
	vim.o.background = 'light'
else
	vim.o.background = 'dark'
end
vim.o.background = 'dark'

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
