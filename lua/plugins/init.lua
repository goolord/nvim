vim.cmd('packadd packer.nvim')
vim.cmd('packadd cfilter')

local packer = require('packer')

packer.init()

packer.startup(function()
    use { 'lewis6991/impatient.nvim', rocks = 'mpack' }

    use { 'wbthomason/packer.nvim', opt = true }

    use 'godlygeek/tabular'
    use { 'terrortylor/nvim-comment', config = require('plugins.nvim-comment') }
    use { 'akinsho/toggleterm.nvim', config = require('plugins.toggleterm') }
    use { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } }

    -- completion
    use {
        'hrsh7th/nvim-cmp',
        config = require('plugins.completion'),
        requires = {
            { 'tzachar/cmp-tabnine', run = './install.sh' },
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-vsnip',
            'onsails/lspkind-nvim',
            {
                'hrsh7th/vim-vsnip',
                requires = 'hrsh7th/vim-vsnip-integ',
                config = require('plugins.snippets')
            }
        }
    }
    -- gui
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = require('plugins.indent-blankline'),
        branch = 'develop'
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require('plugins.nvim-tree')
    }

    use {
        'shadmansaleh/lualine.nvim', -- this is a fork, most up to date atm
        -- 'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = require('plugins.statusline')
    }

    use {
        'Shatur/neovim-session-manager',
        config = function ()
            vim.g.autoload_last_session = false
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = require('plugins.telescope'),
        requires = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
        }
    }

    use {
        "~/Dev/alpha-nvim",
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require'plugins.alpha'
    }

    -- git
    use 'tpope/vim-fugitive'

    -- colorsceme
    use {
        'lifepillar/vim-gruvbox8',
        config = require('plugins.gruvbox')
    }

    -- nvim-lsp
    use {
        'neovim/nvim-lspconfig',
        config = require('modules.lsp'),
        after = 'rust-tools.nvim',
        ft = { 'haskell', 'rust', 'lua' }
    }

    use {
        'folke/trouble.nvim',
        config = require('plugins.trouble'),
    }

    use 'simrat39/rust-tools.nvim'

    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     config = require('plugins.treesitter'),
    --     run = ':TSUpdate',
    -- }

    -- filetype plugins
    use 'LnL7/vim-nix'
    use 'edwinb/idris2-vim'
    use 'cespare/vim-toml'

    use { 'whonore/Coqtail', ft = 'coq' }

    use {
        'ndmitchell/ghcid',
        rtp = 'plugins/nvim',
        cmd = { 'Ghcid', 'GhcidKill' },
    }

end)

return packer
