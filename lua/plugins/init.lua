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

local colorscheme =
{
    'RRethy/nvim-base16',
    config = function()
        require('modules.colors')
        vim.cmd.colors('base16-tomorrow-min')
    end,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    priority = 1000,
}

require("lazy").setup({
    { 'lewis6991/impatient.nvim', rocks = 'mpack' },

    { 'godlygeek/tabular' },
    { 'akinsho/toggleterm.nvim',  config = require('plugins.toggleterm') },
    { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } },
    { 'tpope/vim-abolish' },
    {
        'smjonas/live-command.nvim',
        config = function()
            require("live-command").setup {
                commands = {
                    S = { cmd = "Subvert" }, -- must be defined before we import vim-abolish
                },
            }
        end
    },
    colorscheme,

    {
        'goolord/nvim-colorscheme-convert',
        dev = true,
    },

    -- completion
    {
        'Saghen/blink.cmp',
        version = '*',
        opts = {
            keymap = {
                preset = 'default',

                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<Up>'] = {},
                ['<Down>'] = {},
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            completion = {
                list = { selection = { preselect = false } },
            },
            sources = {
                default = { 'buffer', 'lsp', 'path', 'snippets'},
                providers = { lsp = { fallbacks = {} } },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
        dependencies = {
            colorscheme[1],
            'rafamadriz/friendly-snippets',
            require('plugins.snippets'),
        }
    },
    -- gui
    { 'nvim-tree/nvim-web-devicons' },
    { 'echasnovski/mini.icons' },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("ibl").setup {
                scope = { show_end = false, show_start = false },
                indent = { char = '▏' },
            }
            local hooks = require "ibl.hooks"
            hooks.register(
                hooks.type.WHITESPACE,
                hooks.builtin.hide_first_space_indent_level
            )
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            colorscheme[1],
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('plugins.statusline')()
        end
    },

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('plugins.nvim-tree')() end,
    },

    {
        'Shatur/neovim-session-manager',
        config = function()
            require('session_manager').setup {
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
                autosave_last_session = true,
            }
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
        }
    },

    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        --@type snacks.Config
        opts = {
            picker = {
                enabled = true,
                layout = {
                    layout = {
                        width = 0.9,
                        height = 0.9,
                    },
                },
            },
            input = { enabled = true },
        }
    },

    {
        "gbprod/yanky.nvim",
        opts = {
        },
    },

    {
        "aznhe21/actions-preview.nvim",
    },

    {
        "AckslD/nvim-neoclip.lua",
        config = function() require('neoclip').setup() end,
    },

    {
        'goolord/alpha-nvim',
        dev = true,
        dependencies = { 'echasnovski/mini.icons' },
        config = require('plugins.alpha')
    },

    {
        'folke/which-key.nvim',
        dependencies = { 'echasnovski/mini.icons' },
        config = function() require("which-key").setup() end
    },

    { 'tpope/vim-fugitive' },

    -- nvim-lsp

    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        config = require('modules.lsp'),
        ft = { 'haskell', 'rust', 'lua', 'purescript', 'elm', 'css', 'scss', 'sass', 'less', 'typescript' }
    },

    {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup {
                text = { spinner = 'moon' },
            }
        end,
        branch = 'legacy'
    },

    {
        'folke/trouble.nvim',
        config = require('plugins.trouble'),
    },

    {
        'folke/todo-comments.nvim',
        config = function()
            require("todo-comments").setup {
            }
        end,
    },

    -- filetype plugins
    { 'LnL7/vim-nix',      ft = 'nix' },
    { 'edwinb/idris2-vim', ft = 'idris2' },

    {
        'whonore/Coqtail',
        ft = 'coq',
        config = function()
            vim.g.python3_host_prog = '/usr/bin/python3'
            vim.opt.pyxversion = 3
        end
    },

    {
        'ndmitchell/ghcid',
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/plugins/nvim/")
        end,
        lazy = false,
        cmd = { 'Ghcid', 'GhcidKill' },
    },

    {
        'jecaro/ghcid-error-file.nvim'
    },

    {
        'purescript-contrib/purescript-vim'
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = true,
                    disable = { "haskell" }
                },
                textobjects = { enable = true },
                incremental_selection = { enable = true,
                    keymaps = { init_selection = '<CR>', scope_incremental = '<CR>', node_incremental = '<TAB>',
                        node_decremental = '<S-TAB>', }, },
            }
        end
    },

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
        disabled_plugins = {
            "gzip",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
            "fzf",
            "vimball",
            "spellfile",
            "getscript",
            "rrhelper",
        },
    },
})

require('plugins.tabline')
