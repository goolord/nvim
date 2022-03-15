vim.cmd('packadd packer.nvim')
vim.cmd('packadd cfilter')

local packer = require('packer')

packer.init()

local function packer_use()
    use { 'lewis6991/impatient.nvim', rocks = 'mpack' }

    use { 'wbthomason/packer.nvim', opt = true }

    use 'godlygeek/tabular'
    use {
        'terrortylor/nvim-comment',
        config = function () require('nvim_comment').setup() end
    }
    use { 'akinsho/toggleterm.nvim', config = require('plugins.toggleterm') }
    use { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } }
    use 'tpope/vim-abolish'

    -- colorscheme
    use {
        'lifepillar/vim-gruvbox8',
        config = require('plugins.gruvbox')
    }

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
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        after = 'vim-gruvbox8',
        config = require('plugins.statusline')
    }

    require('plugins.tabline')

    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require('plugins.nvim-tree')
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
            -- extensions
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'psiska/telescope-hoogle.nvim' }
        }
    }

    use {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require('neoclip').setup()
        end,
    }

    use {
        "~/Dev/alpha-nvim",
        requires = { 'kyazdani42/nvim-web-devicons', '~/Dev/gamma-ui-nvim' },
        config = require('plugins.alpha')
    }

    use {
        'folke/which-key.nvim',
        config = function () require("which-key").setup() end
    }

    use 'tpope/vim-fugitive'

    -- nvim-lsp

    use {
        'neovim/nvim-lspconfig',
        config = require('modules.lsp'),
        ft = { 'haskell', 'rust', 'lua', 'lean' }
    }

    use {
        'j-hui/fidget.nvim',
        config = function () require('fidget').setup {
            text = { spinner = 'moon' },
        } end
    }

    use {
        'folke/trouble.nvim',
        config = require('plugins.trouble'),
    }

    -- filetype plugins
    use { 'LnL7/vim-nix', ft = 'nix' }
    use { 'edwinb/idris2-vim', ft = 'idris2' }

    use { 'whonore/Coqtail', ft = 'coq' }
    use {
        'Julian/lean.nvim',
        requires = 'nvim-lua/plenary.nvim',
        ft = 'lean'
    }

    use {
        'fsharp/vim-fsharp',
        run = 'make fsautocomplete',
        ft = 'fsharp'
    }

    use {
        '~/Dev/ghcid/plugins/nvim',
        -- rtp = 'plugins/nvim',
        cmd = { 'Ghcid', 'GhcidKill' },
    }
end

packer.startup(packer_use)


vim.api.nvim_create_autocmd("User", {
    pattern = "PackerCompileDone",
    callback = function() vim.fn.system({'/usr/bin/luajit', '-bg', packer.config.compile_path, packer.config.compile_path}) end,
})

return packer
