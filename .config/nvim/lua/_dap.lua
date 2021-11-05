require("dapui").setup()

local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<M-r>', "<cmd> lua require'dap'.continue()<CR>",
                        opts)
vim.api.nvim_set_keymap('n', '<M-n>', "<cmd> lua require'dap'.step_over()<CR>",
                        opts)
vim.api.nvim_set_keymap('n', '<M-i>', "<cmd> lua require'dap'.step_into()<CR>",
                        opts)
vim.api.nvim_set_keymap('n', '<M-f>', "<cmd> lua require'dap'.step_out()<CR>",
                        opts)
vim.api.nvim_set_keymap('n', '<M-b>',
                        "<cmd> lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap('n', '<M-B>',
                        "<cmd> lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                        opts)
vim.api.nvim_set_keymap('n', '<M-p>',
                        "<cmd> lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
                        opts)
vim.api.nvim_set_keymap('n', '<M-l>', "<cmd> lua require'dap'.run_last()<CR>",
                        opts)
vim.api.nvim_set_keymap('n', '<M-q>',
                        "<cmd> lua require'dapui'.close(); require'dap'.close(); require'dapui'.close()<CR>",
                        opts)

local dap = require('dap')
local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dapui").eval()<CR>',
                        {silent = true})
end

dap.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs,
                                keymap.rhs, {silent = keymap.silent == 1})
    end
    keymap_restore = {}
end

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed
    name = "lldb"
}

require("nvim-dap-virtual-text").setup {
    show_stop_reason = false,
    highlight_changed_variables = true
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ',
                                vim.fn.getcwd() .. '/build/app', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false
    }
}
