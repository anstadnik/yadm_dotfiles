local target_pane = "{bottom-right}"

local opt = vim.opt
opt.expandtab = true -- Convert tabs to spaces
opt.tabstop = 4 -- Number of spaces in a tab
opt.softtabstop = 4 -- Number of spaces in a soft tab
opt.shiftwidth = 4 -- Number of spaces to use for autoindent

vim.keymap.set("n", "<CR>", function()
  -- Find main.py in the current directory or parent directories
  local main_py = vim.fn.findfile("main.py", "endpoints/topic-modeling-endpoint;")
  local main_py = vim.fn.findfile("main.py", ".;")

  -- If main.py is found, execute it with Python
  if main_py == "" then
    main_py = vim.api.nvim_buf_get_name(0)
  end

  vim.api.nvim_command "write"
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "clear", "Enter" }
  -- vim.fn.system { "tmux", "send-keys", "-t", target_pane, "ipython " .. main_py, "Enter" }
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "ipython " .. main_py, " --", "Enter" }
end, { buffer = true })

vim.keymap.set("n", "<leader><CR>", function()
  -- Find main.py in the current directory or parent directories
  local main_py = vim.fn.findfile("main.py", ".;")

  -- If main.py is found, execute it with Python
  if main_py == "" then
    main_py = vim.api.nvim_buf_get_name(0)
  end

  vim.api.nvim_command "write"
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "clear\n" }
  -- vim.fn.system { "tmux", "send-keys", "-t", target_pane, "python -m unittest\n" }
  vim.fn.system { "tmux", "send-keys", "-t", target_pane, "pytest\n" }
end, { buffer = true })
