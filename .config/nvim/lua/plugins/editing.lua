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
  -- {
  --   "danymat/neogen",
  --   keys = { "<Leader>d" },
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = function()
  --     require("neogen").setup { snippet_engine = "luasnip" }
  --     local opts = { noremap = true, silent = true }
  --     vim.api.nvim_set_keymap("n", "<Leader>d", ":lua require('neogen').generate()<CR>", opts) -- Uncomment next line if you want to follow only stable versions
  --   end,
  --   -- version = "*"
  -- },
  -- {
  --   "stevearc/profile.nvim",
  --   config = function()
  --     local should_profile = os.getenv "NVIM_PROFILE"
  --     if should_profile then
  --       require("profile").instrument_autocmds()
  --       if should_profile:lower():match "^start" then
  --         require("profile").start "*"
  --       else
  --         require("profile").instrument "*"
  --       end
  --     end
  --
  --     local function toggle_profile()
  --       local prof = require "profile"
  --       if prof.is_recording() then
  --         prof.stop()
  --         vim.ui.input(
  --           { prompt = "Save profile to:", completion = "file", default = "profile.json" },
  --           function(filename)
  --             if filename then
  --               prof.export(filename)
  --               vim.notify(string.format("Wrote %s", filename))
  --             end
  --           end
  --         )
  --       else
  --         prof.start "*"
  --       end
  --     end
  --     vim.keymap.set("", "<f1>", toggle_profile)
  --   end,
  -- },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    build = "make tiktoken",        -- Only on MacOS or Linux
    keys = {
      {
        "<leader>d",
        function()
          require("CopilotChat").ask(
            "/COPILOT_GENERATE Please add documentation comment for the selection, use google style. Do not output line numbers, nor make additional offsets.",
            { selection = require("CopilotChat.select").buffer })
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
          "<leader>p",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
        mode = { 'n', 'x' }
      }
    },

    opts = {
    --   debug = true, -- Enable debugging
    --   -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },

}
