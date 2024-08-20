return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    -- event = "BufEnter",
    config = require "plugins.config.lspconfig",
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
      vim.diagnostic.config { -- Configure diagnostic settings
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }
      require("lsp_lines").setup()
    end,
  },

  -- RUST
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4", -- Recommended
  --   ft = { "rust" },
  --   init = function()
  --     -- local rt = require "rust-tools"
  --     local helpers = require "plugins.configs.lspconfig_helpers"
  --     vim.g.rustaceanvim = {
  --       server = {
  --         on_attach = helpers.on_attach_with_format,
  --         capabilities = helpers.capabilities,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "Saecki/crates.nvim",
  --   event = "BufEnter Cargo.toml",
  --   config = function()
  --     require("crates").setup()
  --   end,
  -- },

  -- FLUTTER
  -- {
  --   "akinsho/flutter-tools.nvim",
  --   ft = "dart",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     local helpers = require "plugins.configs.lspconfig_helpers"
  --     require("flutter-tools").setup {
  --       lsp = {
  --         on_attach = helpers.on_attach_with_format,
  --         capabilities = helpers.capabilities,
  --       },
  --     }
  --   end,
  -- },

  -- TEX
  -- {
  --   "anufrievroman/vim-angry-reviewer",
  --   ft = "tex",
  -- },
  -- { "znck/grammarly", event = "BufEnter", dependencies = { "neovim/nvim-lspconfig" } },

  -- FORMAT
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = "BufEnter",
  --   config = function()
  --     require("null-ls").setup {
  --       on_attach = function(client, bufnr)
  --         vim.keymap.set("n", "<leader>fm", function()
  --           vim.lsp.buf.format { async = true }
  --         end, { buffer = bufnr })
  --       end,
  --       sources = {
  --         -- require("null-ls").builtins.formatting.black.with {
  --         --   filetypes = { "python", "sage" },
  --         -- },
  --         -- require("null-ls").builtins.formatting.ruff,
  --         -- require("null-ls").builtins.diagnostics.ruff,
  --         require("null-ls").builtins.formatting.stylua,
  --         -- require("null-ls").builtins.formatting.shfmt,
  --         require("null-ls").builtins.formatting.beautysh,
  --       },
  --     }
  --   end,
  -- },

  -- LUA
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  {
    "folke/trouble.nvim",
    opts = {},

    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
