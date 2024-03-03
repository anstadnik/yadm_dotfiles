local leet_arg = "leetcode.nvim"

return {
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv()[1],
    build = ":TSUpdate html",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      -- "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- configuration goes here

      lang = "rust",
      arg = leet_arg,
      hooks = {
        ---@type fun(question: lc.ui.Question)[]
        ["question_enter"] = {
          function(_)
            -- vim.keymap.set("n", "<CR>", "<cmd>Leet test<CR>", { buffer = true })
            -- vim.keymap.set("n", "<leader><CR>", "<cmd>Leet submit<CR>", { buffer = true })

            vim.keymap.set("n", "<CR>", "<cmd>w | Leet test<CR>", { buffer = true })
            vim.keymap.set("n", "<leader><CR>", "<cmd>w | Leet submit<CR>", { buffer = true })
          end,
        },
      },
    },
  },
}
