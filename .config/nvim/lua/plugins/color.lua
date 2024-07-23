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
          cmp = true,
          gitsigns = true,
          noice = true,
          nvimtree = true,
          treesitter = true,
          telescope = true,
          sandwich = true,
          rainbow_delimiters = true,
          -- lsp_trouble = true,
          -- octo = true,
          -- neotest = true,
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          -- -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      }
      -- vim.opt.background = "dark"
      -- set_light_mode()
      vim.cmd.colorscheme "catppuccin"
    end,
  }
}
