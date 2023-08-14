local snips, autosnips = {}, {}

local tex = require "snips.latex"

autosnips = {
  s( -- This snippets creates the sympy block ;)
    { trig = "sym", desc = "Creates a sympy block" },
    fmt("sympy {} sympy{}", { i(1), i(0) }),
    { condition = tex.in_mathzone }
  ),

  s( -- This one evaluates anything inside the simpy block
    { trig = "sympy.*sympy ", regTrig = true, desc = "Sympy block evaluator" },
    d(1, function(_, parent)
      -- Gets the part of the block we actually want, and replaces spaces
      -- at the beginning and at the end
      local to_eval = string.gsub(parent.trigger, "^sympy(.*)sympy ", "%1")
      to_eval = string.gsub(to_eval, "^%s+(.*)%s+$", "%1")

      local Job = require "plenary.job"

      local sympy_script = string.format(
        [[
from sympy import *
from sympy.parsing.sympy_parser import parse_expr
from sympy.printing.latex import print_latex
parsed = parse_expr('%s')
print_latex(parsed)
            ]],
        to_eval
      )

      sympy_script = string.gsub(sympy_script, "^[\t%s]+", "")
      local result = ""

      Job:new({
        command = "python",
        args = { "-c", sympy_script },
        on_exit = function(j)
          print(vim.inspect(j))
          result = j:result()
        end,
      }):sync()

      return sn(nil, t(result))
    end),
    { condition = tex.in_mathzone }
  ),
}

return snips, autosnips
