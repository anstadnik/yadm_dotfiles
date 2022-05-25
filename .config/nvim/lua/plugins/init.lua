vim.g.python3_host_prog = '/home/astadnik/.virtualenvs/neovim/bin/python3'

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local use = require('packer').use
require('packer').startup({ function()
  use 'wbthomason/packer.nvim' -- Package manager

  ---------------------------------------------------------------------------------
  --                                     Git                                     --
  ---------------------------------------------------------------------------------

  use 'tpope/vim-fugitive' -- Git commands in nvim
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require 'plugins.configs.gitsigns' end }
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
      'andersevenrud/cmp-tmux',
      { 'tzachar/cmp-tabnine', run = './install.sh' },
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-document-symbol'
    }
  } -- Autocompletion plugin
  use 'liuchengxu/vista.vim'
  use 'onsails/lspkind-nvim' -- Icons
  use 'ray-x/lsp_signature.nvim' -- Lsp signature
  use { "rcarriga/nvim-dap-ui",
    requires = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "rcarriga/cmp-dap",
      "nvim-telescope/telescope-dap.nvim";
    },
    config = function()
      require 'plugins.configs.dap'
    end
  }
  use 'nvim-telescope/telescope-ui-select.nvim'
  use { 'mhartington/formatter.nvim',
    config = function() require 'plugins.configs.formatter' end }
  use { 'simrat39/rust-tools.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'Saecki/crates.nvim', requires = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' } }

  ---------------------------------------------------------------------------------
  --                                 Treesitter                                  --
  ---------------------------------------------------------------------------------

  use { 'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'plugins.configs.treesitter'
    end }
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
  use 'lewis6991/nvim-treesitter-context'
  use 'lewis6991/spellsitter.nvim'
  use 'p00f/nvim-ts-rainbow' -- Rainbow parentheses
  use 'theHamsta/nvim-treesitter-pairs'

  ---------------------------------------------------------------------------------
  --                                 Appearance                                  --
  ---------------------------------------------------------------------------------
  use { "folke/zen-mode.nvim", requires = "folke/twilight.nvim",
    config = function() require 'plugins.configs.zen-mode' end }
  use { 'rmehri01/onenord.nvim', config = function() require 'plugins.configs.onenord' end }
  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup { show_current_context = true, show_current_context_start = true }
    end }
  use { 'mhinz/vim-startify',
    config = function() require 'plugins.configs.vim-startify' end }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require 'plugins.configs.lualine' end
  }
  use "tversteeg/registers.nvim"
  -- use { "nanozuki/tabby.nvim",
  --   after = 'rmehri01/onenord.nvim',
  --   config = function()
  --     require("tabby").setup({ tabline = require("tabby.presets").tab_only })
  --   end }
  use 'kevinhwang91/nvim-hlslens'
  use { "rcarriga/nvim-notify",
    config = function()
      require 'plugins.configs.notify'
    end }

  ---------------------------------------------------------------------------------
  --                                Editing misc                                 --
  ---------------------------------------------------------------------------------

  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end }
  use 'mbbill/undotree'
  use { 'https://gitlab.com/astadnik/snippets.git', rtp = '.' }
  use 'SirVer/ultisnips'
  use 'junegunn/vim-easy-align' -- Aligning
  use { 'kkoomen/vim-doge', run = ':call doge#install()',
    config = function()
      vim.g.doge_mapping_comment_jump_forward = '<C-l>'
      vim.g.doge_mapping_comment_jump_backward = '<C-h>'
    end } -- Documentation
  use { 'machakann/vim-sandwich',
    config = function()
      local map = vim.api.nvim_set_keymap
      vim.g.textobj_sandwich_no_default_key_mappings = 1
      map('n', 's', '<Nop>', {})
      map('x', 's', '<Nop>', {})
      map('x', 'ga', '<plug>(EasyAlign)', {})
      map('n', 'ga', '<plug>(EasyAlign)', {})

    end }
  use 'tpope/vim-repeat' -- Repeat
  use 'windwp/nvim-autopairs' -- Autopairs

  ---------------------------------------------------------------------------------
  --                                 Navigation                                  --
  ---------------------------------------------------------------------------------

  use 'chaoren/vim-wordmotion' -- Camel case motion
  use 'rhysd/clever-f.vim' -- Better f
  use 'wellle/targets.vim' -- Additional targets
  use { 'folke/trouble.nvim', requires = "kyazdani42/nvim-web-devicons" }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      require 'plugins.configs.telescope'
    end
  } -- UI to select things (files, grep results, open buffers...)
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require 'plugins.configs.nvim-tree' end
  }

  ------------------------------------------------------------------------------
  --                                   Misc                                   --
  ------------------------------------------------------------------------------

  use { 'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup({ disable_on_zoom = true })
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map('n', "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
      map('n', "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
      map('n', "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
      map('n', "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
    end } -- Seamless navigation with tmux
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  use 'skywind3000/asyncrun.vim' -- Anynchronously run
  use 'chrisbra/Recover.vim' -- Managing swap
  use 'AndrewRadev/linediff.vim' -- Diff 2 parts of file
  use { 'xeluxee/competitest.nvim', requires = { 'MunifTanjim/nui.nvim' },
    config = function()
      require 'competitest'.setup({})
    end }

  ------------------------------------------------------------------------------
  --                            Language specific                             --
  ------------------------------------------------------------------------------

  use { 'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()' }
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  } } }
)
