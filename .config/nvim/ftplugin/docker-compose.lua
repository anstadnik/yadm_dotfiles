local target_pane = "{bottom-right}"

vim.keymap.set("n", "<CR>", function()
  vim.api.nvim_command "write"

  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "clear", "Enter" }
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "docker-compose -f docker_compose.yml up --build", "Enter" }
  -- vim.fn.system { "tmux", "send-keys", "-t", target_pane, "docker build .", "Enter" }
end, { buffer = true })
