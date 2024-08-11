local wk = require("which-key")

local keymap = vim.keymap.set

-- ('mode', 'keybindings', 'command', '{noremap=bool', 'silent=bool', expr=bool})
keymap('', '<Space>', '<Leader>', {silent = true, remap = true} )
-- disable keys
keymap('' , '<MiddleMouse>', '<Nop>', {silent = true, nowait = true, remap = true } )
keymap('i', '<MiddleMouse>', '<Nop>', {silent = true, nowait = true, remap = true} )
-- terminal mode
keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true, remap = true})

local function telescope(provider) return '<CMD>Telescope ' .. provider .. '<CR>' end

local function tabularize(regex) return ':Tabularize ' .. regex end

wk.add {
  { "<A-m>", "@q", desc = "Run q macro register" },
  { "<C-]>", "g<C-]>", desc = "Jump to tag" },
  { "<Leader>A", ":Alpha<CR>", desc = "Open alpha" },
  { "<Leader>d", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
  { "<Leader>f", group = "Find" },
  { "<Leader>f/", telescope'search_history', desc = "Search history" },
  { "<Leader>f:", telescope'command_history', desc = "Command history" },
  { "<Leader>fM", telescope'marks', desc = "Marks" },
  { "<Leader>f_", telescope'', desc = "Providers" },
  { "<Leader>fb", telescope'buffers', desc = "Buffers" },
  { "<Leader>ff", telescope'find_files', desc = "Files" },
  { "<Leader>fg", telescope'live_grep', desc = "Grep" },
  { "<Leader>fh", telescope'oldfiles', desc = "File history" },
  { "<Leader>fj", telescope'jumplist', desc = "Jumps" },
  { "<Leader>fl", telescope'loclist', desc = "Loclist" },
  { "<Leader>fm", telescope'keymaps', desc = "Maps" },
  { "<Leader>fq", telescope'quickfix', desc = "Quickfix" },
  { "<Leader>fr", telescope'registers', desc = "Registers" },
  { "<Leader>ft", telescope'tags', desc = "Tags" },
  { "<Leader>fx", telescope'resume', desc = "Resume last" },
  { "<Leader>fy", telescope'neoclip', desc = "Yanks" },
  { "<Leader>r", group = "Trouble" },
  { "<Leader>rl", ":Trouble loclist<CR>", desc = "Toggle loclist" },
  { "<Leader>rq", ":Trouble quickfix<CR>", desc = "Toggle quickfix" },
  { "<Leader>rr", ":Trouble workspace_diagnostics <CR>", desc = "Toggle workspace diagnostics" },
  { "<Leader>rt", ":TodoTrouble<CR>", desc = "Toggle todos" },
  { "<Leader>s", group = "Session" },
  { "<Leader>sc", ":SessionManager load_current_dir_session<cr>", desc = "Load current dir session" },
  { "<Leader>sl", ":SessionManager load_last_session<cr>", desc = "Load" },
  { "<Leader>ss", ":SessionManager save_current_session<cr>", desc = "Save" },
  { "<Leader>x", "<CMD>%s///g<CR>", desc = "Delete search result" },
  { "<esc>", ":noh<CR>", desc = "Remove search highlights" },
}

wk.add {
    { "<Leader>a", group = "Align" },
    { "<Leader>aa", tabularize'/'          , desc = 'New regex'           },
    { "<Leader>a(", tabularize'/(/r0<CR>'  , desc = 'Open parenthesis'    },
    { "<Leader>a)", tabularize'/)/l0<CR>'  , desc = 'Close parenthesis'   },
    { "<Leader>a[", tabularize'/[/r0<CR>'  , desc = 'Open bracket'        },
    { "<Leader>a]", tabularize'/]/l0<CR>'  , desc = 'Cloes bracket'       },
    { "<Leader>a{", tabularize'/{<CR>'     , desc = 'Open curly brace'    },
    { "<Leader>a}", tabularize'/}<CR>'     , desc = 'Close curly brace'   },
    { "<Leader>a:", tabularize'/:\\+<CR>'  , desc = 'Colon'               },
    { "<Leader>a<", tabularize'/<\\S*><CR>', desc = 'Open angle bracket'  },
    { "<Leader>a>", tabularize'/\\S*><CR>' , desc = 'Close angle bracket' },
    { "<Leader>a=", tabularize'/=\\S*<CR>' , desc = 'Equals'              },
    { "<Leader>a,", tabularize'/,/l0r1<CR>', desc = 'Comma'               },
}

wk.add {
    { "<C-h>", '<cmd>wincmd h<cr>', desc = 'Window left' },
    { "<C-j>", '<cmd>wincmd j<cr>', desc = 'Widnow down' },
    { "<C-k>", '<cmd>wincmd k<cr>', desc = 'Window up' },
    { "<C-l>", '<cmd>wincmd l<cr>', desc = 'Window right' },
}

-- other
-- breaks <C-I> jump because terminals are dumb
-- {'n', '<tab>', '<C-W>w', {noremap = true, silent = true} )

vim.api.nvim_create_user_command('Rg', 'silent grep <args> <bar> Trouble quickfix', { nargs = "+" })
vim.api.nvim_create_user_command('Notes', function ()
    local cwd = vim.fn.getcwd()
    vim.cmd.e("~/Dev/notes/" .. cwd:gsub("%s+", "_"):gsub("/","-") .. ".md")
end, {nargs=0})
vim.api.nvim_create_user_command('E', function (files)
    local xs = vim.tbl_map(function(x)
        local res = vim.fn.systemlist('fd -p ' .. x)[1]
        if type(res) == "table" then res = res[1] end
        if res == ""
            then return x
            else return res:match"(.-)%s*$"
        end
    end, files.fargs)
    vim.cmd.e(table.concat(xs, " "))
end, {nargs="*"})

-- menus
vim.cmd('unmenu PopUp.How-to\\ disable\\ mouse')
vim.cmd('unmenu PopUp.-1-')

-- keymap('' , 'gf', function () vim.cmd.E(vim.fn.expand('<cfile>')) end, {silent = true, remap = true } )
