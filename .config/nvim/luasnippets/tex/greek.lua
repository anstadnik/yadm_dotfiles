local snips, autosnips = {}, {}

local tex = require "snips.latex"

-- Define a function to replace LaTeX shorthands with their corresponding symbols
local letters = {
  "alpha",
  "beta",
  "gamma",
  "delta",
  "epsilon",
  "zeta",
  "eta",
  "theta",
  "iota",
  "kappa",
  "lambda",
  "mu",
  "nu",
  "xi",
  "pi",
  "rho",
  "sigma",
  "tau",
  "upsilon",
  "phi",
  "chi",
  "psi",
  "omega",
}

-- snips = {
--   s(
--     { trig = pattern, name = pattern, regTrig = true, hidden = true },
--     {
--       f(function(_, snip)
--         return string.format("\\%s", snip.captures[1])
--       end, {}),
--     },
--     { condition = tex.in_mathzone }
--   ),
-- }

for _, l in pairs(letters) do
  table.insert(
    autosnips,
    s({ trig = l, name = l, regTrig = true, hidden = true }, t("\\" .. l), { condition = tex.in_mathzone })
  )
end

return snips, autosnips
