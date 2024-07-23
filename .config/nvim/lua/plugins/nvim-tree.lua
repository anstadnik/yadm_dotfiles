return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- "jose-elias-alvarez/null-ls.nvim",
    },
    keys = { "<C-n>" },
    config = function()
      require("nvim-tree").setup {
      }
      vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeFindFileToggle <CR>")
      -- vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>")
    end,
  },
}
