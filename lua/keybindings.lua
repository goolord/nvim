local wk = require("which-key")

local keymap = vim.api.nvim_set_keymap

-- ('mode', 'keybindings', 'command', '{noremap=bool', 'silent=bool', expr=bool})
keymap('', '<Space>', '<Leader>', {silent = true} )
-- disable keys
keymap('' , '<MiddleMouse>', '<Nop>', {silent = true, nowait = true} )
keymap('i', '<MiddleMouse>', '<Nop>', {silent = true, nowait = true} )
-- terminal mode
keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

local function clap(provider) return '<CMD>Clap ' .. provider .. '<CR>' end

local function tabularize(regex) return ':Tabularize ' .. regex end

wk.register {
    ["<Leader>"] = {
        d = { ':NvimTreeToggle<CR>', "Toggle NvimTree" },
        -- clap
        f = {
            name = "Find",
            i     = { clap'filer'    , 'File exploreer'  },
            f     = { clap'files'    , 'Files'           }, -- :find
            q     = { clap'quickfix' , 'Quickfix'        }, -- :copen
            l     = { clap'loclist'  , 'Loclist'         }, -- :lopen
            t     = { clap'proj_tags', 'Project tags'    }, -- :tj
            b     = { clap'buffers'  , 'Buffers'         }, -- :ls :b
            r     = { clap'grep'     , 'Riprep'          }, -- :grep
            g     = { clap'grep2'    , 'Grep'            },
            m     = { clap'maps'     , 'Maps'            },
            M     = { clap'marks'    , 'Marks'           },
            j     = { clap'jumps'    , 'Jumps'           },
            y     = { clap'yanks'    , 'Yanks'           },
            [':'] = { clap'hist:'    , 'Command history' },
            ['/'] = { clap'hist/'    , 'Search history'  },
            h     = { clap'history'  , 'File history'    },
            d     = { clap'dumb_jump', 'Dumb jump'       },
            ['_'] = { clap'providers', 'Providers'       },
        },
        r = {
            name = "Trouble",
            r = {':TroubleToggle lsp_workspace_diagnostics <CR>', "Toggle workspace diagnostics"},
            q = {':TroubleToggle quickfix<CR>', "Toggle quickfix" },
            l = {':TroubleToggle loclist<CR>', "Toggle loclist" },
        },
        s = {
            name = "Session",
            s = { ':SaveSession<cr>', 'Save' },
            l = { ':LoadSession<cr>', 'Load' },
        },
        A = { ':Alpha<CR>', "Open alpha" },
        x = { '<CMD>%s///g<CR>', "Delete search result" },
    },
    ['<C-h>'] = { '<C-w>h', 'Window left' },
    ['<C-j>'] = { '<C-w>j', 'Widnow down' },
    ['<C-k>'] = { '<C-w>k', 'Window up' },
    ['<C-l>'] = { '<C-w>l', 'Window right' },
    ['<esc>'] = { ':noh<CR>', 'Remove search highlights' },
    ['<C-]>'] = { 'g<C-]>', 'Jump to tag' },
    ['<A-m>'] = { '@q', 'Run q macro register' },
}

local align_maps = {
    ["<Leader>"] = {
        a = {
            name = "Align",
            ['a'] = { tabularize'/'              , 'New regex'           },
            ['('] = { tabularize'/(/r0<CR>'      , 'Open parenthesis'    },
            [')'] = { tabularize'/)/l0<CR>'      , 'Close parenthesis'   },
            ['['] = { tabularize'/[/r0<CR>'      , 'Open bracket'        },
            [']'] = { tabularize'/]/l0<CR>'      , 'Cloes bracket'       },
            ['{'] = { tabularize'/{<CR>'         , 'Open curly brace'    },
            ['}'] = { tabularize'/}<CR>'         , 'Close curly brace'   },
            [':'] = { tabularize'/:\\+<CR>'      , 'Colon'               },
            ['<'] = { tabularize'/<\\S*><CR>'    , 'Open angle bracket'  },
            ['>'] = { tabularize'/\\S*><CR>'     , 'Close angle bracket' },
            ['='] = { tabularize'/=\\S*<CR>'     , 'Equals'              },
            [','] = { tabularize'/,/l0r1<CR>'    , 'Comma'               },
        }
    }
}
wk.register(align_maps, { mode = 'n' })
wk.register(align_maps, { mode = 'v' })
wk.register(align_maps, { mode = 'o' })

-- other
-- breaks <C-I> jump because terminals are dumb
-- {'n', '<tab>', '<C-W>w', {noremap = true, silent = true} )

vim.cmd('command -nargs=+ Rg silent grep <args> <bar> Trouble quickfix')
