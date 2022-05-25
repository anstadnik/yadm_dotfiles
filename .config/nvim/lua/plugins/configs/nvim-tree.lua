local map = vim.api.nvim_set_keymap
-- Nvim tree
require 'nvim-tree'.setup({
	open_on_setup = true,
	hijack_cursor = true,
	diagnostics = { enable = true },
	renderer = { indent_markers = { enable = true } }
})
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd "quit"
		end
	end
})

map('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', { noremap = true })
--[[ map('n', '<leader>r', ':NvimTreeRefresh<CR>', {noremap = true})
map('n', '<C-S-n>', ':NvimTreeFindFile<CR>', {noremap = true}) ]]
-- NvimTreeOpen and NvimTreeClose are also available if you need them
