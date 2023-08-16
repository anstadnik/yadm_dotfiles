vim.g.tex_comment_nospell = 1
vim.wo.conceallevel = 2
vim.g.tex_conceal = "abdgm"
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_gb", "uk", "ru" }

-- SPELL
vim.opt_local.spell = true
vim.bo.spelllang = "en_gb"
vim.keymap.set(
  "i",
  "<M-l>",
  "<C-g>u<Esc>[s1z=`]a<C-g>u",
  { buffer = true, desc = "Fix Last Miss-Spelling", remap = true }
)

vim.keymap.set("n", "<CR>", "<Cmd>update<CR><Cmd>TexlabBuild<CR>", { buffer = true, desc = "Compile LaTeX" })
vim.keymap.set("n", "<leader><CR>", "<Cmd>TexlabForward<CR>", { buffer = true, desc = "View PDF" })
