-- Startify
-- function! StartifyEntryFormat()
-- 	return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
-- endfunction
function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require 'nvim-web-devicons'.get_icon(filename, extension,
    { default = true })
end

-- function! StartifyEntryFormat() abort
--   return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
-- endfunction
vim.g.startify_session_autoload = 0
vim.g.startify_session_persistence = 1
vim.g.startify_change_to_dir = 0
-- vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_sort = 1
vim.g.startify_lists = {
  { type = 'dir', header = { '	MRU ' .. vim.fn.getcwd() } },
  { type = 'sessions', header = { '	Sessions' } },
  { type = 'bookmarks', header = { '	Bookmarks' } },
  { type = 'commands', header = { '	Commands' } }
}
-- vim.g.ascii = { '				   _				 _			 _	 _	  ',
-- '   __ _	 ___  | |_	  __ _	  __| |  _ __	(_) | | __',
-- '  / _` | / __| | __|  / _` |  / _` | | \'_ \\  | | | |/ /',
-- ' | (_| | \\__ \\ | |_	| (_| | | (_| | | | | | | | |	< ',
-- '  \\__,_| |___/  \\__|  \\__,_|  \\__,_| |_| |_| |_| |_|\\_\\',
-- '														  ',}
-- vim.g.startify_custom_header = 'map(g:ascii + startify#fortune#boxed(), "\"	 \".v:val")'
vim.g.startify_custom_header = vim.fn['startify#pad'](vim.fn.split(vim.fn
  .system(
    "figlet -w 100 Astadnik"),
  '\n'))

vim.g.startify_enable_special = 0
vim.g.startify_update_oldfiles = 1
vim.g.startify_session_autoload = 1
vim.g.startify_session_dir = '~/.config/nvim/sessions'
vim.g.startify_session_before_save = {
  'echo "Cleaning up before saving.."', 'silent! bw! term-slider',
  'silent! bw! term-pane'
}
