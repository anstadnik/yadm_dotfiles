return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {}
      --   flavour = "mocha", -- latte, frappe, macchiato, mocha
      --   background = { -- :h background
      --     light = "latte",
      --     dark = "mocha",
      --   },
      --   transparent_background = false,
      --   show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      --   term_colors = false,
      --   dim_inactive = {
      --     enabled = false,
      --     shade = "dark",
      --     percentage = 0.15,
      --   },
      --   no_italic = false, -- Force no italic
      --   no_bold = false, -- Force no bold
      --   styles = {
      --     comments = { "italic" },
      --     conditionals = { "italic" },
      --     loops = {},
      --     functions = {},
      --     keywords = {},
      --     strings = {},
      --     variables = {},
      --     numbers = {},
      --     booleans = {},
      --     properties = {},
      --     types = {},
      --     operators = {},
      --   },
      --   color_overrides = {},
      --   custom_highlights = {},
      --   integrations = {
      --     cmp = true,
      --     gitsigns = true,
      --     nvimtree = true,
      --     telescope = true,
      --     notify = false,
      --     mini = false,
      --     -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      --   },
      -- }
      vim.opt.background = "light"
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = function()
      return vim.fn.has "macunix"
    end,
    dependencies = { "catppuccin/nvim" },
    config = function()
      local auto_dark_mode = require "auto-dark-mode"

      auto_dark_mode.setup {
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option("background", "dark")
          vim.fn.system { "kitty", "+kitten", "themes", "Catppuccin-Mocha" }
        end,
        set_light_mode = function()
          vim.api.nvim_set_option("background", "light")
          vim.fn.system { "kitty", "+kitten", "themes", "Catppuccin-Latte" }
        end,
      }
      auto_dark_mode.init()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        theme = "catppuccin",
        options = {
          component_separators = "",
          section_separators = { left = "", right = "" },
          -- section_separators = { left = "█", right = "█" },
        },
        sections = {
          lualine_c = {
            "filename",
            -- {
            --   require("nvim-navic").get_location,
            --   cond = require("nvim-navic").is_available,
            -- },
          },
          lualine_x = {
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
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin",
    },
    config = function()
      require("bufferline").setup {
        options = {
          mode = "tabs",
          separator_style = "slope",
          highlights = require("catppuccin.groups.integrations.bufferline").get(),
          diagnostidcs = "nvim_lsp",
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
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    "KeitaNakamura/tex-conceal.vim",
    ft = { "tex" },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)

      require("ufo").setup()
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require "statuscol.builtin"
      require("statuscol").setup {
        relculright = true,
        segments = {
          { text = { builtin.foldfunc } },
          { sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true } },
          { text = { builtin.lnumfunc } },
          { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1 } },
        },
      }
    end,
  },
  {
    "Pocco81/true-zen.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    config = function()
      require("true-zen").setup {
        modes = { -- configurations per mode
          ataraxis = {
            padding = { -- padding windows
              left = 42,
              right = 42,
              top = 0,
              bottom = 0,
            },
          },
        },
        integrations = {
          tmux = true, -- hide tmux status bar in (minimalist, ataraxis)
          kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
            enabled = true,
            font = "+3",
          },
          twilight = true, -- enable twilight (ataraxis)
          lualine = true, -- hide nvim-lualine (ataraxis)
        },
      }
    end,
  },
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

      -- vim.g.rainbow_delimiters = { highlight = highlight }

      -- Rainbow delimiters setup
      -- This module contains a number of default definitions
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
      --     latex = "rainbow-blocks",
        },
        highlight = highlight,
      }

      -- Indent blankline setup
      require("ibl").setup { scope = { highlight = highlight } }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      -- local rainbow_delimiters = require "rainbow-delimiters"
      -- require "rainbow-delimiters.setup" {
      --   strategy = {
      --     [""] = rainbow_delimiters.strategy["global"],
      --     commonlisp = rainbow_delimiters.strategy["local"],
      --   },
      --   query = {
      --     [""] = "rainbow-delimiters",
      --     latex = "rainbow-blocks",
      --   },
      --   highlight = {
      --     "RainbowDelimiterRed",
      --     "RainbowDelimiterYellow",
      --     "RainbowDelimiterBlue",
      --     "RainbowDelimiterOrange",
      --     "RainbowDelimiterGreen",
      --     "RainbowDelimiterViolet",
      --     "RainbowDelimiterCyan",
      --   },
      --   -- blacklist = {'c', 'cpp'},
      --   -- extended_mode = true,
      --   -- max_file_lines = nil,
      -- }
    end,
  },
  -- {
  -- ,
  --     config = function()
  --       require("ibl").setup {
  --         show_current_context = true,
  --         show_current_context_start = true,
  --       }
  --     end,
  --   },
}
