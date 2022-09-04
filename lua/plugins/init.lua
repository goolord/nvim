vim.cmd.packadd('packer.nvim')
vim.cmd.packadd('cfilter')

local packer = require('packer')

packer.init()

local function packer_use(use)
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
        'RRethy/nvim-base16',
        config = function ()
            require('modules.colors')
        end
    }

    -- completion
    use {
        'hrsh7th/nvim-cmp',
        config = require('plugins.completion'),
        requires = {
            { 'tzachar/cmp-tabnine', run = './install.sh',
                cond = function ()
                    local cdir = vim.fn.getcwd()
                    -- version of glibc or something just makes
                    -- tabnine bootloop
                    local tn_blacklist =
                        { '/Users/zach/Dev/well/Health_Engine/well-he-arbiter'
                        }

                    local no_tabnine = vim.tbl_contains(tn_blacklist, cdir)
                    return not no_tabnine
                end
            },
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-cmdline',
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
    use 'kyazdani42/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        after = 'nvim-base16',
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
        }
    }

    use {
        "AckslD/nvim-neoclip.lua",
        config = function() require('neoclip').setup() end,
    }

    use {
        "~/Dev/alpha-nvim",
        requires = { 'kyazdani42/nvim-web-devicons' }, -- '~/Dev/gamma-ui-nvim' },
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
        ft = { 'haskell', 'rust', 'lua', 'purescript' }
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

    use {
        'whonore/Coqtail',
        ft = 'coq',
        config = function ()
            vim.g.python3_host_prog = '/usr/bin/python3'
            vim.opt.pyxversion = 3
        end
    }

    use {
        'ndmitchell/ghcid',
        rtp = 'plugins/nvim',
        cmd = { 'Ghcid', 'GhcidKill' },
    }

    use {
        'purescript-contrib/purescript-vim'
    }

    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     run = ':TSUpdate',
    -- }
end

packer.startup(packer_use)

vim.api.nvim_create_autocmd("User", {
    pattern = "PackerCompileDone",
    callback = function() vim.fn.system({'/usr/bin/env', 'luajit', '-bg', packer.config.compile_path, packer.config.compile_path}) end,
})

return packer
