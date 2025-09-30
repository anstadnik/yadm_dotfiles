return {
  "machakann/vim-sandwich",
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set({ "n", "v" }, "ga", "<Plug>(EasyAlign)")
    end,
  },
  "chaoren/vim-wordmotion",
  "rhysd/clever-f.vim",
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  -- {
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("todo-comments").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end,
  -- },
  -- {
  --   "danymat/neogen",
  --   keys = { "<Leader>d" },
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = function()
  --     require("neogen").setup { snippet_engine = "luasnip" }
  --     local opts = { noremap = true, silent = true }
  --     vim.api.nvim_set_keymap("n", "<Leader>d", ":lua require('neogen').generate()<CR>", opts) -- Uncomment next line if you want to follow only stable versions
  --   end,
  --   -- version = "*"
  -- },
  -- {
  --   "stevearc/profile.nvim",
  --   config = function()
  --     local should_profile = os.getenv "NVIM_PROFILE"
  --     if should_profile then
  --       require("profile").instrument_autocmds()
  --       if should_profile:lower():match "^start" then
  --         require("profile").start "*"
  --       else
  --         require("profile").instrument "*"
  --       end
  --     end
  --
  --     local function toggle_profile()
  --       local prof = require "profile"
  --       if prof.is_recording() then
  --         prof.stop()
  --         vim.ui.input(
  --           { prompt = "Save profile to:", completion = "file", default = "profile.json" },
  --           function(filename)
  --             if filename then
  --               prof.export(filename)
  --               vim.notify(string.format("Wrote %s", filename))
  --             end
  --           end
  --         )
  --       else
  --         prof.start "*"
  --       end
  --     end
  --     vim.keymap.set("", "<f1>", toggle_profile)
  --   end,
  -- },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    build = "make tiktoken",        -- Only on MacOS or Linux
    keys = {
      {
        "<leader>d",
        function()
          require("CopilotChat").ask(
            "/COPILOT_INSTRUCTIONS Add or fix (if necessary) documentation comment for the selection, use google style. Add or fix (if necessary) module-level documentation, and documentation for classes, function and modules which lack it. Lines should be no longer than 120 characters. 1 blank line required between summary line and description. The summary line has to be on the same line with the opening quotes, and has to be a single line line. Do not output line numbers, nor make additional offsets. Output the whole selection with comments added. Use imperative mood. Don't use python code block",
            { selection = require("CopilotChat.select").buffer })
        end,
        desc = "CopilotChat - Quick chat",
      },
      -- {
      --   "<leader>F",
      --   function()
      --     local chat = require("CopilotChat")
      --     local buffers = vim.api.nvim_list_bufs() -- Get a list of all open buffers
      --
      --     vim.notify("Starting documentation generation for all open buffers", vim.log.levels.DEBUG)
      --
      --     -- Recursive function to process buffers sequentially
      --     local function process_buffer(index)
      --       if index > #buffers then
      --         vim.notify("Finished processing all open buffers", vim.log.levels.DEBUG)
      --         return
      --       end
      --
      --       local bufnr = buffers[index]
      --
      --       -- Check if the buffer is loaded and not a special buffer
      --       if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_get_option_value("modifiable", { buf = bufnr }) then
      --         -- Switch to the buffer
      --         vim.api.nvim_set_current_buf(bufnr)
      --
      --         vim.notify(string.format("Processing buffer %d", bufnr), vim.log.levels.DEBUG)
      --
      --         chat.ask(
      --           "/COPILOT_INSTRUCTIONS Add or fix (if necessary) documentation comment for the selection, use google style. Add or fix (if necessary) module-level documentation, and documentation for classes, function and modules which lack it. Lines should be no longer than 120 characters. 1 blank line required between summary line and description. The summary line has to be on the same line with the opening quotes, and has to be a single line line. Do not output line numbers, nor make additional offsets. Output the whole selection with comments added. Do not output the header with file name and lines. Use imperative mood. Don't use python code block",
      --           {
      --             clear_chat_on_new_prompt = true,
      --             -- context = string.format("buffer:${%d}", bufnr),
      --             selection = require("CopilotChat.select").buffer,
      --             headless = true,
      --             callback = function(response)
      --               vim.notify(string.format("Received response for buffer %d", bufnr), vim.log.levels.DEBUG)
      --
      --               -- Replace the buffer content with the response
      --               vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(response, "\n"))
      --
      --               vim.notify(string.format("Buffer %d content updated with response", bufnr), vim.log.levels.DEBUG)
      --
      --               -- Process the next buffer
      --               process_buffer(index + 1)
      --             end,
      --           }
      --         )
      --       else
      --         vim.notify(string.format("Skipping buffer %d: not loaded or not modifiable", bufnr), vim.log.levels.DEBUG)
      --         -- Move to the next buffer if the current one is not loaded or not modifiable
      --         process_buffer(index + 1)
      --       end
      --     end
      --
      --     -- Start processing from the first buffer
      --     process_buffer(1)
      --   end,
      -- },
      {
        "<leader>p",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "CopilotChat - Quick chat",
        mode = { 'n', 'x' }
      },
      -- {
      --   "<leader>P",
      --   function()
      --     local input = vim.fn.input("Quick Chat: ")
      --     if input ~= "" then
      --       require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      --     end
      --   end,
      --   desc = "CopilotChat - Quick chat",
      --   mode = { 'n', 'x' }
      -- },
      {
        "<leader><leader>",
        function()
          require("CopilotChat").toggle()
        end,
        mode = { 'n', 'x' }
      }
    },

    opts = {
    --   context = "buffers"
    --   --   debug = true, -- Enable debugging
    --   --   -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "junegunn/vim-easy-align",
    --     " Start interactive EasyAlign in visual mode (e.g. vipga)
    -- xmap ga <Plug>(EasyAlign)
    --
    -- " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    -- nmap ga <Plug>(EasyAlign)
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "v" } },
    },

  }
}
