local wk = require("which-key")

local keymap = vim.api.nvim_set_keymap

-- ('mode', 'keybindings', 'command', '{noremap=bool', 'silent=bool', expr=bool})
keymap('', '<Space>', '<Leader>', {silent = true} )
-- disable keys
keymap('' , '<MiddleMouse>', '<Nop>', {silent = true, nowait = true} )
keymap('i', '<MiddleMouse>', '<Nop>', {silent = true, nowait = true} )
-- terminal mode
keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

local function telescope(provider) return '<CMD>Telescope ' .. provider .. '<CR>' end

local function tabularize(regex) return ':Tabularize ' .. regex end

wk.register {
    ["<Leader>"] = {
        d = { ':NvimTreeToggle<CR>', "Toggle NvimTree" },
        -- telescope
        f = {
            name = "Find",
            i     = { telescope'file_browser'   , 'File browser'    },
            f     = { telescope'find_files'     , 'Files'           }, -- :find
            q     = { telescope'quickfix'       , 'Quickfix'        }, -- :copen
            l     = { telescope'loclist'        , 'Loclist'         }, -- :lopen
            t     = { telescope'tags'           , 'Tags'            }, -- :tj
            b     = { telescope'buffers'        , 'Buffers'         }, -- :ls :b
            g     = { telescope'live_grep'      , 'Grep'            },
            m     = { telescope'keymaps'        , 'Maps'            },
            M     = { telescope'marks'          , 'Marks'           },
            j     = { telescope'jumps'          , 'Jumps'           },
            y     = { telescope'neoclip'        , 'Yanks'           },
            r     = { telescope'registers'      , 'Registers'       },
            [':'] = { telescope'command_history', 'Command history' },
            ['/'] = { telescope'search_history' , 'Search history'  },
            h     = { telescope'history'        , 'File history'    },
            ['_'] = { telescope''               , 'Providers'       },
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
