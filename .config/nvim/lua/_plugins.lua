local map = vim.api.nvim_set_keymap

-- Colorscheme
vim.g.nord_borders = true
require('nord').set()

-- Map blankline
require("indent_blankline").setup { show_current_context = true, show_current_context_start = true }

require("zen-mode").setup {
	window = {
		backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
		-- height and width can be:
		-- * an absolute number of cells when > 1
		-- * a percentage of the width / height of the editor when <= 1
		-- * a function that returns the width or the height
		width = 0.6, -- width of the Zen window
		height = 0.4, -- height of the Zen window
		-- by default, no options are changed for the Zen window
		-- uncomment any of the options below, or add other vim.wo options you want to apply
		options = {
			-- signcolumn = "no", -- disable signcolumn
			number = false, -- disable number column
			relativenumber = false -- disable relative numbers
			-- cursorline = false, -- disable cursorline
			-- cursorcolumn = false, -- disable cursor column
			-- foldcolumn = "0", -- disable fold column
			-- list = false, -- disable whitespace characters
		}
	},
	plugins = {
		-- disable some global vim options (vim.o...)
		-- comment the lines to not apply the options
		options = {
			enabled = true,
			ruler = false, -- disables the ruler text in the cmd line area
			showcmd = false -- disables the command in the last line of the screen
		},
		twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
		gitsigns = { enabled = true }, -- disables git signs
		tmux = { enabled = false }, -- disables the tmux statusline
		kitty = {
			enabled = true,
			font = "+5" -- font size increment
		}
	}
}

-- Gitsigns
require('gitsigns').setup {
	numhl = true,
	linehl = false,
	keymaps = {
		-- Default keymap options
		noremap = true,

		['n ]c'] = {
			expr = true,
			"&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"
		},
		['n [c'] = {
			expr = true,
			"&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"
		},

		['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

		-- Text objects
		['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
	},
	word_diff = false
}

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

require 'lualine'.setup({
	sections = {
		lualine_c = { { 'filename', file_status = true } },
		lualine_y = { "require'lsp-status'.status()" }
	},
	options = {
		theme = 'nord',
		-- theme = 'dracula',
		section_separators = { left = '', right = '' },
		component_separators = { left = '/', right = '/' },
		extensions = { 'nvim-tree', 'fugitive' },
		globalstatus = true
	}
})

-- Tmux navigator
require('Navigator').setup({ disable_on_zoom = true })

local opts = { noremap = true, silent = true }
map('n', "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
map('n', "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
map('n', "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
map('n', "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
-- map('n', "<C-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)

-- Slime

vim.g.slime_no_mappings = 1
vim.g.slime_target = "tmux"
vim.g.slime_paste_file = "/tmp/.slime_paste"
vim.g.slime_python_ipython = 1

-- Sandwich
map('n', 's', '<Nop>', {})
map('x', 's', '<Nop>', {})

-- Aligning
map('x', 'ga', '<plug>(EasyAlign)', {})
map('n', 'ga', '<plug>(EasyAlign)', {})

-- Formatting (python)
require('formatter').setup({
	filetype = {
		python = {
			-- autopep8
			function()
				return {
					exe = "black",
					args = { "-" },
					stdin = true,
					cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
				}
			end, function()
				return {
					exe = "isort",
					args = { "-" },
					stdin = true,
					cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
				}
			end
		}
	}
})

-- Doge
vim.g.doge_mapping_comment_jump_forward = '<C-l>'
vim.g.doge_mapping_comment_jump_backward = '<C-h>'

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

-- Vim tmuxline
vim.g.tmuxline_preset = {
	a = '#S',
	b = '#W',
	c = '',
	win = '#I #W',
	cwin = '#I #W #F',
	x = '%a',
	y = '%R',
	z = '#H #{prefix_highlight}'
}
vim.g.tmuxline_separators = {
	left = "",
	left_alt = "/",
	right = "",
	right_alt = "/",
	space = ' '
}

-- require('luatab').setup({})

require("tabby").setup({ tabline = require("tabby.presets").tab_only })

require('hlslens').setup({
	auto_enable = true,
	enable_incsearch = true,
	calm_down = false,
	nearest_only = false,
	nearest_float_when = 'auto',
	float_shadow_blend = 50,
	virt_priority = 100
})

vim.cmd([[com! HlSearchLensToggle lua require('hlslens').toggle()]])

map('n', 'n',
	[[<Cmd>execute('norm! ' . v:count1 . 'nzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
	{ noremap = true })
map('n', 'N',
	[[<Cmd>execute('norm! ' . v:count1 . 'Nzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
	{ noremap = true })
map('', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true })
map('', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true })
map('', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true })
map('', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true })

require "fidget".setup {}

require 'Comment'.setup()

require 'competitest'.setup()
