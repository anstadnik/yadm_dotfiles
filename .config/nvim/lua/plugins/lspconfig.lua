return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    -- event = "BufEnter",
    config = require "plugins.configs.lspconfig",
  },
  {
    "simrat39/symbols-outline.nvim",
    event = "BufEnter",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup { automatic_installation = true }
    end,
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    ft = { "rust", "python" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("lsp_lines").setup {
        virtual_text = false,
      }
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    init = function()
      -- local rt = require "rust-tools"
      local helpers = require "plugins.configs.lspconfig_helpers"
      vim.g.rustaceanvim = {
        -- tools = { inlay_hints = { auto = false } },
        server = {
          on_attach = helpers.on_attach_with_format,
          capabilities = helpers.capabilities,
        },
        -- dap = {
        --   adapter = {
        --     type = "executable",
        --     command = (
        --       vim.fn.executable "lldb-vscode" == 1 and "lldb-vscode"
        --       -- or "/opt/homebrew/Cellar/llvm/*/bin/lldb-vscode"
        --       -- use lua to expand it
        --       or vim.fn.expand "~/opt/llvm/*/bin/lldb-vscode"
        --     ),
        --     name = "rt_lldb",
        --   },
        -- },
      }
    end,
  },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   ft = { "rust" },
  --   config = function()
  --     local rt = require "rust-tools"
  --     local helpers = require "plugins.configs.lspconfig_helpers"
  --     rt.setup {
  --       tools = {
  --         inlay_hints = {
  --           auto = false,
  --         },
  --       },
  --       server = {
  --         on_attach = function(client, bufnr)
  --           helpers.on_attach_with_format(client, bufnr)
  --           vim.keymap.set("n", "K", function()
  --             require("rust-tools").hover_actions.hover_actions()
  --           end, { buffer = bufnr })
  --           -- vim.keymap.set("x", "K", function()
  --           --   require("rust-tools").hover_range.hover_range()
  --           -- end)
  --         end,
  --         capabilities = helpers.capabilities,
  --         standalone = true,
  --         -- flags = { debounce_text_changes = 150 },
  --         settings = {
  --           ["rust-analyzer"] = {
  --             checkOnSave = { command = "clippy" },
  --             cargo = { allFeatures = true },
  --           },
  --         },
  --       },
  --       dap = {
  --         adapter = {
  --           type = "executable",
  --           command = (
  --             vim.fn.executable "lldb-vscode" == 1 and "lldb-vscode"
  --             -- or "/opt/homebrew/Cellar/llvm/*/bin/lldb-vscode"
  --             -- use lua to expand it
  --             or vim.fn.expand "~/opt/llvm/*/bin/lldb-vscode"
  --           ),
  --           name = "rt_lldb",
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "Saecki/crates.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    event = "BufEnter Cargo.toml",
    config = function()
      require "null-ls"
      require("crates").setup { null_ls = { enabled = true } }
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup {}
    end,
  },
  {
    "anufrievroman/vim-angry-reviewer",
    ft = "tex",
  },
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local helpers = require "plugins.configs.lspconfig_helpers"
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
          on_attach = helpers.on_attach_with_format,
          capabilities = helpers.capabilities,
        },
      }
    end,
  },
  -- {
  --   "SmiteshP/nvim-navic",
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   config = function()
  --     require("nvim-navic").setup {
  --       highlight = true,
  --     }
  --   end,
  -- },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufEnter",
    config = function()
      require("null-ls").setup {
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<leader>fm", function()
            vim.lsp.buf.format { async = true }
          end, { buffer = bufnr })
        end,
        sources = {
          -- require("null-ls").builtins.formatting.black.with {
          --   filetypes = { "python", "sage" },
          -- },
          -- require("null-ls").builtins.formatting.ruff,
          -- require("null-ls").builtins.diagnostics.ruff,
          require("null-ls").builtins.formatting.stylua,
          -- require("null-ls").builtins.formatting.shfmt,
          require("null-ls").builtins.formatting.beautysh,
        },
      }
    end,
  },
  {
    "folke/neodev.nvim",
    event = "BufEnter",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "lua" },
    config = function()
      require("neodev").setup {}
    end,
  },
  { "znck/grammarly", event = "BufEnter", dependencies = { "neovim/nvim-lspconfig" } },
  -- {
  --   "lvimuser/lsp-inlayhints.nvim",
  --   branch = "anticonceal",
  --   event = "BufEnter",
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   config = function()
  --     require("lsp-inlayhints").setup()
  --     vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
  --     vim.api.nvim_create_autocmd("LspAttach", {
  --       group = "LspAttach_inlayhints",
  --       callback = function(args)
  --         if not (args.data and args.data.client_id) then
  --           return
  --         end
  --
  --         local bufnr = args.buf
  --         local client = vim.lsp.get_client_by_id(args.data.client_id)
  --         require("lsp-inlayhints").on_attach(client, bufnr)
  --       end,
  --     })
  --   end,
  -- },
}
