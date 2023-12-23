-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line

vim.g.tex_flavor = "latex"
opt.conceallevel = 3 -- Hide * markup for bold and italic

opt.mouse = ""
opt.scrolloff = 5
opt.gdefault = true

opt.number = true
opt.relativenumber = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.o.foldenable = true

opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

opt.tabpagemax = 200

opt.termguicolors = true
opt.textwidth = 80

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.incsearch = true
opt.ignorecase = true
opt.undofile = true
opt.diffopt:append { "vertical" }

opt.inccommand = "nosplit" -- preview incremental substitute

opt.formatoptions = "jcroqnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

opt.laststatus = 3

opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.shiftround = true -- Round indent
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically

opt.list = true -- Show some invisible characters (tabs...
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shortmess:append { W = true, I = true, c = true }
opt.spelllang = { "en" }
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

opt.list = false

if vim.fn.has "nvim-0.9.0" == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append { C = true }
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
