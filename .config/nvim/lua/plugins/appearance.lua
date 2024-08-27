return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
      require("lualine").setup {
        options = {
          -- theme = "auto",
          theme = "catppuccin",
          -- component_separators = "",
          section_separators = { left = "", right = "" },
          -- section_separators = { left = "a", right = "b" },
          component_separators = { left = "/", right = "/" },
        },
        --         winbar = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = {'filename'},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {}
        -- },
        tabline = {
          lualine_a = { {
            'tabs',
            max_length = vim.o.columns,
            mode = 2,
            path = 1,
          } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        sections = {
          lualine_x = {
            'encoding', 'fileformat', 'filetype',
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
          },
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
    config = function()
      -- require("notify").setup {
      --   background_colour = "#000000",
      --   top_down = false
      -- }
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          -- bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
      }

      local search = vim.api.nvim_get_hl_by_name("Search", true)
      vim.api.nvim_set_hl(0, 'TransparentSearch', { fg = search.foreground })

      local help = vim.api.nvim_get_hl_by_name("IncSearch", true)
      vim.api.nvim_set_hl(0, 'TransparentHelp', { fg = help.foreground })

      local cmdGroup = 'DevIconLua'
      local noice_cmd_types = {
        CmdLine    = cmdGroup,
        Input      = cmdGroup,
        Lua        = cmdGroup,
        Filter     = cmdGroup,
        Rename     = cmdGroup,
        Substitute = "Define",
        Help       = "TransparentHelp",
        Search     = "TransparentSearch"
      }

      for type, hl in pairs(noice_cmd_types) do
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder" .. type, { link = hl })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. type, { link = hl })
      end
      vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { link = cmdGroup })
    end,
  },
  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     background_colour = "#000000",
  --   }
  -- },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "lukas-reineke/indent-blankline.nvim",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup { scope = { highlight = highlight } }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
  }
}
