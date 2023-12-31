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
    keys = { "<Leader>d" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup { snippet_engine = "luasnip" }
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<Leader>d", ":lua require('neogen').generate()<CR>", opts) -- Uncomment next line if you want to follow only stable versions
    end,
    -- version = "*"
  },
  {
    "stevearc/profile.nvim",
    config = function()
      local should_profile = os.getenv "NVIM_PROFILE"
      if should_profile then
        require("profile").instrument_autocmds()
        if should_profile:lower():match "^start" then
          require("profile").start "*"
        else
          require("profile").instrument "*"
        end
      end

      local function toggle_profile()
        local prof = require "profile"
        if prof.is_recording() then
          prof.stop()
          vim.ui.input(
            { prompt = "Save profile to:", completion = "file", default = "profile.json" },
            function(filename)
              if filename then
                prof.export(filename)
                vim.notify(string.format("Wrote %s", filename))
              end
            end
          )
        else
          prof.start "*"
        end
      end
      vim.keymap.set("", "<f1>", toggle_profile)
    end,
  },
}
