local function hl(group, options)
    vim.api.nvim_set_hl(0, group, options)
end

local function link(group_from, group_to)
    vim.api.nvim_set_hl(0, group_from, vim.api.nvim_get_hl_by_name(group_to, true))
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
    hl('DiagnosticUnderlineError', {bg = 'NONE', fg = 'NONE', gui = 'undercurl'})
    hl('DiagnosticUnderlineWarn' , {bg = 'NONE', fg = 'NONE', gui = 'underline'})

    -- lsp
    hl('LspCodeLens', {bg = dark_bg, fg = vim.g.terminal_color_8, gui = 'underline'})

    -- coqtail
    hl('CoqtailChecked', {bg = '#1d3320'})
    hl('CoqtailSent'   , {bg = '#79750e'})

    -- telescope
    hl('TelescopeBorder', {bg = dark_bg, fg = vim.g.terminal_color_8})
    link('TelescopeNormal', 'DarkNormal')
    link('TelescopePreviewNormal', 'Normal')

    link('TelescopePromptBorder', 'Normal')
    link('TelescopePromptNormal', 'Normal')
    link('TelescopePromptTitle', 'Normal')

    hl('TelescopePreviewBorder', {bg = 'NONE', fg = vim.g.terminal_color_11})
    hl('TelescopePreviewTitle', {bg = 'NONE', fg = vim.g.terminal_color_11, gui = 'bold'})

    -- fidget
    link('FidgetTitle', 'DarkNormal')
    link('FidgetTask', 'DarkNormal')
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
