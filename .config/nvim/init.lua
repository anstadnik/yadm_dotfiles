vim.g.python3_host_prog = '/home/astadnik/.virtualenvs/neovim/bin/python3'

require '_mappings'
require '_parameters'

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
            'quangnguyen30192/cmp-nvim-ultisnips',
            {'andersevenrud/compe-tmux', branch = 'cmp'}, -- Autocompletion from tmux
            {'tzachar/cmp-tabnine', run = './install.sh'},
            {'hrsh7th/cmp-cmdline'}
        }
    } -- Autocompletion plugin
    use 'liuchengxu/vista.vim'
    use 'onsails/lspkind-nvim' -- Icons
    use 'ray-x/lsp_signature.nvim' -- Lsp signature
    use 'tami5/lspsaga.nvim' -- Lsp signature
    use {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use 'nvim-telescope/telescope-dap.nvim';
    use 'theHamsta/nvim-dap-virtual-text'
    use 'mhartington/formatter.nvim' -- Format python

    ---------------------------------------------------------------------------------
    --                                 Treesitter                                  --
    ---------------------------------------------------------------------------------

    use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
		-- use 'romgrk/nvim-treesitter-context'
    use 'p00f/nvim-ts-rainbow' -- Rainbow parentheses

    ---------------------------------------------------------------------------------
    --                                 Appearance                                  --
    ---------------------------------------------------------------------------------

    -- use 'joshdick/onedark.vim' -- Theme inspired by Atom
    -- use 'navarasu/onedark.nvim' -- Theme inspired by Atom
    use 'ful1e5/onedark.nvim'
    -- use 'projekt0n/github-nvim-theme'
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'mhinz/vim-startify' -- Starting screen
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    -- use 'junegunn/vim-peekaboo' -- Register
    use "tversteeg/registers.nvim"
    --[[ use {
'akinsho/nvim-bufferline.lua',
requires = 'kyazdani42/nvim-web-devicons'
	} ]]
    use {
        'alvarosevilla95/luatab.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- use 'haringsrob/nvim_context_vt'
    use {'kevinhwang91/nvim-hlslens'}

    ---------------------------------------------------------------------------------
    --                                Editing misc                                 --
    ---------------------------------------------------------------------------------

    -- use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
    use 'b3nj5m1n/kommentary'
    use {'https://gitlab.com/astadnik/snippets.git', rtp = '.'}
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

    ------------------------------------------------------------------------------
    --                            Language specific                             --
    ------------------------------------------------------------------------------

    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
    --[[ use {'lervag/vimtex',				   ft = 'tex',
requires= {
'nvim-treesitter/playground',				   ft = 'tex',
config = function () require("nvim-treesitter.configs").setup{
playground = {
enable = true
}
} end
}
	} ]]
    -- use {'mhinz/neovim-remote',			   ft= 'tex' }
end)

require '_lsp' -- LSP settings
require '_dap' -- LSP settings
require '_tex' -- LSP settings
require '_treesitter' -- Treesitter
require '_misc' -- Miscellaneous
require '_plugins' -- Miscellaneous
