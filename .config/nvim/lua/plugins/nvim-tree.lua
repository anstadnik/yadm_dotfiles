return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "jose-elias-alvarez/null-ls.nvim",
    },
    keys = { "<C-n>" },
    config = function()
      -- local function open_nvim_tree(data)
      --   -- buffer is a [No Name]
      --   local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
      --
      --   -- buffer is a directory
      --   local directory = vim.fn.isdirectory(data.file) == 1
      --
      --   if not no_name and not directory then
      --     return
      --   end
      --
      --   -- change to the directory
      --   if directory then
      --     vim.cmd.cd(data.file)
      --   end
      --
      --   -- open the tree
      --   require("nvim-tree.api").tree.open()
      -- end
      -- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

      require("nvim-tree").setup {
        -- open_on_setup = true,
        diagnostics = { enable = true },
        modified = { enable = true },
        -- view = { float = { enable = true } },
      }
      vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeFindFileToggle <CR>")
      -- vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>")
    end,
  },
}
