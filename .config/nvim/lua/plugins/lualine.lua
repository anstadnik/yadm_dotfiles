local gps = require("nvim-gps")

require 'lualine'.setup({
  sections = {
    lualine_c = { { 'filename', file_status = true }, 'diff' },
    lualine_y = { "require'lsp-status'.status()",
      { gps.get_location, cond = gps.is_available }
    }
  },
  options = {
    -- theme = 'nord',
    theme = 'onenord',
    section_separators = { left = '', right = '' },
    component_separators = { left = '/', right = '/' },
    extensions = { 'nvim-tree', 'fugitive' },
    globalstatus = true
  }
})
