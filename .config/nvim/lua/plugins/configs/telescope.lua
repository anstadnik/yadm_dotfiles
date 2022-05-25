local map = vim.api.nvim_set_keymap

-- Telescope
require('telescope').setup {
	extensions = { ["ui-select"] = { require("telescope.themes").get_cursor {} } },
	defaults = {
		mappings = { i = { ["<esc>"] = require('telescope.actions').close } }
	}
}
require("telescope").load_extension("ui-select")
-- require('telescope').load_extension('dap')
-- Add leader shortcuts
-- map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
local opts = { noremap = true, silent = true }
map('n', '<leader>n',
	"<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
map('n', '<leader>sh',
	"<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)
map('n', '<leader>/', "<cmd>lua require('telescope.builtin').live_grep()<CR>",
	opts)
map('n', '<leader>sc',
	"<cmd>lua require('telescope.builtin').command_history()<CR>", opts)
map('n', '<leader>?', "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
	opts)
map('n', '<leader>z', "<cmd>lua require('telescope.builtin').spell_suggest()<CR>",
	opts)
