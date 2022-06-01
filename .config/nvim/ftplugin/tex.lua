local ts = require 'vim.treesitter'
local query = require 'vim.treesitter.query'

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}
-- local ALIGN_ENVIRONMENTS = {
--   ['{multline}']  = true,
--   ['{multline*}'] = true,
--   ['{eqnarray}']  = true,
--   ['{eqnarray*}'] = true,
--   ['{align}']     = true,
--   ['{align*}']    = true,
--   ['{array}']     = true,
--   ['{array*}']    = true,
--   ['{split}']     = true,
--   ['{split*}']    = true,
--   ['{alignat}']   = true,
--   ['{alignat*}']  = true,
--   ['[gather]']    = true,
--   ['[gather*]']   = true,
--   ['{flalign}']   = true,
--   ['{flalign*}']  = true,
-- }

local function get_node_at_cursor()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  col = col - 1

  local parser = ts.get_parser(buf, 'latex')
  if not parser then
    return
  end
  local root_tree = parser:parse()[1]
  local root = root_tree and root_tree:root()

  if not root then
    return
  end

  return root:named_descendant_for_range(row, col, row, col)
end

function In_text()
  local node = get_node_at_cursor()
  while node do
    if node:type() == 'text_mode' then
      return true
    elseif MATH_NODES[node:type()] then
      return false
    end
    node = node:parent()
  end
  return true
end

function In_mathzone()
  local node = get_node_at_cursor()
  print("HELLO")
  while node do
    if node:type() == 'text_mode' then
      return false
    elseif MATH_NODES[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

-- function In_align()
--   local buf = vim.api.nvim_get_current_buf()
--   local node = get_node_at_cursor()
--   while node do
--     if node:type() == 'math_environment' then
--       local begin = node:child(0)
--       local names = begin and begin:field 'name'
--
--       if names and names[1] and ALIGN_ENVIRONMENTS[query.get_node_text(names[1], buf)] then
--         return true
--       end
--     end
--     node = node:parent()
--   end
--   return false
-- end

-- function In_xymatrix()
--   local buf = vim.api.nvim_get_current_buf()
--   local node = get_node_at_cursor()
--   while node do
--     if node:type() == 'generic_command' then
--       local names = node:child(0)
--       if names and query.get_node_text(names, buf) == '\\xymatrix' then
--         return true
--       end
--     end
--     node = node:parent()
--   end
--   return false
-- end

vim.g.tex_comment_nospell = 1
vim.wo.conceallevel = 2
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_gb", "uk", "ru" }

-- SPELL
vim.opt_local.spell = true
vim.bo.spelllang = 'en_gb'
vim.keymap.set('i', '<M-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { buffer = true, desc = 'Fix Last Miss-Spelling' })

vim.keymap.set('n', '<CR>', '<Cmd>update<CR><Cmd>TexlabBuild<CR><Cmd>TexlabForward<CR>',
  { buffer = true, desc = 'Compile LaTeX' })
vim.keymap.set('n', '<leader><CR>', '<Cmd>TexlabForward<CR>', { buffer = true, desc = 'View PDF' })
