local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "wrap_spell",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "docker_compose*.yml" },
  command = "set filetype=yaml.docker-compose",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Dockerfile*.yml" },
  command = "set filetype=dockerfile",
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = augroup "lazy_autoupdate",
--   callback = function()
--     require("lazy").update { show = false }
--     require("nvim-treesitter.install").update()
--   end,
-- })
