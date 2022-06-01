vim.g.python3_host_prog = '/home/astadnik/.virtualenvs/neovim/bin/python3'

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.termopen(('git clone --depth 1 https://github.com/wbthomason/packer.nvim %q'):format(install_path))
end


require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'

  ---------------------------------------------------------------------------------
  --                                     Git                                     --
  ---------------------------------------------------------------------------------

  use 'tpope/vim-fugitive' -- Git commands in nvim
  use { 'lewis6991/gitsigns.nvim',
    config = [[require 'plugins.gitsigns']] }
  use 'rbong/vim-flog' -- Git log

  -- ---------------------------------------------------------------------------------
  -- --                                     LSP                                     --
  -- ---------------------------------------------------------------------------------
  --
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'f3fora/cmp-spell',
      'quangnguyen30192/cmp-nvim-ultisnips',
      -- 'saadparwaiz1/cmp_luasnip',
      'andersevenrud/cmp-tmux',
      { 'tzachar/cmp-tabnine', run = './install.sh' },
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-document-symbol'
    },
    config = [[require 'plugins.cmp']]
  }
  -- use {
  --   'L3MON4D3/LuaSnip',
  --   config = [[require 'plugins.luasnip']]
  -- }
  use { 'liuchengxu/vista.vim', config = function()
    vim.g.vista_default_executive = 'nvim_lsp'
    vim.keymap.set("n", "<C-g>", ":Vista!!<cr>")
  end }
  -- use 'onsails/lspkind-nvim'
  use 'ray-x/lsp_signature.nvim' -- Lsp signature
  use { "rcarriga/nvim-dap-ui",
    requires = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "rcarriga/cmp-dap",
      "nvim-telescope/telescope-dap.nvim";
    },
    config = [[require 'plugins.dap']]
  }
  use { 'kosayoda/nvim-lightbulb',
    config = [[require('nvim-lightbulb').setup({ autocmd = { enabled = true } })]] }
  use 'nvim-telescope/telescope-ui-select.nvim'
  use { 'mhartington/formatter.nvim',
    config = [[require 'plugins.formatter']] }
  use { 'Saecki/crates.nvim', requires = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' },
    config = function()
      require('null-ls')
      require('crates').setup { null_ls = { enabled = true, }, }
    end
  }

  ---------------------------------------------------------------------------------
  --                                 Treesitter                                  --
  ---------------------------------------------------------------------------------

  use { 'nvim-treesitter/nvim-treesitter',
    config = [[require 'plugins.treesitter']] }
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
  use 'lewis6991/spellsitter.nvim'
  use 'p00f/nvim-ts-rainbow'
  use 'theHamsta/nvim-treesitter-pairs'
  -- Lua
  use { "SmiteshP/nvim-gps", config = [[require("nvim-gps").setup()]] }

  ---------------------------------------------------------------------------------
  --                                 Appearance                                  --
  ---------------------------------------------------------------------------------
  use { "folke/zen-mode.nvim", requires = "folke/twilight.nvim",
    config = [[require 'plugins.zen-mode']] }
  use { 'rmehri01/onenord.nvim', config = [[require 'plugins.onenord']] }
  use { 'lukas-reineke/indent-blankline.nvim',
    config = [[require("indent_blankline").setup { show_current_context = true, show_current_context_start = true }]] }
  use { 'mhinz/vim-startify',
    config = [[require 'plugins.vim-startify']] }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = [[require 'plugins.lualine']]
  }
  use "tversteeg/registers.nvim"
  use { "nanozuki/tabby.nvim",
    config = [[require("tabby").setup({ tabline = require("tabby.presets").tab_only })]] }
  use 'kevinhwang91/nvim-hlslens'
  use { "rcarriga/nvim-notify",
    config = [[require 'plugins.notify']]
  }

  ---------------------------------------------------------------------------------
  --                                Editing misc                                 --
  ---------------------------------------------------------------------------------

  use { 'numToStr/Comment.nvim',
    config = [[require('Comment').setup()]]
  }
  use 'mbbill/undotree'
  use { 'https://gitlab.com/astadnik/snippets.git', rtp = '.' }
  -- Wait for https://github.com/smjonas/snippet-converter.nvim
  use 'SirVer/ultisnips'
  use { 'junegunn/vim-easy-align', config = function()
    vim.keymap.set('x', 'ga', '<plug>(EasyAlign)', {})
    vim.keymap.set('n', 'ga', '<plug>(EasyAlign)', {})
  end }
  use { 'kkoomen/vim-doge', run = ':call doge#install()',
    config = function()
      vim.g.doge_mapping_comment_jump_forward = '<C-l>'
      vim.g.doge_mapping_comment_jump_backward = '<C-h>'
    end
  } -- Documentation
  use 'machakann/vim-sandwich'
  use 'tpope/vim-repeat' -- Repeat
  use { 'windwp/nvim-autopairs', config = [[require('nvim-autopairs').setup({ enable_check_bracket_line = false })]] }

  ---------------------------------------------------------------------------------
  --                                 Navigation                                  --
  ---------------------------------------------------------------------------------

  use 'chaoren/vim-wordmotion' -- Camel case motion
  use 'rhysd/clever-f.vim' -- Better f
  use 'wellle/targets.vim' -- Additional targets
  use { 'folke/trouble.nvim', requires = "kyazdani42/nvim-web-devicons",
    config = [[require("trouble").setup {}]] }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = [[require 'plugins.telescope']]
  } -- UI to select things (files, grep results, open buffers...)
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = [[require 'plugins.nvim-tree']]
  }

  ------------------------------------------------------------------------------
  --                                   Misc                                   --
  ------------------------------------------------------------------------------

  use 'lewis6991/impatient.nvim'

  use { 'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup({ disable_on_zoom = true })
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
      vim.keymap.set('n', "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
      vim.keymap.set('n', "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
      vim.keymap.set('n', "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
    end }
  use 'skywind3000/asyncrun.vim' -- Anynchronously run
  use 'chrisbra/Recover.vim' -- Managing swap
  use 'AndrewRadev/linediff.vim' -- Diff 2 parts of file
  use { 'xeluxee/competitest.nvim', requires = { 'MunifTanjim/nui.nvim' },
    config = [[require 'competitest'.setup({})]] }

  ------------------------------------------------------------------------------
  --                            Language specific                             --
  ------------------------------------------------------------------------------

  use { 'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()' }
  use "folke/lua-dev.nvim"
  use { 'simrat39/rust-tools.nvim', requires = { 'nvim-lua/plenary.nvim' } }

end,
config = {
  display = {
    open_fn = require('packer.util').float,
  } } }
)
