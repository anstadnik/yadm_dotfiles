local map = vim.api.nvim_set_keymap

-- Colorscheme
-- vim.g.onedark_disable_toggle_style = true -- By default it is false
-- vim.g.onedark_transparent_background = true -- By default it is false
require('onedark').setup()

-- Map blankline
vim.g.indent_blankline_char = ''
vim.g.indent_blankline_filetype_exclude = {'help', 'packer'}
vim.g.indent_blankline_buftype_exclude = {'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add = {hl = 'GitGutterAdd', text = '+'},
        change = {hl = 'GitGutterChange', text = '~'},
        delete = {hl = 'GitGutterDelete', text = '_'},
        topdelete = {hl = 'GitGutterDelete', text = '‾'},
        changedelete = {hl = 'GitGutterChange', text = '~'}
    },
    numhl = false,
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
    word_diff = true
}

-- Telescope
require('telescope').setup {
    defaults = {
        mappings = {i = {["<esc>"] = require('telescope.actions').close}}
    }
}
require('telescope').load_extension('dap')
-- Add leader shortcuts
-- map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sf',
    [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>sb',
    [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>sh',
    [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>sd',
    [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>sp',
    [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>sc',
    [[<cmd>lua require('telescope.builtin').command_history()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>sl',
    [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]],
    {noremap = true, silent = true})
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
    {noremap = true, silent = true})

-- Nvim tree
require'nvim-tree'.setup({
    auto_close = 1, -- 0 by default, closes the tree when it's the last window
    quit_on_open = 1, -- 0 by default, closes the tree when you open a file
    follow = 1, -- 0 by default, this option allows the cursor to be updated when entering a buffer
    git_hl = 1, -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
    highlight_opened_files = 1, -- 0 by default, will enable folder and file icon highlight for opened files/directories.
    group_empty = 1, -- 0 by default, compact folders that only contain a single folder into one node in the file tree
    diagnostics = {enable = true},
    hijack_cursor = 0 -- 1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
})
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
--[[ map('n', '<leader>r', ':NvimTreeRefresh<CR>', {noremap = true})
map('n', '<C-S-n>', ':NvimTreeFindFile<CR>', {noremap = true}) ]]
-- NvimTreeOpen and NvimTreeClose are also available if you need them

require'lualine'.setup({
    sections = {
        lualine_c = {
            {'filename', file_status = true},
            {"diagnostics", sources = {"nvim_lsp"}}
        }
    },
    options = {
        theme = require 'lualine.themes.onedark',
        -- theme = 'dracula',
        section_separators = {left = '', right = ''},
        component_separators = {left = '/', right = '/'},
        extensions = {'nvim-tree'}
    }
})

-- Tmux navigator
require('Navigator').setup({disable_on_zoom = true})

local opts = {noremap = true, silent = true}
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
                    args = {"-"},
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end, function()
                return {
                    exe = "isort",
                    args = {"-"},
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end
        },
        lua = {
            -- autopep8
            function()
                return {
                    exe = "lua-format",
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
    return require'nvim-web-devicons'.get_icon(filename, extension,
                                               {default = true})
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
    {type = 'dir', header = {'	MRU ' .. vim.fn.getcwd()}},
    {type = 'sessions', header = {'	Sessions'}},
    {type = 'bookmarks', header = {'	Bookmarks'}},
    {type = 'commands', header = {'	Commands'}}
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

vim.o.tabline = '%!v:lua.require\'luatab\'.tabline()'

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
    {noremap = true})
map('n', 'N',
    [[<Cmd>execute('norm! ' . v:count1 . 'Nzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
    {noremap = true})
map('', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], {noremap = true})
map('', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], {noremap = true})
map('', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], {noremap = true})
map('', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], {noremap = true})
