local options = {
  termguicolors = true,
  showmode = false,
  shiftround = true,
  cursorline = true,
  -- vim.o.breakindent = true
  -- completeopt = 'menu,menuone,noselect',
  completeopt = 'menu,menuone',
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  shiftwidth = 2,
  inccommand = 'split',
  hlsearch = true,
  number = true,
  relativenumber = true,
  hidden = true,
  undofile = true,
  ignorecase = true,
  smartcase = true,
  laststatus = 3,
  updatetime = 250,
  lazyredraw = true,
  incsearch = true,
  modeline = false,
  textwidth = 80,
  gdefault = true,
  scrolloff = 5,
  sidescrolloff = 5,
  foldenable = true,
  foldlevelstart = 99,
  foldnestmax = 2,
  keymap = 'ukrainian-enhanced',
  -- keymap = 'russian-jcukenwin',
  diffopt = 'internal,filler,closeoff,vertical',
  signcolumn = 'yes',
  foldmethod = 'expr',
  foldexpr = 'nfoldexpr()',
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.o.iminsert = 0
vim.g.tex_flavor = 'latex'

local function readAll(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

if trim(readAll(os.getenv("HOME") .. '/.config/theme.txt')) == 'light' then
  vim.o.background = 'light'
else
  vim.o.background = 'dark'
end
