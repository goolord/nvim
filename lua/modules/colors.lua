local function hl(group, options)
    local bg = options.bg == nil and '' or 'guibg=' .. options.bg
    local fg = options.fg == nil and '' or 'guifg=' .. options.fg
    local gui = options.gui == nil and '' or 'gui=' .. options.gui

    vim.cmd(string.format('hi %s %s %s %s', group, bg, fg, gui))
end

function _G.apply_colors()
    local highlights = {
        -- normal stuff
        {'SignColumn', {bg = 'NONE'}},
        {'ColorColumn', {bg = 'NONE', fg = '#928374'}},
        {'IncSearch', {bg = '#928374', fg = '#282828', gui = 'bold'}},

        -- luatree
        {'NvimTreeFolderIcon', {fg = '#D79921'}},
        {'NvimTreeIndentMarker', {fg = '#928374'}},

        -- diagnostics
        {'DiagnosticError', {bg = 'NONE', fg = '#FB4934'}},
        {'DiagnosticInfo', {bg = 'NONE', fg = '#D3869B'}},
        {'DiagnosticWarn', {bg = 'NONE', fg = '#FABD2F'}},
        {'DiagnosticHint', {bg = 'NONE', fg = '#83A598'}},
        {'DiagnosticUnderlineError', {bg = 'NONE', fg = 'NONE', gui = 'underline'}},
        {'DiagnosticUnderlineWarn', {bg = 'NONE', fg = 'NONE', gui = 'underline'}},

        -- coqtail
        {'CoqtailChecked', {bg = '#1b4723'}},
        {'CoqtailSent', {bg = '#79750e'}},

        -- telescope
        {'TelescopeNormal', {bg = '#1d2021'}}
    }

    for _, highlight in pairs(highlights) do hl(highlight[1], highlight[2]) end
end

-- automatically override colourscheme
vim.cmd('augroup NewColor')
vim.cmd('au!')
vim.cmd('au ColorScheme * call v:lua.apply_colors()')
vim.cmd('augroup END')

vim.cmd('colors gruvbox8')

vim.g.hs_highlight_debug = 1
