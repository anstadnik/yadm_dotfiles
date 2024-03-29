local snips, autosnips = {}, {}

local conds_expand = require "luasnip.extras.conditions.expand"
local tex = require "snips.latex"
local position = require "snips.position"

local rec_ls
rec_ls = function()
  return sn(nil, {
    c(1, {
      t { "" },
      sn(nil, { t { "", "\t\\item " }, i(1), d(2, rec_ls, {}) }),
    }),
  })
end

autosnips = {
  s(
    { trig = "beg", name = "begin{} end{}" },
    { t { "\\begin{" }, i(1), t { "}", "\t" }, i(0), t { "", "\\end{" }, rep(1), t { "}" } },
    {
      condition = conds_expand.line_begin,
      show_condition = position.line_begin,
    }
  ),
  s(
    { trig = "beq", name = "Equation Environment", dscr = "Create an equation environment." },
    { t { "\\begin{equation}", "\t" }, i(1), t { "", "\\end{equation}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  s(
    { trig = "bseq", name = "Equation Environment without number", dscr = "Create a star equation environment." },
    { t { "\\begin{equation*}", "\t" }, i(1), t { "", "\\end{equation*}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  s(
    { trig = "proof", name = "Proof Environment", dscr = "Create a proof environment." },
    { t { "\\begin{proof}", "\t" }, i(0), t { "", "\\end{proof}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  s(
    { trig = "thm", name = "Theorem Environment", dscr = "Create a theorem environment." },
    { t { "\\begin{theorem}", "\t" }, i(0), t { "", "\\end{theorem}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  s(
    { trig = "lem", name = "Lemma Environment", dscr = "Create a lemma environment." },
    { t { "\\begin{lemma}", "\t" }, i(0), t { "", "\\end{lemma}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  s(
    { trig = "def", name = "Definition Environment", dscr = "Create a definition environment." },
    { t { "\\begin{definition}", "\t" }, i(0), t { "", "\\end{definition}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  s(
    { trig = "prop", name = "Proposition Environment", dscr = "Create a proposition environment." },
    { t { "\\begin{proposition}", "\t" }, i(0), t { "", "\\end{proposition}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  -- s(
  --   { trig = "cor", name = "Corollary Environment", dscr = "Create a corollary environment." },
  --   { t { "\\begin{corollary}", "\t" }, i(0), t { "", "\\end{corollary}" } },
  --   {
  --     condition = conds_expand.line_begin * tex.in_text,
  --     show_condition = position.line_begin * tex.in_text,
  --   }
  -- ),
  s(
    { trig = "rem", name = "Remark Environment", dscr = "Create a remark environment." },
    { t { "\\begin{remark}", "\t" }, i(0), t { "", "\\end{remark}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  s(
    { trig = "conj", name = "Conjecture Environment", dscr = "Create a conjecture environment." },
    { t { "\\begin{conjecture}", "\t" }, i(0), t { "", "\\end{conjecture}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),

  s(
    { trig = "lprf", name = "Titled Proof", dscr = "Create a titled proof environment." },
    { t "\\begin{proof}[Proof of \\cref{", i(1), t { "}]", "\t" }, i(0), t { "", "\\end{proof}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = position.line_begin * tex.in_text,
    }
  ),
  s({
    trig = "lthm",
    name = "Theorem Environment with name and lable",
    dscr = "Create a theorem environment with name and lable.",
  }, {
    t { "\\begin{theorem}[" },
    i(1),
    t { "]\\label{thm:" },
    l(l._1:gsub("[^%w]+", "_"):gsub("_$", ""):lower(), 1),
    t { "}", "\t" },
    i(0),
    t { "", "\\end{theorem}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = position.line_begin * tex.in_text,
  }),
  s({
    trig = "llem",
    name = "Lemma Environment with name and lable",
    dscr = "Create a lemma environment with name and lable.",
  }, {
    t { "\\begin{lemma}[" },
    i(1),
    t { "]\\label{lem:" },
    l(l._1:gsub("[^%w]+", "_"):gsub("_$", ""):lower(), 1),
    t { "}", "\t" },
    i(0),
    t { "", "\\end{lemma}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = position.line_begin * tex.in_text,
  }),
  s({
    trig = "ldef",
    name = "Definition Environment with name and lable",
    dscr = "Create a definition environment with name and lable.",
  }, {
    t { "\\begin{definition}[" },
    i(1),
    t { "]\\label{def:" },
    l(l._1:gsub("[^%w]+", "_"):gsub("_$", ""):lower(), 1),
    t { "}", "\t" },
    i(0),
    t { "", "\\end{definition}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = position.line_begin * tex.in_text,
  }),
  s({
    trig = "lprop",
    name = "Proposition Environment with name and lable",
    dscr = "Create a proposition environment with name and lable.",
  }, {
    t { "\\begin{proposition}[" },
    i(1),
    t { "]\\label{prop:" },
    l(l._1:gsub("[^%w]+", "_"):gsub("_$", ""):lower(), 1),
    t { "}", "\t" },
    i(0),
    t { "", "\\end{proposition}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = position.line_begin * tex.in_text,
  }),
  s({
    trig = "lcor",
    name = "Corollary Environment with name and lable",
    dscr = "Create a corollary environment with name and lable.",
  }, {
    t { "\\begin{corollary}[" },
    i(1),
    t { "]\\label{cor:" },
    l(l._1:gsub("[^%w]+", "_"):gsub("_$", ""):lower(), 1),
    t { "}", "\t" },
    i(0),
    t { "", "\\end{corollary}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = position.line_begin * tex.in_text,
  }),
  s({
    trig = "lrem",
    name = "Remark Environment with name and lable",
    dscr = "Create a remark environment with name and lable.",
  }, {
    t { "\\begin{remark}[" },
    i(1),
    t { "]\\label{rem:" },
    l(l._1:gsub("[^%w]+", "_"):gsub("_$", ""):lower(), 1),
    t { "}", "\t" },
    i(0),
    t { "", "\\end{remark}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = position.line_begin * tex.in_text,
  }),
  s({
    trig = "lconj",
    name = "Conjecture Environment with name and lable",
    dscr = "Create a conjecture environment with name and lable.",
  }, {
    t { "\\begin{conjecture}[" },
    i(1),
    t { "]\\label{conj:" },
    l(l._1:gsub("[^%w]+", "_"):gsub("_$", ""):lower(), 1),
    t { "}", "\t" },
    i(0),
    t { "", "\\end{conjecture}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = tex.in_text,
  }),

  s(
    { trig = "xym", name = "xymatrix Environment", dscr = "Create a xymatrix environment." },
    { t { "\\[", "\t\\xymatrix{", "\t\t" }, i(1), t { " \\\\", "\t}", "\\]" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = tex.in_text,
    }
  ),
  s(
    { trig = "bal", name = "Align Environment", dscr = "Create an align environment" },
    { t { "\\begin{align}", "\t" }, i(1), t { "", "\\end{align}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = tex.in_text,
    }
  ),
  s(
    { trig = "bsal", name = "Align without a number", dscr = "Create an align environment without number" },
    { t { "\\begin{align*}", "\t" }, i(1), t { "", "\\end{align*}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = tex.in_text,
    }
  ),
  s(
    { trig = "bit", name = "Itemize Environment", dscr = "Create an itemize environment" },
    { t { "\\begin{itemize}", "\t\\item " }, i(1), d(2, rec_ls, {}), t { "", "\\end{itemize}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = tex.in_text,
    }
  ),
  s(
    { trig = "ben", name = "Enumerate Environment" },
    { t { "\\begin{enumerate}", "\t\\item " }, i(1), d(2, rec_ls, {}), t { "", "\\end{enumerate}" } },
    {
      condition = conds_expand.line_begin * tex.in_text,
      show_condition = tex.in_text,
    }
  ),
  s({ trig = "lben", name = "Enumerate with labels" }, {
    t { "\\begin{enumerate}[label=(\\" },
    c(1, {
      t "alph",
      t "roman",
      t "arabic",
    }),
    t { "*)]", "\t\\item " },
    i(2),
    d(3, rec_ls, {}),
    t { "", "\\end{enumerate}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = tex.in_text,
  }),

  s({ trig = "bfu", name = "function" }, {
    t { "\\begin{equation*}", "\t" },
    i(1),
    t "\\colon ",
    i(2),
    t "\\longrightarrow ",
    i(3),
    t ", \\quad ",
    i(4),
    t "\\longmapsto ",
    rep(1),
    t "(",
    rep(4),
    t ") = ",
    i(0),
    t { "", "\\end{equation*}" },
  }, {
    condition = conds_expand.line_begin * tex.in_text,
    show_condition = position.line_begin * tex.in_text,
  }),
}

return snips, autosnips
