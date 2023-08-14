return {
  "machakann/vim-sandwich",
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set({ "n", "v" }, "ga", "<Plug>(EasyAlign)")
    end,
  },
  "chaoren/vim-wordmotion",
  "rhysd/clever-f.vim",
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    -- keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  },
  -- {
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("todo-comments").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end,
  -- },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup { snippet_engine = "luasnip" }
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<Leader>d", ":lua require('neogen').generate()<CR>", opts) -- Uncomment next line if you want to follow only stable versions
    end,
    -- version = "*"
  },
}
