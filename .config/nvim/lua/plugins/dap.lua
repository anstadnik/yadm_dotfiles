return {
  {
    "mfussenegger/nvim-dap",
    ft = { "python", "rust" },
    dependencies = {
      -- "rcarriga/cmp-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "rouge8/neotest-rust",

      "nvim-treesitter/nvim-treesitter",
    },
    config = require "plugins.configs.dap",
  },
}
