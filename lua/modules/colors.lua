local function hl(group, options)
    local bg = options.bg == nil and '' or 'guibg=' .. options.bg
    local fg = options.fg == nil and '' or 'guifg=' .. options.fg
    local gui = options.gui == nil and '' or 'gui=' .. options.gui

    vim.cmd(string.format('hi %s %s %s %s', group, bg, fg, gui))
end

local function link(group_from, group_to)
    vim.cmd(string.format('hi! link %s %s', group_from, group_to))
end

function _G.apply_colors()
    local dark_bg = '#1d2021'
    -- normal stuff
    hl('SignColumn', {bg = 'NONE'})
    hl('ColorColumn', {bg = 'NONE', fg = vim.g.terminal_color_8})
    hl('IncSearch', {bg = vim.g.terminal_color_8, fg = vim.g.terminal_color_0, gui = 'bold'})

    -- tabline
    hl('TabLine',     {bg = vim.g.terminal_color_0})
    hl('TabLineFill', {bg = vim.g.terminal_color_0, gui = 'underline'})

    -- custom
    hl('DarkNormal', {bg = dark_bg})

    -- luatree
    hl('NvimTreeFolderIcon', {fg = vim.g.terminal_color_3})
    link('NvimTreeNormal', 'DarkNormal')
    link('NvimTreeIndentMarker', 'Comment')

    -- diagnostics
    hl('DiagnosticError', {bg = 'NONE', fg = vim.g.terminal_color_9})
    hl('DiagnosticInfo' , {bg = 'NONE', fg = vim.g.terminal_color_13})
    hl('DiagnosticWarn' , {bg = 'NONE', fg = vim.g.terminal_color_11})
    hl('DiagnosticHint' , {bg = 'NONE', fg = vim.g.terminal_color_12})
    hl('DiagnosticUnderlineError', {bg = 'NONE', fg = 'NONE', gui = 'underline'})
    hl('DiagnosticUnderlineWarn' , {bg = 'NONE', fg = 'NONE', gui = 'underline'})

    -- lsp
    hl('LspCodeLens', {bg = dark_bg, fg = vim.g.terminal_color_8, gui = 'underline'})

    -- coqtail
    hl('CoqtailChecked', {bg = '#1b4723'})
    hl('CoqtailSent'   , {bg = '#79750e'})

    -- telescope
    hl('TelescopeBorder', {bg = dark_bg, fg = vim.g.terminal_color_8})
    link('TelescopeNormal', 'DarkNormal')
    link('TelescopePreviewBorder', 'DarkNormal')
    link('TelescopePreviewNormal', 'Normal')
    hl('TelescopePreviewTitle', {bg = 'NONE', fg = vim.g.terminal_color_11, gui = 'underline,bold'})
end

-- automatically override colourscheme
vim.cmd[[
augroup NewColor
au!
au ColorScheme * call v:lua.apply_colors()
augroup END

colors gruvbox8
]]

vim.g.hs_highlight_debug = 1
