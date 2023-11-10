return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-python",
    },
    ft = { "rust", "python" },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-rust" {
            -- args = { "--no-capture" },
            dap_adapter = "lldb",
          },
          -- require "neotest-rust",
          require "neotest-python" {
            is_test_file = function(file_path)
              return vim.endswith(file_path, ".py")
            end,
          },
        },
      }

      vim.keymap.set("n", "<leader>tt", function()
        vim.api.nvim_command "write"
        require("neotest").run.run()
      end)
      vim.keymap.set("n", "<leader>ts", function()
        vim.api.nvim_command "write"
        require("neotest").run.stop()
      end)
      vim.keymap.set("n", "<leader>tf", function()
        vim.api.nvim_command "write"
        require("neotest").run.run(vim.fn.expand "%")
      end)
      vim.keymap.set("n", "<leader>td", function()
        vim.api.nvim_command "write"
        require("neotest").run.run { strategy = "dap" }
      end)
      vim.keymap.set("n", "<leader>tg", function()
        require("neotest").summary.open()
      end)

      local group = vim.api.nvim_create_augroup("NeotestConfig", {})
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "neotest-output",
        group = group,
        callback = function(opts)
          vim.keymap.set("n", "q", function()
            pcall(vim.api.nvim_win_close, 0, true)
          end, {
            buffer = opts.buf,
          })
        end,
      })
    end,
  },
}
