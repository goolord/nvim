local function hl(group, options)
    vim.api.nvim_set_hl(0, group, options)
end

local function link(group_from, group_to, options)
    vim.api.nvim_set_hl(0, group_from, vim.tbl_extend("force", vim.api.nvim_get_hl_by_name(group_to, true), options or {}))
end

local function parse_rgb(s)
    local tail_s = s:sub(2)
    local res = {}
    for i in string.gmatch(tail_s, "%x%x") do
        table.insert(res, tonumber(i, 16))
    end
    return res
end

vim.opt.bg = 'dark'
vim.g.hs_highlight_debug = 1

local function rgb_to_string(r, g, b)
    return string.format("#%02x%02x%02x", r, g, b)
end

local dark_bg = '#000000'

local function apply_colors()
    local black = parse_rgb(vim.g.terminal_color_0)
    local def_comment = parse_rgb(vim.g.terminal_color_8)
    dark_bg = rgb_to_string(black[1] - 10, black[2] - 10, black[3] - 10)
    local light_bg = rgb_to_string(black[1] + 20, black[2] + 20, black[3] + 20)
    local comment = rgb_to_string(def_comment[1] + 50, def_comment[2] + 50, def_comment[3] + 40)
    hl('EndOfBuffer', { fg = vim.g.terminal_color_0 })
    -- normal stuff
    hl('SignColumn', {bg = nil})
    hl('ColorColumn', {bg = nil, fg = vim.g.terminal_color_8})
    hl('IncSearch', {bg = vim.g.terminal_color_8, fg = vim.g.terminal_color_0, bold = true})
    hl('NonText', {fg = light_bg})
    hl('Comment', {fg = comment})

    -- tabline
    hl('TabLine',     {bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_8})
    hl('TabLineFill', {bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_8, underline = true})

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
    hl('TelescopePromptPrefix', {bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_1})
    link('TelescopeNormal', 'DarkNormal')
    link('TelescopePreviewNormal', 'Normal')

    link('TelescopePromptBorder', 'Normal')
    link('TelescopePromptNormal', 'Normal')
    link('TelescopePromptTitle', 'Normal')

    hl('TelescopePreviewBorder', {bg = nil, fg = vim.g.terminal_color_11})
    hl('TelescopePreviewTitle', {bg = nil, fg = vim.g.terminal_color_11, bold = true})

    -- fidget
    link('FidgetTitle', 'Pmenu', {blend=10})
    link('FidgetTask', 'Pmenu', {blend=10})
end

-- automatically override colourscheme

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = apply_colors,
})

vim.cmd.colors('base16-gruvbox-material-dark-hard')

return {
    dark_bg = dark_bg,
    parse_rgb = parse_rgb,
    rgb_to_string = rgb_to_string,
}
