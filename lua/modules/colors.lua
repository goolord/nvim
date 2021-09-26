local function hl(group, options)
    local bg = options.bg == nil and '' or 'guibg=' .. options.bg
    local fg = options.fg == nil and '' or 'guifg=' .. options.fg
    local gui = options.gui == nil and '' or 'gui=' .. options.gui

    vim.cmd(string.format('hi %s %s %s %s', group, bg, fg, gui))
end

function _G.apply_colors()
    -- normal stuff
    hl('SignColumn', {bg = 'NONE'})
    hl('ColorColumn', {bg = 'NONE', fg = '#928374'})
    hl('IncSearch', {bg = '#928374', fg = '#282828', gui = 'bold'})

    -- luatree
    hl('NvimTreeFolderIcon', {fg = '#D79921'})
    hl('NvimTreeIndentMarker', {fg = '#928374'})
    hl('NvimTreeNormal', {bg = '#1d2021'})

    -- diagnostics
    hl('DiagnosticError', {bg = 'NONE', fg = '#FB4934'})
    hl('DiagnosticInfo' , {bg = 'NONE', fg = '#D3869B'})
    hl('DiagnosticWarn' , {bg = 'NONE', fg = '#FABD2F'})
    hl('DiagnosticHint' , {bg = 'NONE', fg = '#83A598'})
    hl('DiagnosticUnderlineError', {bg = 'NONE', fg = 'NONE', gui = 'underline'})
    hl('DiagnosticUnderlineWarn' , {bg = 'NONE', fg = 'NONE', gui = 'underline'})

    -- coqtail
    hl('CoqtailChecked', {bg = '#1b4723'})
    hl('CoqtailSent'   , {bg = '#79750e'})
end

-- automatically override colourscheme
vim.cmd('augroup NewColor')
vim.cmd('au!')
vim.cmd('au ColorScheme * call v:lua.apply_colors()')
vim.cmd('augroup END')

vim.cmd('colors gruvbox8')

vim.g.hs_highlight_debug = 1
