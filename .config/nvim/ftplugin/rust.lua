vim.keymap.set("n", "<CR>", function()
  vim.api.nvim_command "write"
  vim.fn.system { "tmux", "send-keys", "-t", "{bottom-left}", "clear\n" }
  vim.fn.system { "tmux", "send-keys", "-t", "{bottom-left}", "cargo run\n" }
end, {})
vim.keymap.set("n", "<leader><CR>", function()
  vim.api.nvim_command "write"
  vim.fn.system { "tmux", "send-keys", "-t", "{bottom-left}", "clear\n" }
  vim.fn.system { "tmux", "send-keys", "-t", "{bottom-left}", "cargo run --release\n" }
end, {})
