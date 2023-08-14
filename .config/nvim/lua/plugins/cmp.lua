return {
  {
    "hrsh7th/nvim-cmp",
    config = require "plugins.configs.cmp",
    -- event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lua",
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
      require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/luasnippets" }
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
          keymap = { accept = "<C-f>" },
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
      -- end)
      -- ["<C-f>"] = cmp.mapping(function(fallback)
      --   if require("copilot.suggestion").is_visible() then
      --     require("copilot.suggestion").accept()
      --   else
      --     fallback()
      --   end
      -- end),
      -- vim.keymap.set("n", "<C-f>", require("copilot.suggestion").accept)
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   -- enabled = false,
  --   dependencies = {
  --     "zbirenbaum/copilot.lua",
  --     "onsails/lspkind.nvim",
  --   },
  --   config = function()
  --     require("copilot_cmp").setup()
  --
  --     local lspkind = require "lspkind"
  --     lspkind.init { symbol_map = { Copilot = "" } }
  --
  --     vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  --   end,
  -- },
  -- {
  --   "Exafunction/codeium.vim",
  --   config = function()
  --     vim.g.codeium_no_map_tab = 0
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set("i", "<C-f>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --     -- vim.keymap.set("i", "<c-;>", function()
  --     --   return vim.fn["codeium#CycleCompletions"](1)
  --     -- end, { expr = true })
  --     -- vim.keymap.set("i", "<c-,>", function()
  --     --   return vim.fn["codeium#CycleCompletions"](-1)
  --     -- end, { expr = true })
  --     -- vim.keymap.set("i", "<c-x>", function()
  --     --   return vim.fn["codeium#Clear"]()
  --     -- end, { expr = true })
  --   end,
  -- },
}
