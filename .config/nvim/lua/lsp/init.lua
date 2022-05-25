local nvim_lsp = require('lspconfig')
local map = vim.api.nvim_set_keymap

-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- require('lsp-status').on_attach(client)

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  require 'lsp_signature'.on_attach({
    hint_enable = false,
    hi_parameter = "IncSearch"
  });

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gp', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>k',
    '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D',
    '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --[[ buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts) ]]
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>',
    opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap("n", "<leader>q", "<cmd>Trouble workspace_diagnostics<cr>",
    { silent = true, noremap = true })

  --[[ buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                   opts) ]]

  buf_set_keymap('n', 'gr',
    "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
    opts)
  buf_set_keymap('n', '<leader>c',
    '<cmd>lua vim.lsp.buf.code_action()<CR>',
    opts)
  buf_set_keymap('n', '<leader>l',
    "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>",
    opts)
  -- buf_set_keymap('n', '<leader>l',
  -- [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]],
  -- opts)

  if client.config.filetypes ~= nil and client.config.filetypes[1] == "python" then
    -- if client.config.filetypes[1] == "lua" then
    buf_set_keymap("n", "<leader>f", "<cmd>Format<CR>", opts)
  else
    buf_set_keymap("n", "<leader>f",
      "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

end

-- https://github.com/ray-x/lsp_signature.nvim/issues/143
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Use a loop to conveniently call 'setup' on multiple servers and map buffer
-- local keybindings when the language server attaches
require('lsp.servers.sourcery')

-- local lsp_status = require('lsp-status')
-- lsp_status.register_progress()

local servers = { "pyright", "ccls", "vimls", "dockerls", "bashls", "sourcery" }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 }
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
map("n", "<C-g>", ":Vista!!<cr>", { silent = true, noremap = true })

------------- CMP  -- -----------

-- Setup nvim-cmp

local function t(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, true, true), "m", true)
end

require('cmp_nvim_ultisnips').setup {}

local cmp = require('cmp')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local lspkind = require('lspkind')

cmp.setup {
  snippet = { expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end },
  formatting = {
    format = lspkind.cmp_format({ with_text = true,
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })
    })
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close()
    }),
    ["<C-j>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          })
        else
          cmp.mapping.complete()
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
      x = function() t("<Plug>(ultisnips_expand)") end
    }),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        return t("<Plug>(ultisnips_jump_forward)")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        return t("<Plug>(ultisnips_jump_backward)")
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-n>'] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.compose({ "select_next_item" })(fallback)
    end, { "i", "s" }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.compose({ "select_prev_item" })(fallback)
    end, { "i", "s" })
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end,
  sources = cmp.config.sources({
    { name = 'ultisnips' }, { name = 'nvim_lsp' }, { name = 'tmux' },
    { name = 'spell' }, { name = 'path' }, { name = 'cmp_tabnine' }, { name = 'crates' },
    { name = 'dap' }
  })
}

-- Use buffer source for `/`.
require 'cmp'.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({ { name = 'cmdline' } }, { { name = 'path' } })
})

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
  -- cmd = { "/usr/bin/lua-language-server" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path
      },
      diagnostics = {
        globals = { 'vim' },
        neededFileStatus = {
          ["codestyle-check"] = "Any",
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = { enable = false },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        }
      },
    }
  }
}

require 'lspconfig'.sqls.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  settings = {
    sqls = {
      connections = {
        {
          driver = 'mysql',
          dataSourceName = 'unix(/var/run/mysqld/mysqld.sock)/warehousing'
        }
      }
    }
  }
}

nvim_lsp.texlab.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
  settings = {
    texlab = {
      build = {
        -- args = { "-xelatex", "-pdfxe", "-interaction=nonstopmode", "-synctex=1", "%f" },
        -- args = { "-pdfxe", "-interaction=nonstopmode", "-synctex=1", "%f" },
        args = { "-pdf", "-pdflatex=xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" }
      },
      latexindent = { modifyLineBreaks = true }
    }
  }
}

-- require'lspsaga'.init_lsp_saga()
require('rust-tools').setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = { command = "clippy" }
      }
    }
  },
})

require('null-ls')
require('crates').setup {
  null_ls = {
    enabled = true,
  },
}

require('nvim-autopairs').setup({ enable_check_bracket_line = false })
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done',
  cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

require("trouble").setup {}