return {
  {
    "hrsh7th/nvim-cmp",
    config = require "plugins.configs.cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      -- "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- "tzachar/cmp-tabnine",
      "petertriho/cmp-git",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      require("luasnip.loaders.from_lua").load { paths = {"~/.config/nvim/luasnippets" }}
      require("luasnip").config.setup {
        ext_opts = {
          [require("luasnip.util.types").choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
          [require("luasnip.util.types").insertNode] = {
            active = {
              virt_text = { { "●", "GruvboxBlue" } },
            },
          },
        },
        history = true,
        updateevents = "TextChanged,TextChangedI",
        region_check_events = "CursorMoved,CursorHold,InsertEnter",
        delete_check_events = "TextChanged",
        enable_autosnippets = true,
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "LuasnipChoiceNodeEnter",
        callback = function()
          if require("luasnip").choice_active() then
            vim.schedule(require "luasnip.extras.select_choice")
          end
        end,
      })
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    lazy = true,
    dependencies = { "L3MON4D3/LuaSnip" },
  },

  -- misc plugins
  -- { "tzachar/cmp-tabnine", build = "./install.sh" },
  {
    "petertriho/cmp-git",
    lazy = true,
    config = function()
      require("cmp_git").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    -- enabled = false,
    config = function()
      -- vim.schedule(function()
      require("copilot").setup {
        suggestion = {
          auto_trigger = true,
          keymap = { accept = "<C-e>", accept_word = "<C-f>" },
        },
        filetypes = {
          yaml = false,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      }
    end,
  },
}
