-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

local opt = vim.opt -- Shortcut for setting options

opt.completeopt = "menu,menuone,noselect" -- Set completeopt to have a better completion experience
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line

vim.g.tex_flavor = "latex" -- Set default TeX flavor to LaTeX
opt.conceallevel = 3 -- Hide * markup for bold and italic

opt.mouse = "" -- Disable mouse support
opt.scrolloff = 5 -- Start scrolling when we're 5 lines away from margins
opt.gdefault = true -- Use global search and replace by default

opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] -- Set characters for fold and end of buffer

vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldcolumn = "1" -- Set fold column to 1
vim.o.foldlevelstart = 99 -- Set the start level for folding
vim.o.foldenable = true -- Enable folding

opt.clipboard = "unnamedplus" -- Use system clipboard
vim.g.mapleader = " " -- Set space as the leader key
vim.g.maplocalleader = " " -- Set space as the local leader key

vim.diagnostic.config { -- Configure diagnostic settings
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

opt.tabpagemax = 200 -- Maximum number of tab pages that can be opened

opt.termguicolors = true -- Enable terminal GUI colors
opt.textwidth = 80 -- Set width of text

opt.expandtab = true -- Convert tabs to spaces
opt.tabstop = 2 -- Number of spaces in a tab
opt.softtabstop = 2 -- Number of spaces in a soft tab
opt.shiftwidth = 2 -- Number of spaces to use for autoindent

opt.incsearch = true -- Incremental search
opt.ignorecase = true -- Ignore case in search patterns
opt.undofile = true -- Enable persistent undo
opt.diffopt:append { "vertical" } -- Append 'vertical' to diffopt

opt.inccommand = "nosplit" -- preview incremental substitute

opt.formatoptions = "jcroqnt" -- Set format options
opt.grepformat = "%f:%l:%c:%m" -- Set the format for grep output
opt.grepprg = "rg --vimgrep" -- Use ripgrep for grep

opt.laststatus = 3 -- Always display the status line

opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.shiftround = true -- Round indent
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically

opt.list = true -- Show some invisible characters (tabs...
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" } -- Set session options
opt.shortmess:append { W = true, I = true, c = true } -- Append to shortmess
opt.spelllang = { "en" } -- Set spellcheck language to English
opt.timeoutlen = 300 -- Length of time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- Enable undofile
opt.undolevels = 10000 -- Maximum number of undo levels
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

opt.list = false -- Disable showing invisible characters

if vim.fn.has "nvim-0.9.0" == 1 then -- Check if Neovim version is 0.9.0 or higher
  opt.splitkeep = "screen" -- Keep splits on the screen
  opt.shortmess:append { C = true } -- Append to shortmess for version check
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0 -- Disable recommended indentation style for markdown
