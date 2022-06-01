local ls    = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.setup {
  update_events = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<- Current Choice', 'NonText' } },
      },
    },
    -- [types.insertNode] = {
    -- 	active = {
    -- virt_text = { { '◍', 'DiagnosticSignHint' } },
    -- 	},
    -- },
  },
}

vim.keymap.set({ 'i', 's' }, '<C-h>',
  function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end,
  { desc = 'LuaSnip Backward Jump' })
vim.keymap.set({ 'i', 's' }, '<C-l>',
  function()
    if ls.jumpable(1) then
      ls.jump(1)
    end
  end,
  { desc = 'LuaSnip Next Choice' })

require('luasnip.loaders.from_lua').lazy_load()

-- vim.api.nvim_add_user_command('LuaSnipEdit', edit_ft, {})
