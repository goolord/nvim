vim.opt.bg = 'dark'
vim.g.hs_highlight_debug = 1

Colors = {}

local function hl(group, options)
    vim.api.nvim_set_hl(0, group, options)
end

local function link(group_from, group_to, options)
    vim.api.nvim_set_hl(0, group_from, vim.tbl_extend("force", { link = group_to }, options or {}))
end

local function get_hl(group) return vim.api.nvim_get_hl_by_name(group, true) end

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
    local dark_bg
    if Colors.dark_bg == nil
    then
        dark_bg = colormod(black, -6, -6, -6)
        Colors.dark_bg = dark_bg
    else
        dark_bg = Colors.dark_bg
    end
    Colors.statusline = rgb_to_string(black[1] + 15, black[2] + 15, black[3] + 15)
    local light_bg = colormod(black, 25, 25, 25)
    -- local comment = colormod(def_comment, 50, 50, 40)
    hl('EndOfBuffer', { fg = vim.g.terminal_color_0 })
    -- normal stuff
    hl('SignColumn', {bg = nil})
    hl('ColorColumn', {bg = nil, fg = vim.g.terminal_color_8})
    hl('IncSearch', {bg = vim.g.terminal_color_8, fg = vim.g.terminal_color_0, bold = true})
    hl('NonText', {fg = light_bg})
    hl('PMenuSel', get_hl('StatusLine'))
    hl('BlinkCmpLabel', {fg = get_hl('Normal').foreground, bg = nil})
    hl('BlinkCmpMenuSelection', {bg = get_hl('PMenuSel').background})
    link('LineNr', 'Comment')
    hl('WinSeparator', {fg = light_bg, bg = dark_bg})

    -- tabline
    hl('TabLine',     {bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_8})
    hl('TabLineFill', {bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_8, underline = true})

    -- custom
    hl('DarkNormal', {bg = dark_bg})

    -- nvim-tree
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

    -- snacks
    link('SnacksPickerDir', 'Comment')
    link('SnacksPickerTotals', 'Comment')
    hl('SnacksPickerBox', { bg = dark_bg })
    hl('SnacksPickerBorder', { bg = dark_bg, fg = dark_bg })
    hl('SnacksPickerInputBorder', { bg = dark_bg, fg = vim.g.terminal_color_8 })
    hl('SnacksPickerPrompt', { bg = dark_bg })
    hl('SnacksPickerList', { bg = dark_bg })
    hl('SnacksPickerInput', { bg = dark_bg })
    link('SnacksPickerTitle', 'CursorLine')

    -- fidget
    link('FidgetTitle', 'Pmenu', {blend=10})
    link('FidgetTask', 'Pmenu', {blend=10})

    -- WhichKey
    link('WhichKeyFloat', 'Pmenu')

    -- indent
    link('IblIndent', 'NonText', { bold = true })
    hl('IblScope', {fg = get_hl('StatusLine').background, bold = true})


    -- mini.icons
    hl('MiniIconsAzure' , { fg = vim.g.terminal_color_12 } )
    hl('MiniIconsBlue'  , { fg = vim.g.terminal_color_4  } )
    hl('MiniIconsCyan'  , { fg = vim.g.terminal_color_6  } )
    hl('MiniIconsGreen' , { fg = vim.g.terminal_color_2  } )
    hl('MiniIconsGrey'  , { fg = vim.g.terminal_color_7  } )
    hl('MiniIconsOrange', { fg = vim.g.terminal_color_3  } )
    hl('MiniIconsPurple', { fg = vim.g.terminal_color_5  } )
    hl('MiniIconsRed'   , { fg = vim.g.terminal_color_1  } )
    hl('MiniIconsYellow', { fg = vim.g.terminal_color_11 } )
end

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
