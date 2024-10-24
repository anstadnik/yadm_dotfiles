local snips = {
  s({ trig = "ipdb", name = "ipdb breakpoint", desc = "Inserts an ipdb breakpoint" },
    t "import ipdb; ipdb.set_trace()"),
  s({ trig = "ipy", name = "embed ipython", desc = "Inserts an embed ipython breakpoint" },
    t 'from IPython import embed; embed(colors="neutral")'),
}

return snips
