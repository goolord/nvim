return function()
    local colors = require('modules.colors')
    local function mode(x) return { bg = colors.dark_bg, fg = x, gui = 'bold' } end
    local black = colors.parse_rgb(vim.g.terminal_color_0)
    local statusline = colors.rgb_to_string(black[1] + 15, black[2] + 15, black[3] + 15)
    local def = { bg = statusline, fg = vim.g.terminal_color_15 }
    local def_bold = vim.deepcopy(def)
    def_bold.gui = 'bold'
    local custom_gruvbox = {
        normal = {
            a = mode(vim.g.terminal_color_15),
            b = def,
            c = def,
            z = def_bold,
        },
        insert = {
            a = mode(vim.g.terminal_color_14),
            b = def, c = def, z = def_bold,
        },
        visual = {
            a = mode(vim.g.terminal_color_11),
            b = def, c = def, z = def_bold,
        },
        replace = {
            a = mode(vim.g.terminal_color_9),
            b = def, c = def, z = def_bold,
        },
        command = {
            a = mode(vim.g.terminal_color_13),
            b = def, c = def, z = def_bold,
        },
        terminal = {
            a = mode(vim.g.terminal_color_15),
            b = def, c = def, z = def_bold,
        },
        inactive = {
            a = def,
            b = def, c = def, z = def_bold,
        },
    }

    local config = require('lualine').get_config()
    config.options.theme = custom_gruvbox
    config.options.component_separators = {left = '|', right = ''}
    config.options.section_separators = {left = '', right = ''}
    config.options.icons_enabled = true
    -- config.options.globalstatus = true
    config.extensions = { 'fugitive', 'nvim-tree' }
    config.sections.lualine_b[2] = {'diff', symbols = { added = ' ', modified = '柳', removed = ' ' }}

    require('lualine').setup(config)
end
