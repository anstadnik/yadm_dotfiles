return {
  -- {
  --   "jpalardy/vim-slime",
  --   ft = "julia",
  --   init = function ()
  --     vim.g.slime_dont_ask_default = 1
  --     vim.g.slime_no_mappings = 1
  --     vim.g.slime_paste_file = os.tmpname()
  --     vim.g.slime_target = "kitty"
  --     vim.g.slime_default_config = { listen_on = os.getenv "KITTY_LISTEN_ON", window_id = 2 }
  --   end,
  --   config = function()
  --     -- vim.g.slime_target = "tmux"
  --     -- vim.g.slime_default_config = { socket_name = "default", target_pane = "debug:" }
  --     vim.keymap.set("n", "<CR>", ":write<CR><Plug>SlimeParagraphSend")
  --     vim.keymap.set("x", "<CR>", "<Plug>SlimeRegionSend")
  --   end,
  -- },
}
