return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "aaronhallaert/advanced-git-search.nvim",
      "nvim-telescope/telescope-bibtex.nvim",
    },
    event = "BufEnter",
    -- cmd = "Telescope",
    keys = {
      "<leader>n",
      "<leader>/",
      "<leader>ff",
      "<leader>fa",
      -- "<leader>fw",
      "<leader>fb",
      "<leader>fh",
      "<leader>fo",
      "<leader>tk",
      "<leader>cm",
      "<leader>gt",
      "<leader>fu",
      "g/",
    },
    config = function()
      vim.keymap.set("n", "<leader>n", "<cmd> Telescope find_files <CR>")
      vim.keymap.set("n", "<leader>/", "<cmd> Telescope live_grep <CR>")
      vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
      vim.keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
      -- vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
      vim.keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
      vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
      vim.keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
      vim.keymap.set("n", "<leader>tk", "<cmd> Telescope keymaps <CR>")
      vim.keymap.set("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
      vim.keymap.set("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
      vim.keymap.set("n", "<leader>fu", "<cmd> Telescope undothemes <CR>")
      vim.keymap.set("n", "g/", "<cmd> Telescope advanced_git_search show_custom_functions <CR>")
      require("telescope").setup {
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          mappings = {
            i = { ["<esc>"] = require("telescope.actions").close },
          },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_cursor {} },
          bibtex = { format = "plain" },
          undo = {
            undo = {
              side_by_side = true,
              layout_strategy = "vertical",
              layout_config = {
                preview_height = 0.8,
              },
            },
          },
        },
      }
      require("telescope").load_extension "ui-select"
      require("telescope").load_extension "undo"
      require("telescope").load_extension "advanced_git_search"
    end,
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    cmd = "AdvancedGitSearch",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- OPTIONAL: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      "sindrets/diffview.nvim",
    },
  },
}
