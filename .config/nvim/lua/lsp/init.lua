local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.keymap.set('n', '<leader>q', '<cmd>Trouble workspace_diagnostics<cr>', opts)

local on_attach = function(client, bufnr)
  vim.keymap.set('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", { buffer = bufnr })
  vim.keymap.set('n', 'gp', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", { buffer = bufnr })
  -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { buffer = bufnr })
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr })

  vim.keymap.set('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", { buffer = bufnr })
  vim.keymap.set('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', { buffer = bufnr })
  vim.keymap.set('v', '<leader>c', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<leader>l', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", { buffer = bufnr })

  if client.supports_method "textDocument/formatting" or client.config.filetypes[1] == "lua" then
    vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = bufnr })
  else
    vim.keymap.set("n", "<leader>f", "<cmd>Format<CR>", { buffer = bufnr })
  end

  require 'lsp_signature'.on_attach({ hint_enable = true });
end

-- -- https://github.com/ray-x/lsp_signature.nvim/issues/143
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or "rounded"
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

-- Use a loop to conveniently call 'setup' on multiple servers and map buffer
-- local keybindings when the language server attaches
require('lsp.servers.sourcery')

local servers = { "pyright", "ccls", "vimls", "dockerls", "bashls", "sourcery" }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 }
  }
end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
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
        checkOnSave = { command = "clippy" }
      }
    }
  },
})
