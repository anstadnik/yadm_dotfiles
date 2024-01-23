local M = {}

function M.load_mapping(bufnr)
  vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions<CR>", { buffer = bufnr })
  vim.keymap.set("n", "<leader>g", "<cmd> Telescope lsp_document_symbols<CR>", { buffer = bufnr })
  vim.keymap.set("n", "<C-g>", "<cmd> SymbolsOutline<CR>", { buffer = bufnr })
  vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references<CR>", { buffer = bufnr })
  vim.keymap.set("n", "<leader>l", "<cmd> Telescope lsp_dynamic_workspace_symbols<CR>", { buffer = bufnr })
  vim.keymap.set("n", "<leader>e", "<cmd> Telescope diagnostics<CR>", { buffer = bufnr })
  vim.keymap.set("n", "gD", "<cmd> Telescope lsp_type_definitions<CR>", { buffer = bufnr })
  vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format { async = true }
  end, { buffer = bufnr })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
  vim.keymap.set("n", "<C-f>", function()
    if not require("noice.lsp").scroll(4) then
      return "<c-f>"
    end
  end, { silent = true, expr = true })

  vim.keymap.set("n", "<c-b>", function()
    if not require("noice.lsp").scroll(-4) then
      return "<c-b>"
    end
  end, { silent = true, expr = true })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr })
  vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
  vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float, { buffer = bufnr })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = bufnr })
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr })

  -- vim.keymap.set("n", "<C-f>", require("copilot.suggestion").accept, { buffer = bufnr })
end

function M.on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  vim.lsp.inlay_hint.enable(bufnr, true)
  M.load_mapping(bufnr)

  -- if client.server_capabilities.documentSymbolProvider then
  --   require("nvim-navic").attach(client, bufnr)
  -- end
end

function M.on_attach_with_format(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
  vim.lsp.inlay_hint.enable(bufnr, true)
  M.load_mapping(bufnr)

  -- if client.server_capabilities.documentSymbolProvider then
  --   require("nvim-navic").attach(client, bufnr)
  -- end
end

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local capabilities = require("plugins.configs.lspconfig").capabilities

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

return M
