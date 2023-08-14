return function()
  vim.keymap.set("n", "<A-c>", function()
    require("dap").continue()
  end)
  vim.keymap.set("n", "<A-o>", function()
    require("dap").step_over()
  end)
  vim.keymap.set("n", "<A-i>", function()
    require("dap").step_into()
  end)
  vim.keymap.set("n", "<A-u>", function()
    require("dap").step_out()
  end)
  vim.keymap.set("n", "<A-b>", function()
    require("dap").toggle_breakpoint()
  end)
  vim.keymap.set("n", "<A-B>", function()
    require("dap").set_breakpoint()
  end)
  vim.keymap.set("n", "<A-p>", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
  end)
  vim.keymap.set("n", "<A-r>", function()
    require("dap").repl.open()
  end)
  vim.keymap.set("n", "<A-l>", function()
    require("dap").run_last()
  end)
  vim.keymap.set({ "n", "v" }, "<A-h>", function()
    require("dap.ui.widgets").hover()
  end)
  vim.keymap.set({ "n", "v" }, "<A-v>", function()
    require("dap.ui.widgets").preview()
  end)
  vim.keymap.set("n", "<A-f>", function()
    local widgets = require "dap.ui.widgets"
    widgets.centered_float(widgets.frames)
  end)
  vim.keymap.set("n", "<A-s>", function()
    local widgets = require "dap.ui.widgets"
    widgets.centered_float(widgets.scopes)
  end)
  -- vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>
  vim.keymap.set("v", "<A-k>", function()
    require("dapui").eval()
  end)
  vim.keymap.set("n", "<A-q>", function()
    require("dap").terminate()
  end)

  require("dapui").setup()
  require("nvim-dap-virtual-text").setup {
    highlight_new_as_changed = true,
  }

  local dap, dapui = require "dap", require "dapui"
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  require("dap-python").setup "python3"
end
