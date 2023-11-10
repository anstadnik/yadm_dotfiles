return function()
  local load_mapping = function(bufnr)
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

    vim.keymap.set("n", "<C-f>", require("copilot.suggestion").accept, { buffer = bufnr })
  end

  local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    load_mapping(bufnr)

    -- if client.server_capabilities.documentSymbolProvider then
    --   require("nvim-navic").attach(client, bufnr)
    -- end
  end

  local on_attach_with_format = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
    load_mapping(bufnr)

    -- if client.server_capabilities.documentSymbolProvider then
    --   require("nvim-navic").attach(client, bufnr)
    -- end
  end

  -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- local capabilities = require("plugins.configs.lspconfig").capabilities

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local lspconfig = require "lspconfig"

  -- lspservers with default config
  -- local servers = { "pyright" }

  lspconfig["taplo"].setup {
    on_attach = on_attach_with_format,
    capabilities = capabilities,
  }

  local root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    "environment.yml",
  }
  lspconfig["pyright"].setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern(unpack(root_files)),
    capabilities = capabilities,
  }
  -- https://github.com/mtshiba/pylyzer/issues/55
  -- lspconfig["pylyzer"].setup {
  --   on_attach = on_attach,
  --   -- root_dir = lspconfig.util.root_pattern(unpack(root_files)),
  --   capabilities = capabilities,
  -- }
  lspconfig["ruff_lsp"].setup {
    on_attach = on_attach_with_format,
    root_dir = lspconfig.util.root_pattern(unpack(root_files)),
    capabilities = capabilities,
  }

  -- for _, lsp in ipairs(servers) do
  --   lspconfig[lsp].setup {
  --     on_attach = on_attach,
  --     capabilities = capabilities,
  --   }
  -- end

  lspconfig.grammarly.setup {
    filetypes = { "markdown", "tex" },
    on_attach = on_attach,
    capabilities = capabilities,
  }

  local servers_with_fmt = { "julials", "yamlls", "dockerls" }

  for _, lsp in ipairs(servers_with_fmt) do
    lspconfig[lsp].setup {
      on_attach = on_attach_with_format,
      capabilities = capabilities,
    }
  end

  lspconfig["bashls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "sh", "zsh", "bash" },
  }

  local rt = require "rust-tools"
  rt.setup {
    tools = {
      inlay_hints = {
        auto = false,
      },
    },
    server = {
      on_attach = function(client, bufnr)
        on_attach_with_format(client, bufnr)
        vim.keymap.set("n", "K", function()
          require("rust-tools").hover_actions.hover_actions()
        end, { buffer = bufnr })
        -- vim.keymap.set("x", "K", function()
        --   require("rust-tools").hover_range.hover_range()
        -- end)
      end,
      capabilities = capabilities,
      standalone = true,
      -- flags = { debounce_text_changes = 150 },
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
          cargo = { allFeatures = true },
        },
      },
    },
    dap = {
      adapter = {
        type = "executable",
        command = (
          vim.fn.executable "lldb-vscode" == 1 and "lldb-vscode"
          -- or "/opt/homebrew/Cellar/llvm/*/bin/lldb-vscode"
          -- use lua to expand it
          or vim.fn.expand "~/opt/llvm/*/bin/lldb-vscode"
        ),
        name = "rt_lldb",
      },
    },
  }

  lspconfig.ccls.setup {
    on_attach = on_attach_with_format,
    capabilities = capabilities,
    -- init_options = {
    --   compilationDatabaseDirectory = "build",
    --   index = {
    --     threads = 0,
    --   },
    --   clang = {
    --     excludeArgs = { "-frounding-math" },
    --   },
    -- },
  }

  require("flutter-tools").setup {
    -- experimental = { lsp_derive = true },
    -- debugger = { enabled = true },
    -- widget_guides = { enabled = true },
    -- closing_tags = { highlight = "ErrorMsg", prefix = ">", enabled = true },
    -- dev_log = { open_cmd = "tabedit" },
    -- outline = {
    --   open_cmd = "30vnew",
    -- },
    lsp = {
      on_attach = on_attach_with_format,
      capabilities = capabilities,
    },
  }

  lspconfig["sourcery"].setup {
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
      -- flags = { debounce_text_changes = 150 },
    },
    init_options = {
      editor_version = "vim",
      extension_version = "vim.lsp",
      token = "user_9IMPzM1nhVENfmTL5gZoD0KOh3_zFWPCHqjuHQs019beGcu1yi78i0TYBmM",
    },
  }

  local forward_search_mac = {
    executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
    args = { "-g", "%l", "%p", "%f" },
  }
  local forward_search_linux = {
    executable = "zathura",
    args = { "--synctex-forward", "%l:1:%f", "%p" },
  }
  local is_mac = vim.loop.os_uname().sysname == "Darwin"
  local forwardSearch = is_mac and forward_search_mac or forward_search_linux

  lspconfig["texlab"].setup {
    -- server = {
    on_attach = on_attach_with_format,
    capabilities = capabilities,
    -- flags = { debounce_text_changes = 150 },
    -- },
    settings = {
      texlab = {
        auxDirectory = ".",
        rootDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          -- args = { "-pdf", "-pdflatex=xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
          -- executable = "latexmk",
          executable = "tectonic",
          args = {
            "-X",
            "compile",
            "%f",
            "--synctex",
            "--keep-logs",
            "--keep-intermediates",
          },
          forwardSearchAfter = true,
          onSave = true,
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = forwardSearch,
        chktex = { onOpenAndSave = true, onEdit = false },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = true,
        },
      },
    },
  }
  lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim",
            "s",
            "t",
            "i",
            "c",
            "conds",
            "dl",
            "l",
            "f",
            "sn",
            "d",
            "p",
            "rep",
            "events",
          },
        },
        -- workspace = {
        --   library = {
        --     [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        --     [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        --   },
        --   maxPreload = 100000,
        --   preloadFileSize = 10000,
        -- },
      },
    },
  }
end
