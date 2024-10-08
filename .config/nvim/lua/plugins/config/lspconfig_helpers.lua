local M = {}

function M.load_mapping(bufnr)
  vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions<CR>", { buffer = bufnr })
  vim.keymap.set("n", "<leader>g", "<cmd> Telescope lsp_document_symbols<CR>", { buffer = bufnr })
  -- vim.keymap.set("n", "<C-g>", "<cmd> Outline<CR>", { buffer = bufnr })
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
  vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, { buffer = bufnr })
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr })
  vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, { buffer = bufnr })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
  -- vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float, { buffer = bufnr })
  -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = bufnr })
  -- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
  -- vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
  -- vim.keymap.set("n", "<leader>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, { buffer = bufnr })

  -- vim.keymap.set("n", "<C-f>", require("copilot.suggestion").accept, { buffer = bufnr })
end

function M.on_attach(client, bufnr)
  M.load_mapping(bufnr)
end

return M
