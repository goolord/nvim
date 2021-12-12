vim.cmd('packadd packer.nvim')
vim.cmd('packadd cfilter')

local packer = require('packer')

packer.init()

local function packer_use()
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
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = require('plugins.statusline')
    }

    use {
        'Shatur/neovim-session-manager',
        config = function ()
            require('session_manager').setup {
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
                autosave_last_session = true,
            }
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
        "AckslD/nvim-neoclip.lua",
        config = function()
            require('neoclip').setup()
        end,
    }

    use {
        'pechorin/any-jump.vim',
        config = function ()
            vim.g.any_jump_grouping_enabled = 1
        end,
    }

    use {
        "~/Dev/alpha-nvim",
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require'plugins.alpha'
    }

    -- use {
    --     "glepnir/dashboard-nvim"
    -- }

    use {
        'folke/which-key.nvim',
        config = require('plugins.which-key')
    }

    -- use {
    --     "~/Dev/sentinel-nvim",
    --     requires = {
    --         'nvim-lua/plenary.nvim',
    --         'kyazdani42/nvim-web-devicons',
    --     },
    --     config = function () require'sentinel'.setup() end
    -- }

    -- git
    use 'tpope/vim-fugitive'

    -- colorsceme
    use {
        'lifepillar/vim-gruvbox8',
        config = require('plugins.gruvbox')
    }

    -- nvim-lsp
    use {
        'simrat39/rust-tools.nvim',
        ft = 'rust'
    }

    use {
        'neovim/nvim-lspconfig',
        config = require('modules.lsp'),
        after = 'rust-tools.nvim',
        ft = { 'haskell', 'rust', 'lua', 'lean' }
    }

    use {
        'folke/trouble.nvim',
        config = require('plugins.trouble'),
    }

    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     config = require('plugins.treesitter'),
    --     run = ':TSUpdate',
    -- }

    -- filetype plugins
    use { 'LnL7/vim-nix', ft = 'nix' }
    use { 'edwinb/idris2-vim', ft = 'idris' }
    use { 'cespare/vim-toml', ft = 'toml' }

    use { 'whonore/Coqtail', ft = 'coq' }
    use {
        'Julian/lean.nvim',
        requires = 'nvim-lua/plenary.nvim',
        ft = 'lean'
    }

    use {
        'ndmitchell/ghcid',
        rtp = 'plugins/nvim',
        cmd = { 'Ghcid', 'GhcidKill' },
    }
end

packer.startup(packer_use)

vim.cmd(string.format([[
autocmd User PackerCompileDone call system(['/usr/bin/luajit', '-bg', '%s', '%s'])
]], packer.config.compile_path, packer.config.compile_path))

return packer
