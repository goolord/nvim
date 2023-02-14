vim.cmd.packadd('packer.nvim')
vim.cmd.packadd('cfilter')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
    { 'lewis6991/impatient.nvim', rocks = 'mpack' };

    { 'godlygeek/tabular' };
    {
        'terrortylor/nvim-comment',
        config = function () require('nvim_comment').setup() end
    };
    { 'akinsho/toggleterm.nvim', config = require('plugins.toggleterm') };
    { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } };
    { 'tpope/vim-abolish' };
    -- colorscheme
    {
        'RRethy/nvim-base16',
        config = function ()
            require('modules.colors')
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        lazy = false,
        priority = 1000,
    };

    -- completion
    {
        'hrsh7th/nvim-cmp',
        config = require('plugins.completion'),
        dependencies = {
            { 'tzachar/cmp-tabnine', build = './install.sh',
                cond = function ()
                    local cdir = vim.fn.getcwd()
                    -- version of glibc or something just makes
                    -- tabnine bootloop
                    local tn_blacklist =
                        { '/Users/zach/Dev/well/Health_Engine/well%-he%-arbiter.*'
                        }

                    local no_tabnine = vim.tbl_filter(function(dir) return string.match(cdir, dir) ~= nil end, tn_blacklist)
                    return vim.tbl_isempty(no_tabnine)
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
                dependencies = 'hrsh7th/vim-vsnip-integ',
                config = require('plugins.snippets')
            }
        }
    };
    -- gui
    { 'nvim-tree/nvim-web-devicons' };
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            require("indent_blankline").setup {
                show_end_of_line = true,
                show_current_context = true,
                show_first_indent_level = false,
                show_trailing_blankline_indent = false,
                char = '▏',
            }
        end
    };
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'RRethy/nvim-base16',
            'nvim-tree/nvim-web-devicons'
        },
        config = function ()
            require('plugins.statusline')()
        end
    };

    {
        'nvim-tree/nvim-tree.lua',
        commit = "8b8d457e07d279976a9baac6bbff5aa036afdc5f",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function () require('plugins.nvim-tree')() end,
    };

    {
        'Shatur/neovim-session-manager',
        config = function ()
            require('session_manager').setup {
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
                autosave_last_session = true,
            }
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
        }
    };

    {
        'nvim-telescope/telescope.nvim',
        config = require('plugins.telescope'),
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- extensions
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { "AckslD/nvim-neoclip.lua" },
        }
    };

    {
        "AckslD/nvim-neoclip.lua",
        config = function() require('neoclip').setup() end,
    };

    {
        dir = "~/Dev/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' }, -- '~/Dev/gamma-ui-nvim' },
        config = require('plugins.alpha')
    };

    {
        'folke/which-key.nvim',
        config = function() require("which-key").setup() end
    };

    { 'tpope/vim-fugitive' };

    -- nvim-lsp

    {
        'neovim/nvim-lspconfig',
        config = require('modules.lsp'),
        ft = { 'haskell', 'rust', 'lua', 'purescript', 'elm' }
    };

    {
        'j-hui/fidget.nvim',
        config = function () require('fidget').setup {
            text = { spinner = 'moon' },
        } end
    };

    {
        'folke/trouble.nvim',
        config = require('plugins.trouble'),
    };

    {
        'folke/todo-comments.nvim',
        config = function ()
            require("todo-comments").setup {
            }
        end,
    };

    -- filetype plugins
    { 'LnL7/vim-nix', ft = 'nix' };
    { 'edwinb/idris2-vim', ft = 'idris2' };

    {
        'whonore/Coqtail',
        ft = 'coq',
        config = function ()
            vim.g.python3_host_prog = '/usr/bin/python3'
            vim.opt.pyxversion = 3
        end
    };

    {
        'ndmitchell/ghcid',
        rtp = 'plugins/nvim',
        cmd = { 'Ghcid', 'GhcidKill' },
    };

    {
        'purescript-contrib/purescript-vim'
    };

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function ()
            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = true,
                    disable = { "haskell" }
                },
                textobjects = { enable = true },
                incremental_selection = { enable = true, keymaps = { init_selection = '<CR>', scope_incremental = '<CR>', node_incremental = '<TAB>', node_decremental = '<S-TAB>', }, },
            }
        end
    };

}, {
  -- defaults = { lazy = true },
  dev = { path = "~/Dev" },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false },
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
  },
})

require('plugins.tabline')
