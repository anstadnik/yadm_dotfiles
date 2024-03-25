return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
    },
    -- event = "BufEnter",
    config = function()
      vim.treesitter.language.register("python", "sage")

      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          -- Required
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",

          "rust",
          "python",
          "comment",
          "latex",
          "bash",
          "regex",
          "markdown",
          "dart",
          "markdown_inline",
          -- "julia",
          "cpp",
        },
        highlight = { enable = true },
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[a"] = "@parameter.outer",
              ["[C"] = "@class.outer",
              -- ["[c"] = "@conditional.outer",
              ["[e"] = "@block.outer",
              ["[l"] = "@loop.outer",
              ["[s"] = "@statement.inner",
              -- ["[d"] = "@comment.outer",
              ["[m"] = "@call.outer",
            },
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]a"] = "@parameter.outer",
              ["]C"] = "@class.outer",
              -- ["]c"] = "@conditional.outer",
              ["]e"] = "@block.outer",
              ["]l"] = "@loop.outer",
              ["]s"] = "@statement.inner",
              -- ["]d"] = "@comment.outer",
              ["]m"] = "@call.outer",
            },
          },
          select = {
            enable = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["aC"] = "@class.outer",
              ["iC"] = "@class.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["ae"] = "@block.outer",
              ["ie"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["is"] = "@statement.inner",
              ["as"] = "@statement.outer",
              ["ad"] = "@comment.outer",
              ["am"] = "@call.outer",
              ["im"] = "@call.inner",
            },
          },
          lsp_interop = {
            enable = true,
            peek_definition_code = {
              ["<C-p>"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>a"] = "@parameter.inner" },
            swap_previous = { ["<leader>A"] = "@parameter.inner" },
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>v",
            node_incremental = "<leader>v",
            scope_incremental = "<leader>s",
            node_decremental = "<leader>m",
          },
        },
        indent = {
          enable = true,
          disable = { "python", "dart" },
        },
        textsubjects = {
          enable = true,
          prev_selection = ",", -- (Optional) keymap to select the previous selectiontree
          keymaps = {
            ["."] = "textsubjects-smart",
            [":"] = "textsubjects-container-outer",
            ["i:"] = "textsubjects-container-inner",
          },
        },
      }
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
    end,
  },
  {
    "cshuaimin/ssr.nvim",
    -- Calling setup is optional.
    config = function()
      vim.keymap.set({ "n", "x" }, "<leader>sr", function()
        require("ssr").open()
      end)
    end,
  },
  {
    "ziontee113/syntax-tree-surfer",
    keys = { "vU", "vD", "vd", "vu", "vx", "vn", "J", "K", "H", "L", "<A-j>", "<A-k>" },
    config = function()
      -- Syntax Tree Surfer
      local opts = { noremap = true, silent = true }

      -- Normal Mode Swapping:
      -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
      vim.keymap.set("n", "vU", function()
        vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })
      vim.keymap.set("n", "vD", function()
        vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })

      -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
      vim.keymap.set("n", "vd", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })
      vim.keymap.set("n", "vu", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
        return "g@l"
      end, { silent = true, expr = true })

      -- Visual Selection from Normal Mode
      vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>", opts)
      vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>", opts)

      -- Select Nodes in Visual Mode
      vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", opts)
      vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", opts)
      vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<cr>", opts)
      vim.keymap.set("x", "L", "<cmd>STSSelectChildNode<cr>", opts)

      -- Swapping Nodes in Visual Mode
      -- vim.keymap.set("x", "<A-j>", "<cmd>STSSwapNextVisual<cr>", opts)
      -- vim.keymap.set("x", "<A-k>", "<cmd>STSSwapPrevVisual<cr>", opts)

      -- Setup Function example:
      -- These are the default options:
      require("syntax-tree-surfer").setup {
        highlight_group = "STS_highlight",
        disable_no_instance_found_report = false,
        default_desired_types = {
          "function",
          "arrow_function",
          "function_definition",
          "if_statement",
          "else_clause",
          "else_statement",
          "elseif_statement",
          "for_statement",
          "while_statement",
          "switch_statement",
        },
        left_hand_side = "fdsawervcxqtzb",
        right_hand_side = "jkl;oiu.,mpy/n",
        icon_dictionary = {
          ["if_statement"] = "",
          ["else_clause"] = "",
          ["else_statement"] = "",
          ["elseif_statement"] = "",
          ["for_statement"] = "ﭜ",
          ["while_statement"] = "ﯩ",
          ["switch_statement"] = "ﳟ",
          ["function"] = "",
          ["function_definition"] = "",
          ["variable_declaration"] = "",
        },
      }
    end,
  },
}
