-- Formatting (python)
require('formatter').setup({
  filetype = {
    python = {
      -- autopep8
      function()
        return {
          exe = "black",
          args = { "-" },
          stdin = true,
          cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
        }
      end, function()
        return {
          exe = "isort",
          args = { "-" },
          stdin = true,
          cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
        }
      end
    }
  }
})
