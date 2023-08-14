return {
  {
    "mfussenegger/nvim-dap",
    ft = { "python", "rust" },
    dependencies = {
      -- "rcarriga/cmp-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
    config = require "plugins.configs.dap",
  },
}
