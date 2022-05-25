
require 'lualine'.setup({
	sections = {
		lualine_c = { { 'filename', file_status = true } },
		lualine_y = { "require'lsp-status'.status()" }
	},
	options = {
		-- theme = 'nord',
		theme = 'onenord',
		section_separators = { left = '', right = '' },
		component_separators = { left = '/', right = '/' },
		extensions = { 'nvim-tree', 'fugitive' },
		globalstatus = true
	}
})
