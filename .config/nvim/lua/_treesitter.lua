require 'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true -- false will disable the whole extension
		-- additional_vim_regex_highlighting = {'latex'}

	},
	refactor = {
		highlight_definitions = {
			enable = true,
		},
		-- highlight_current_scope = { enable = true },
	},
	incremental_selection = {
		enable = true,
		keymaps = { -- mappings for incremental selection (visual mappings)
			init_selection = "<C-s>", -- maps in normal mode to init the node/scope selection
			node_incremental = "<C-s>" -- increment to the upper named parent
			-- scope_incremental = "grc",		-- increment to the upper scope (as defined in locals.scm)
			-- node_decremental = "grm",		-- decrement to the previous node
		}
	},
	indent = { enable = true },
	textobjects = { -- syntax-aware textobjects
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["ae"] = "@block.outer",
				["ie"] = "@block.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["is"] = "@statement.inner",
				["as"] = "@statement.outer",
				["ad"] = "@comment.outer",
				["am"] = "@call.outer",
				["im"] = "@call.inner"
			}
		},
		move = {
			enable = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer"
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer"
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer"
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer"
			}
		},
		lsp_interop = {
			enable = true,
			peek_definition_code = {
				["<C-p>"] = "@function.outer"
				-- ["<leader>dF"] = "@class.outer"
			}
		}
	},
	rainbow = {
		enable = true,
		extended_mode = true -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
	},
	pairs = { enable = true },
	ensure_installed = "all" -- one of "all", "language", or a list of languages
}

-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
