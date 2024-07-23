return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        transparent_background = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        integrations = {
          -- cmp = true,
          gitsigns = true,
          -- nvimtree = true,
          -- telescope = true,
          -- sandwich = true,
          -- lsp_trouble = true,
          -- octo = true,
          -- neotest = true,
          mason = true,
          -- -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      }
      -- vim.opt.background = "dark"
      -- set_light_mode()
      vim.cmd.colorscheme "catppuccin"
    end,
  }
  }
