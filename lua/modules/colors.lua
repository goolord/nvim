local function hl(group, options)
    vim.api.nvim_set_hl(0, group, options)
end

local function link(group_from, group_to)
    vim.api.nvim_set_hl(0, group_from, vim.api.nvim_get_hl_by_name(group_to, true))
end

function _G.apply_colors()
    local dark_bg = '#1d2021'
    -- normal stuff
    hl('SignColumn', {bg = nil})
    hl('ColorColumn', {bg = nil, fg = vim.g.terminal_color_8})
    hl('IncSearch', {bg = vim.g.terminal_color_8, fg = vim.g.terminal_color_0, bold = true})

    -- tabline
    hl('TabLine',     {bg = vim.g.terminal_color_0})
    hl('TabLineFill', {bg = vim.g.terminal_color_0, underline = true})

    -- custom
    hl('DarkNormal', {bg = dark_bg})

    -- luatree
    hl('NvimTreeFolderIcon', {fg = vim.g.terminal_color_3})
    link('NvimTreeNormal', 'DarkNormal')
    link('NvimTreeIndentMarker', 'Comment')

    -- diagnostics
    hl('DiagnosticError', {bg = nil, fg = vim.g.terminal_color_9})
    hl('DiagnosticInfo' , {bg = nil, fg = vim.g.terminal_color_13})
    hl('DiagnosticWarn' , {bg = nil, fg = vim.g.terminal_color_11})
    hl('DiagnosticHint' , {bg = nil, fg = vim.g.terminal_color_12})
    hl('DiagnosticUnderlineError', {bg = nil, fg = nil, undercurl = true})
    hl('DiagnosticUnderlineWarn' , {bg = nil, fg = nil, underline = true})

    -- lsp
    hl('LspCodeLens', {bg = dark_bg, fg = vim.g.terminal_color_8, underline = true})

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

    hl('TelescopePreviewBorder', {bg = nil, fg = vim.g.terminal_color_11})
    hl('TelescopePreviewTitle', {bg = nil, fg = vim.g.terminal_color_11, bold = true})

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
