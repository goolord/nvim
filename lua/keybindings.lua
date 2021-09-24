local keymap = vim.api.nvim_set_keymap

local function clap_bind(c, provider)
    keymap(
        'n', '<Leader>f' .. c,
        '<CMD>Clap ' .. provider .. '<CR>',
        { noremap = true, silent = false }
    )
end

local function tabularize_bind(c,regex)
    keymap('', '<Leader>a' .. c, ':Tabularize ' .. regex, {})
end

-- ('mode', 'keybindings', 'command', '{noremap=bool', 'silent=bool', expr=bool})
-- disable keys
keymap('' , '<MiddleMouse>', '<Nop>', {silent = true, nowait = true} )
keymap('i', '<MiddleMouse>', '<Nop>', {silent = true, nowait = true} )
-- terminal mode
keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})
-- nvim-tree.lua
keymap('n', '<Leader>d', '<CMD>NvimTreeToggle<CR>', {noremap = true, silent = false})
keymap('n', '<Leader>td', '<CMD>NvimTreeFindFile<CR>', {noremap = true, silent = false})
-- clap
clap_bind('i','filer')
clap_bind('f','files')     -- :find
clap_bind('q','quickfix')  -- :copen
clap_bind('l','loclist')   -- :lopen
clap_bind('t','proj_tags') -- :tj
clap_bind('b','buffers')   -- :ls :b
clap_bind('g','grep')      -- :grep
clap_bind('m','maps')
clap_bind('M','marks')
clap_bind('j','jumps')
clap_bind('y','yanks')
clap_bind(':','hist:')
clap_bind('/','hist/')
clap_bind('h','history')
clap_bind('d','dumb_jump')
clap_bind('_','providers')
-- Delete in search result
keymap('n', '<Leader>x', '<CMD>%s///g<CR>', {noremap = false, silent = false})
-- other
keymap('', '<Space>', '<Leader>', {silent = true} )
-- breaks <C-I> jump because terminals are dumb
-- {'n', '<tab>', '<C-W>w', {noremap = true, silent = true} )
keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true} )
keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true} )
keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = true} )
keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true} )
keymap('n', '<esc>', ':noh<CR>', {noremap = false, silent = true} )
keymap('n', '<Leader>rr', ':TroubleToggle lsp_workspace_diagnostics <CR>', {silent = true} )
keymap('n', '<Leader>rq', ':TroubleToggle quickfix<CR>', {silent = true} )
keymap('n', '<Leader>rl', ':TroubleToggle loclist<CR>', {silent = true} )
keymap('n', '<Leader>ss', ':SaveSession<cr>', {silent = true} )
keymap('n', '<Leader>sl', ':LoadSession<cr>', {silent = true} )
keymap('n', '<Leader>A', ':Alpha<CR>', {silent = true} )
-- tabular
tabularize_bind('','/')
tabularize_bind('a','/')
tabularize_bind('(','/(/r0<CR>')
tabularize_bind(')','/)/l0<CR>')
tabularize_bind('[','/[/r0<CR>')
tabularize_bind(']','/]/l0<CR>')
tabularize_bind('{','/{<CR>')
tabularize_bind('}','/}<CR>')
tabularize_bind(':','/:\\+<CR>')
tabularize_bind('<','/<\\S*><CR>')
tabularize_bind('=','/=\\S*<CR>')
tabularize_bind('>','/\\S*><CR>')
tabularize_bind(',','/,/l0r1<CR>')
-- tag list
keymap('n', '<C-]>', 'g<C-]>', {noremap = true} )
-- macro
keymap('n', '<A-m>', '@q', {} )

vim.cmd('command -nargs=+ Rg silent grep <args> <bar> Trouble quickfix')
