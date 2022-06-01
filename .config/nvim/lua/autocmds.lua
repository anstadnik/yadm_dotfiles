vim.api.nvim_create_augroup('HighlightYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group    = 'HighlightYank',
  desc     = 'Highlight the yanked text',
})

vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  pattern = 'plugins.lua',
  group   = 'packer_user_config',
  desc    = 'Compile whenever plugins.lua is updated',
})
