local keymap = vim.api.nvim_set_keymap

local function telescope_bind(c, provider)
    return
        {   'n', '<Leader>f' .. c,
            '<CMD>Telescope ' .. provider .. '<CR>',
            { noremap = true, silent = false }
        }
end

local function tabularize_bind(c,regex)
    return {'', '<Leader>a' .. c, ':Tabularize ' .. regex, {} }
end

local function set_keybindings(keybindings)
    for _, key in pairs(keybindings) do keymap(key[1], key[2], key[3], key[4]) end
end

set_keybindings {
    -- {'mode', 'keybindings', 'command', '{noremap=bool', 'silent=bool', expr=bool}}
    -- disable keys
    {'', '<MiddleMouse>', '<Nop>', {silent = true} },
    {'i', '<MiddleMouse>', '<Nop>', {silent = true} },
    -- terminal mode
    {'t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true}},
    -- nvim-tree.lua
    {'n', '<Leader>d', '<CMD>NvimTreeToggle<CR>', {noremap = true, silent = false}},
    {'n', '<Leader>td', '<CMD>NvimTreeFindFile<CR>', {noremap = true, silent = false}},
    -- telescope
    telescope_bind('f','find_files'), -- :find
    telescope_bind('q','quickfix'),   -- :copen
    telescope_bind('l','loclist'),    -- :lopen
    telescope_bind('t','tags'),       -- :tj
    telescope_bind('b','buffers'),    -- :ls :b
    telescope_bind('g','live_grep'),  -- :grep
    telescope_bind('i','file_browser'),
    telescope_bind('k','keymaps'),
    telescope_bind('m','marks'),
    telescope_bind('j','jumplist'),
    telescope_bind('y','registers'),
    telescope_bind(':','command_history'),
    telescope_bind('/','search_history'),
    telescope_bind('h','oldfiles'),
    telescope_bind('d','dumb_jump'),
    telescope_bind('s','sessions'),
    telescope_bind('_',''),
    -- Delete in search result
    {'n', '<Leader>x', '<CMD>%s///g<CR>', {noremap = false, silent = false}},
    -- -- other
    {'', '<Space>', '<Leader>', {silent = true} },
    -- breaks <C-I> jump because terminals are dumb
    -- {'n', '<tab>', '<C-W>w', {noremap = true, silent = true} },
    {'n', '<C-h>', '<C-w>h', {noremap = true, silent = true} },
    {'n', '<C-j>', '<C-w>j', {noremap = true, silent = true} },
    {'n', '<C-k>', '<C-w>k', {noremap = true, silent = true} },
    {'n', '<C-l>', '<C-w>l', {noremap = true, silent = true} },
    {'n', '<esc>', ':noh<CR>', {noremap = false, silent = true} },
    {'n', '<Leader>rr', ':TroubleToggle lsp_workspace_diagnostics <CR>', {silent = true} },
    {'n', '<Leader>rq', ':TroubleToggle quickfix<CR>', {silent = true} },
    {'n', '<Leader>rl', ':TroubleToggle loclist<CR>', {silent = true} },
    {'n', '<Leader>ss', ':SaveSession<cr>', {silent = true} },
    {'n', '<Leader>sl', ':LoadSession<cr>', {silent = true} },
    {'n', '<Leader>D', ':Dashboard<CR>', {silent = true} },
    -- tabular
    tabularize_bind('','/'),
    tabularize_bind('a','/'),
    tabularize_bind('(','/(/r0<CR>'),
    tabularize_bind(')','/)/l0<CR>'),
    tabularize_bind('[','/[/r0<CR>'),
    tabularize_bind(']','/]/l0<CR>'),
    tabularize_bind('{','/{<CR>'),
    tabularize_bind('}','/}<CR>'),
    tabularize_bind(':','/:\\+<CR>'),
    tabularize_bind('<','/<\\S*><CR>'),
    tabularize_bind('=','/=\\S*<CR>'),
    tabularize_bind('>','/\\S*><CR>'),
    tabularize_bind(',','/,/l0r1<CR>'),
    -- tag list
    {'n', '<C-]>', 'g<C-]>', {noremap = true} },
    -- macro
    {'n', '<A-m>', '@q', {} },
}

vim.cmd('command -nargs=+ Rg silent grep <args> <bar> Trouble quickfix')

return set_keybindings
