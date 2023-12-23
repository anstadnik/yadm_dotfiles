return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim" },
    config = require "plugins.configs.lspconfig",
  },
  {
    "simrat39/symbols-outline.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
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
  "simrat39/rust-tools.nvim",
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
    dependencies = { "nvim-lua/plenary.nvim" },
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
    config = function()
      require("neodev").setup {}
    end,
  },
  { "znck/grammarly", dependencies = { "neovim/nvim-lspconfig" } },
  {
    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("lsp-inlayhints").setup()
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
    end,
  },
}
