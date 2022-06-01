local cmp = require('cmp')
-- local luasnip = require("luasnip")
require("cmp_nvim_ultisnips").setup {}
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

-- Ultisnips
vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
vim.g.UltiSnipsRemoveSelectModeMappings = 0
vim.g.ultisnips_python_style = 'google'
vim.g.snips_author = 'astadnik'

local function t(keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, true, true), "m", true)
end

cmp.setup {
  experimental = {
    ghost_text = true
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, vim_item)
      vim_item.menu = vim_item.kind
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-j>"] = cmp.mapping(
      {
        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        x = function() t("<Plug>(ultisnips_expand)") end,
      }
    ),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        t('<Plug>(ultisnips_jump_forward)')
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        t('<Plug>(ultisnips_jump_backward)')
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end,
  sources = cmp.config.sources({
    { name = 'ultisnips' }, { name = 'nvim_lsp' }, { name = 'tmux' },
    { name = 'spell' }, { name = 'path' }, { name = 'cmp_tabnine' }, { name = 'crates' },
    { name = 'dap' }
  }),
  -- preselect = cmp.PreselectMode.None,
}

-- Use buffer source for `/`.
require 'cmp'.setup.cmdline('/', {
  mappings = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  mappings = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'cmdline' } }, { { name = 'path' } })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
