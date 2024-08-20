return function()
  local helpers = require "plugins.config.lspconfig_helpers"
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  -- local servers = { "pyright" }

  -- lspconfig["taplo"].setup {
  --   on_attach = helpers.on_attach,
  --   -- capabilities = helpers.capabilities,
  -- }

  local root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    "environment.yml",
    "pixi.toml",
  }
  lspconfig["basedpyright"].setup {
    on_attach = helpers.on_attach,
    root_dir = lspconfig.util.root_pattern(unpack(root_files)),
    -- capabilities = helpers.capabilities,
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          analysis = {
            --     diagnosticMode = "workspace",
            -- autoSearchPaths = true,
            -- useLibraryCodeForTypes = true
          },
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { "*" },
        },
      },
    },
  }
  lspconfig["ruff"].setup {
    on_attach = helpers.on_attach,
    root_dir = lspconfig.util.root_pattern(unpack(root_files)),
    -- capabilities = helpers.capabilities,
  }
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end
      if client.name == 'ruff' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
      end
    end,
    desc = 'LSP: Disable hover capability from Ruff',
  })

  lspconfig.grammarly.setup {
    filetypes = { "markdown", "tex" },
    on_attach = helpers.on_attach,
    -- capabilities = helpers.capabilities,
  }

  local servers_with_fmt = { "yamlls", "dockerls", "docker_compose_language_service", "marksman" }

  for _, lsp in ipairs(servers_with_fmt) do
    lspconfig[lsp].setup {
      on_attach = helpers.on_attach,
      -- capabilities = helpers.capabilities,
    }
  end

  -- lspconfig["bashls"].setup {
  --   on_attach = helpers.on_attach,
  --   -- capabilities = helpers.capabilities,
  --   filetypes = { "sh", "zsh", "bash" },
  -- }

  -- lspconfig.ccls.setup {
  --   on_attach = helpers.on_attach,
  --   -- capabilities = helpers.capabilities,
  --   -- init_options = {
  --   --   compilationDatabaseDirectory = "build",
  --   --   index = {
  --   --     threads = 0,
  --   --   },
  --   --   clang = {
  --   --     excludeArgs = { "-frounding-math" },
  --   --   },
  --   -- },
  -- }

  lspconfig["sourcery"].setup {
    server = {
      on_attach = helpers.on_attach,
      -- capabilities = helpers.capabilities,
      -- flags = { debounce_text_changes = 150 },
    },
    init_options = {
      editor_version = "vim",
      extension_version = "vim.lsp",
      -- token = "user_9IMPzM1nhVENfmTL5gZoD0KOh3_zFWPCHqjuHQs019beGcu1yi78i0TYBmM",
      token = "user_gtvoBfIlqIXI6alm5TTLLaiQ46q8ZsY43MSTcu5Z3qu6cMtEJ6acfQ_oevA"
    },
  }

  -- local forward_search_mac = {
  --   executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
  --   args = { "-g", "%l", "%p", "%f" },
  -- }
  -- local forward_search_linux = {
  --   executable = "zathura",
  --   args = { "--synctex-forward", "%l:1:%f", "%p" },
  -- }
  -- local is_mac = vim.loop.os_uname().sysname == "Darwin"
  -- local forwardSearch = is_mac and forward_search_mac or forward_search_linux
  --
  -- lspconfig["texlab"].setup {
  --   -- server = {
  --   on_attach = helpers.on_attach,
  --   -- capabilities = helpers.capabilities,
  --   -- flags = { debounce_text_changes = 150 },
  --   -- },
  --   settings = {
  --     texlab = {
  --       auxDirectory = ".",
  --       rootDirectory = ".",
  --       bibtexFormatter = "texlab",
  --       build = {
  --         -- args = { "-pdf", "-pdflatex=xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
  --         -- executable = "latexmk",
  --         executable = "tectonic",
  --         args = {
  --           "-X",
  --           "compile",
  --           "%f",
  --           "--synctex",
  --           "--keep-logs",
  --           "--keep-intermediates",
  --         },
  --         forwardSearchAfter = true,
  --         onSave = true,
  --       },
  --       diagnosticsDelay = 300,
  --       formatterLineLength = 80,
  --       forwardSearch = forwardSearch,
  --       chktex = { onOpenAndSave = true, onEdit = false },
  --       latexFormatter = "latexindent",
  --       latexindent = {
  --         modifyLineBreaks = true,
  --       },
  --     },
  --   },
  -- }

  lspconfig.lua_ls.setup {
    on_attach = helpers.on_attach,
  }
end
