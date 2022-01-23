vim.g.python3_host_prog = '/home/astadnik/.virtualenvs/neovim/bin/python3'

-- Install packer
local install_path = vim.fn.stdpath 'data' ..
                         '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                       install_path)
end

vim.api.nvim_exec([[
augroup Packer
autocmd!
autocmd BufWritePost init.lua PackerCompile
augroup end
	]], false)

-- Fix https://github.com/ray-x/lsp_signature.nvim/issues/143
local old_make_floating = vim.lsp.util.make_floating_popup_options
if not old_make_floating(0, 0, {}).noautocmd then
    vim.lsp.util.make_floating_popup_options =
        function(width, height, opts)
            local ret = old_make_floating(width, height, opts)
            ret.noautocmd = true
            return ret
        end
end

local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager

    ---------------------------------------------------------------------------------
    --                                     Git                                     --
    ---------------------------------------------------------------------------------

    use 'tpope/vim-fugitive' -- Git commands in nvim
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}} -- Add git related info in the signs columns and popups
    use 'rbong/vim-flog' -- Git log

    ---------------------------------------------------------------------------------
    --                                     LSP                                     --
    ---------------------------------------------------------------------------------

    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'f3fora/cmp-spell',
            'quangnguyen30192/cmp-nvim-ultisnips', 'andersevenrud/cmp-tmux', -- Autocompletion from tmux
            {'tzachar/cmp-tabnine', run = './install.sh'}, 'hrsh7th/cmp-cmdline'
        }
    } -- Autocompletion plugin
    use 'liuchengxu/vista.vim'
    use 'onsails/lspkind-nvim' -- Icons
    use 'ray-x/lsp_signature.nvim' -- Lsp signature
    --[[ use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use 'nvim-telescope/telescope-dap.nvim';
    use 'theHamsta/nvim-dap-virtual-text' ]]
    use 'mhartington/formatter.nvim' -- Format python
    use {'simrat39/rust-tools.nvim', requires = {'nvim-lua/plenary.nvim'}}

    ---------------------------------------------------------------------------------
    --                                 Treesitter                                  --
    ---------------------------------------------------------------------------------

    use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
    use 'romgrk/nvim-treesitter-context'
    use 'p00f/nvim-ts-rainbow' -- Rainbow parentheses
    use 'theHamsta/nvim-treesitter-pairs'

    ---------------------------------------------------------------------------------
    --                                 Appearance                                  --
    ---------------------------------------------------------------------------------

    use 'shaunsingh/nord.nvim'
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'mhinz/vim-startify' -- Starting screen
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use "tversteeg/registers.nvim"
    use "nanozuki/tabby.nvim"

    use {'kevinhwang91/nvim-hlslens'}

    ---------------------------------------------------------------------------------
    --                                Editing misc                                 --
    ---------------------------------------------------------------------------------

    -- use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
    use 'b3nj5m1n/kommentary'
    use 'mbbill/undotree'
    use 'https://gitlab.com/astadnik/snippets.git'
    use 'SirVer/ultisnips'
    -- Snippets plugin
    use 'junegunn/vim-easy-align' -- Aligning
    use {'kkoomen/vim-doge', run = ':call doge#install()'} -- Documentation
    use 'machakann/vim-sandwich' -- Parenthesis and stuff
    use 'tpope/vim-repeat' -- Repeat
    use 'windwp/nvim-autopairs' -- Autopairs

    ---------------------------------------------------------------------------------
    --                                 Navigation                                  --
    ---------------------------------------------------------------------------------

    use 'chaoren/vim-wordmotion' -- Camel case motion
    use 'rhysd/clever-f.vim' -- Better f
    use 'wellle/targets.vim' -- Additional targets
    use {'folke/trouble.nvim', requires = "kyazdani42/nvim-web-devicons"}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    } -- UI to select things (files, grep results, open buffers...)
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    ------------------------------------------------------------------------------
    --                                   Misc                                   --
    ------------------------------------------------------------------------------

    use 'numToStr/Navigator.nvim' -- Seamless navigation with tmux
    -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
    use 'skywind3000/asyncrun.vim' -- Anynchronously run
    use 'jpalardy/vim-slime'
    use 'chrisbra/Recover.vim' -- Managing swap
    -- use 'rhysd/vim-grammarous' -- Check grammar
    use 'AndrewRadev/linediff.vim' -- Diff 2 parts of file
    -- tracking
    -- use 'ActivityWatch/aw-watcher-vim'

    ------------------------------------------------------------------------------
    --                            Language specific                             --
    ------------------------------------------------------------------------------

    use {'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()'}
end)

require '_mappings'
require '_parameters'

local ok, _ = pcall(require, 'lspconfig')
if ok then
    require '_lsp' -- LSP settings
    -- require '_dap' -- LSP settings
    require '_tex' -- LSP settings
    require '_treesitter' -- Treesitter
    require '_misc' -- Miscellaneous
    require '_plugins' -- Miscellaneous
end
