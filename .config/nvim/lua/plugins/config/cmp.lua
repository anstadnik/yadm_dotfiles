return function()
  local cmp = require "cmp"
  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      -- ["<C-f>"] = cmp.mapping(function(fallback)
      --   if require("copilot.suggestion").is_visible() then
      --     require("copilot.suggestion").accept()
      --   else
      --     fallback()
      --   end
      -- end),
      ["<C-Space>"] = {
        i = function()
          if cmp.visible() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
          else
            cmp.complete()
          end
        end,
        c = function()
          if cmp.visible() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
          else
            cmp.complete()
          end
        end,
        x = function(fallback)
          if require("luasnip").jumpable() then
            require("luasnip").jump()
          else
            fallback()
          end
        end,
      },
      ["<C-j>"] = cmp.mapping.scroll_docs(4),
      ["<C-k>"] = cmp.mapping.scroll_docs(-4),
      ["<C-l>"] = cmp.mapping(function(fallback)
        if require("luasnip").jumpable(1) then
          require("luasnip").jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function(fallback)
        if require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = {
      -- { name = 'copilot'},
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      -- { name = "nvim_lua" },
      { name = "path" },
      { name = "cmp_tabnine" },
      { name = "git" },
    },
    formatting = {
      expandable_indicator = true,
      fields = { "kind", "abbr", "menu" },
      format = require("lspkind").cmp_format { mode = "symbol" },
    },
  }

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
