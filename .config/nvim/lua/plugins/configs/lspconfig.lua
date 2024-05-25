return function()
  require("neodev").setup {}

  local helpers = require "plugins.configs.lspconfig_helpers"
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  -- local servers = { "pyright" }

  lspconfig["taplo"].setup {
    on_attach = helpers.on_attach_with_format,
    capabilities = helpers.capabilities,
  }

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
    capabilities = helpers.capabilities,
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
  -- https://github.com/mtshiba/pylyzer/issues/55
  -- lspconfig["pylyzer"].setup {
  --   on_attach = on_attach,
  --   -- root_dir = lspconfig.util.root_pattern(unpack(root_files)),
  --   capabilities = capabilities,
  -- }
  lspconfig["ruff"].setup {
    on_attach = helpers.on_attach_with_format,
    root_dir = lspconfig.util.root_pattern(unpack(root_files)),
    capabilities = helpers.capabilities,
  }

  -- for _, lsp in ipairs(servers) do
  --   lspconfig[lsp].setup {
  --     on_attach = on_attach,
  --     capabilities = capabilities,
  --   }
  -- end

  lspconfig.grammarly.setup {
    filetypes = { "markdown", "tex" },
    on_attach = helpers.on_attach,
    capabilities = helpers.capabilities,
  }

  local servers_with_fmt = { "yamlls", "dockerls", "docker_compose_language_service", "marksman" }

  for _, lsp in ipairs(servers_with_fmt) do
    lspconfig[lsp].setup {
      on_attach = helpers.on_attach_with_format,
      capabilities = helpers.capabilities,
    }
  end

  lspconfig["bashls"].setup {
    on_attach = helpers.on_attach,
    capabilities = helpers.capabilities,
    filetypes = { "sh", "zsh", "bash" },
  }

  lspconfig.ccls.setup {
    on_attach = helpers.on_attach_with_format,
    capabilities = helpers.capabilities,
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

  lspconfig["sourcery"].setup {
    server = {
      on_attach = helpers.on_attach,
      capabilities = helpers.capabilities,
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
    on_attach = helpers.on_attach_with_format,
    capabilities = helpers.capabilities,
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
    on_attach = helpers.on_attach,
    capabilities = helpers.capabilities,

    -- settings = {
    --   Lua = {
    --     diagnostics = {
    --       globals = {
    --         "vim",
    --         "s",
    --         "t",
    --         "i",
    --         "c",
    --         "conds",
    --         "dl",
    --         "l",
    --         "f",
    --         "sn",
    --         "d",
    --         "p",
    --         "rep",
    --         "events",
    --       },
    --     },
    --     -- workspace = {
    --     --   library = {
    --     --     [vim.fn.expand "$VIMRUNTIME/lua"] = true,
    --     --     [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
    --     --   },
    --     --   maxPreload = 100000,
    --     --   preloadFileSize = 10000,
    --     -- },
    --   },
    -- },
  }
end
