local nvim_lsp = require('lspconfig')
local map = vim.api.nvim_set_keymap

-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- require"lsp_signature".on_attach() -- Note: add in lsp client on-attach
    require'lsp_signature'.on_attach({bind = false, use_lspsaga = true})
    -- local function buf_set_option(...)
    --     vim.api.nvim_buf_set_option(bufnr, ...)
    -- end

    -- Enable completion triggered by <c-x><c-o> buf_set_option('omnifunc',
    -- 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'gp',
        '<cmd>lua require"lspsaga.provider".preview_definition()<cr>', opts)
    map('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
    map('n', '<leader>k',
        '<cmd>lua require("lspsaga.signaturehelp").signature_help()<cr>', opts)
    map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map('n', '<leader>rn', '<cmd>Lspsaga rename<cr>', opts)
    map('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', opts)
    map('v', '<leader>ca', ':<c-u>Lspsaga range_code_action<cr>', opts)
    map('n', 'gr', '<cmd>lua require"lspsaga.provider".lsp_finder()<cr>', opts)
    map('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<cr>', opts)
    map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
    map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)

    if client["config"]["name"] == "pyright" or client["config"]["name"] ==
        "sumneko_lua" then
        map("n", "<leader>f", "<cmd>Format<CR>", opts)
    else
        map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

end

--[[ local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true ]]
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and map buffer
-- local keybindings when the language server attaches
local servers = {"pyright", "rust_analyzer", "ccls"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
        capabilities = capabilities
    }
end

-- Ultisnips

vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
vim.g.UltiSnipsRemoveSelectModeMappings = 0
vim.g.ultisnips_python_style = 'google'
vim.g.snips_author = 'astadnik'

-- Vista vim
vim.g.vista_default_executive = 'nvim_lsp'
map("n", "<C-g>", ":Vista!!<cr>", {silent = true, noremap = true})

------------- CMP  -- -----------

-- Setup nvim-cmp

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
    snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
    formatting = {
        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    },
    mapping = {
        --[[ ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}), ]]
        ['<C-d>'] = cmp.mapping(
            require('lspsaga.action').smart_scroll_with_saga(4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(
            require('lspsaga.action').smart_scroll_with_saga(-4), {'i', 'c'}),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.close(),
            c = cmp.mapping.close()
        }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ["<C-j>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    })
                else
                    cmp.complete()
                    -- fallback()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    })
                else
                    fallback()
                end
            end,
            x = function()
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_expand)"), 'm', true)
            end
        }),
        ["<C-l>"] = cmp.mapping({
            i = function(fallback)
                if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"),
                                          'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"),
                                          'm', true)
                else
                    fallback()
                end
            end
        }),
        ["<C-h>"] = cmp.mapping({
            i = function(fallback)
                if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    return vim.api.nvim_feedkeys(t(
                                                     "<Plug>(ultisnips_jump_backward)"),
                                                 'm', true)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    return vim.api.nvim_feedkeys(t(
                                                     "<Plug>(ultisnips_jump_backward)"),
                                                 'm', true)
                else
                    fallback()
                end
            end
        }),
        --[[ ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        }), {'i'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
        }), {'i'}), ]]
        ['<C-n>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
                else
                    fallback()
                end
            end
        }),
        ['<C-p>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
                else
                    vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
                else
                    fallback()
                end
            end
        })
        --[[ ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false
            }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false
                    })
                else
                    fallback()
                end
            end
        }) ]]
        -- ... Your other configuration ...
    },
    sources = cmp.config.sources({
        {name = 'ultisnips'}, {name = 'nvim_lsp'}, {name = 'tmux'},
        {name = 'spell'}, {name = 'path'},
		{name = 'cmp_tabnine'}
    }, {
			-- {name = 'buffer'},
			{name = 'tmux'}})
}

-- Use buffer source for `/`.
-- cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'cmdline'}}, {{name = 'path'}})
})

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
    cmd = {"/usr/bin/lua-language-server"},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique
            -- identifier
            telemetry = {enable = false}
        }
    }
}

nvim_lsp.texlab.setup {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    capabilities = capabilities,
    settings = {
        texlab = {
            build = {
                forwardSearchAfter = true,
                onSave = true,
                args = {
                    "-pdf", "-xelatex", "-interaction=nonstopmode",
                    "-synctex=1", "%f"
                }
            },
            -- chktex = {onEdit = true, onOpenAndSave = false},
            forwardSearch = {
                executable = "zathura",
                args = {"--synctex-forward", "%l:1:%f", "%p"}
            },
            latexindent = {modifyLineBreaks = false}
        }
    }
}

require('_sourcery')
require('lspconfig').sourcery.setup {}

require'lspconfig'.vimls.setup {}

require'lspsaga'.init_lsp_saga()
require("trouble").setup {}
map("n", "<leader>q", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
    {silent = true, noremap = true})

require('nvim-autopairs').setup({enable_check_bracket_line = false})
