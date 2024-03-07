return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    -- event = "BufEnter",
    config = require "plugins.configs.lspconfig",
  },
  {
    "hedyhli/outline.nvim",
    event = "BufEnter",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("outline").setup()
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
      require("lsp_lines").setup {}
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    init = function()
      -- local rt = require "rust-tools"
      local helpers = require "plugins.configs.lspconfig_helpers"
      vim.g.rustaceanvim = {
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
  {
    "Saecki/crates.nvim",
    event = "BufEnter Cargo.toml",
    config = function()
      require("crates").setup()
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
  {
    "nvimtools/none-ls.nvim",
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
  { "folke/neodev.nvim" },
  { "znck/grammarly", event = "BufEnter", dependencies = { "neovim/nvim-lspconfig" } },
}
