vim.keymap.set({ "n", "v" }, ";", ":", { silent = false })
vim.keymap.set({ "n", "v" }, ":", ";", { silent = false })
vim.keymap.set("i", "jk", "<ESC>")
-- vim.keymap.set("i", "<C-c>", "<cmd> %y+ <CR>")
local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
vim.keymap.set("t", "<C-x>", termcodes "<C-\\><C-N>")
vim.keymap.set("n", "<CR>", function()
  vim.api.nvim_command "write"
end)
