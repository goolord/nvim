vim.opt.bg = 'dark'
vim.g.hs_highlight_debug = 1

local base16 = require('base16-colorscheme')

Colors = {}

local function hl(group, options)
    vim.api.nvim_set_hl(0, group, options)
end

local function link(group_from, group_to, options)
    vim.api.nvim_set_hl(0, group_from, vim.tbl_extend("force", { link = group_to }, options or {}))
end

local function parse_rgb(s)
    local tail_s = s:sub(2)
    local res = {}
    for i in string.gmatch(tail_s, "%x%x") do
        table.insert(res, tonumber(i, 16))
    end
    return res
end

local function rgb_to_string(r, g, b)
    return string.format("#%02x%02x%02x", r, g, b)
end

local function checked_add(a, b)
    return math.max(0,math.min(0xff, a + b))
end

local function colormod(a, v1, v2, v3)
    return rgb_to_string(
        checked_add(a[1], v1),
        checked_add(a[2], v2),
        checked_add(a[3], v3)
    )
end

local function apply_colors()
    local black = parse_rgb(vim.g.terminal_color_0)
    -- local def_comment = parse_rgb(vim.g.terminal_color_8)
    local dark_bg = colormod(black, -6, -6, -6)
    Colors.dark_bg = dark_bg
    Colors.statusline = rgb_to_string(black[1] + 15, black[2] + 15, black[3] + 15)
    local light_bg = colormod(black, 25, 25, 25)
    -- local comment = colormod(def_comment, 50, 50, 40)
    hl('EndOfBuffer', { fg = vim.g.terminal_color_0 })
    -- normal stuff
    hl('SignColumn', {bg = nil})
    hl('ColorColumn', {bg = nil, fg = vim.g.terminal_color_8})
    hl('IncSearch', {bg = vim.g.terminal_color_8, fg = vim.g.terminal_color_0, bold = true})
    hl('NonText', {fg = light_bg})
    -- hl('Comment', {fg = comment})
    link('LineNr', 'Comment')
    hl('WinSeparator', {fg = light_bg, bg = dark_bg})

    -- tabline
    hl('TabLine',     {bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_8})
    hl('TabLineFill', {bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_8, underline = true})

    -- custom
    hl('DarkNormal', {bg = dark_bg})

    -- luatree
    hl('NvimTreeFolderIcon', {fg = vim.g.terminal_color_3})
    link('NvimTreeNormal', 'DarkNormal')
    link('NvimTreeIndentMarker', 'Comment')
    link('NvimTreeRootFolder', 'StatusLine')
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
    hl('TelescopePromptPrefix', {bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_1})
    link('TelescopeNormal', 'DarkNormal')
    link('TelescopePreviewNormal', 'Normal')

    link('TelescopePromptBorder', 'Normal')
    link('TelescopePromptNormal', 'Normal')
    hl('TelescopePromptTitle', {bg = vim.g.terminal_color_1, fg = vim.g.terminal_color_0, bold = true})

    hl('TelescopePreviewBorder', {bg = nil, fg = dark_bg, bold = true})
    hl('TelescopePreviewTitle', {bg = vim.g.terminal_color_11, fg = vim.g.terminal_color_0, bold = true})
    link('TelescopePreviewLine', 'Visual')

    -- fidget
    link('FidgetTitle', 'Pmenu', {blend=10})
    link('FidgetTask', 'Pmenu', {blend=10})

    -- WhichKey
    link('WhichKeyFloat', 'Pmenu')

    -- indent
    link('IndentBlanklineChar', 'NonText', { bold = true })
    hl('IndentBlanklineContextChar', {fg = base16.colors.base02, bold = true})
end

-- automatically override colourscheme

vim.cmd.colors('base16-tomorrow-min')
apply_colors()

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function ()
        apply_colors()
        require('plugins.statusline')()
    end,
})

return {
    parse_rgb = parse_rgb,
    rgb_to_string = rgb_to_string,
}
