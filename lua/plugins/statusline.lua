return function()
    local dark_bg = '#1d2021'
    local function mode(x) return { bg = dark_bg, fg = x, gui = 'bold' } end
    local def = { bg = '#3c3836', fg = vim.g.terminal_color_15 }
    local custom_gruvbox = {
        normal = {
            a = mode(vim.g.terminal_color_15),
            b = def,
            c = def,
        },
        insert = {
            a = mode(vim.g.terminal_color_14),
            b = def,
            c = def,
        },
        visual = {
            a = mode(vim.g.terminal_color_11),
            b = def,
            c = def,
        },
        replace = {
            a = mode(vim.g.terminal_color_9),
            b = def,
            c = def,
        },
        command = {
            a = mode(vim.g.terminal_color_13),
            b = def,
            c = def,
        },
        inactive = {
            a = mode(vim.g.terminal_color_7),
            b = def,
            c = def,
        },
    }

    local config = require('lualine').get_config()
    config.options.theme = custom_gruvbox
    config.options.component_separators = {left = ' ', right = ''}
    config.options.section_separators = {left = '', right = ''}
    config.options.icons_enabled = true
    config.extensions = { 'fugitive', 'nvim-tree' }
    config.sections.lualine_b[2] = {'diff', symbols = { added = ' ', modified = '柳', removed = ' ' }}

    require('lualine').setup(config)
end
