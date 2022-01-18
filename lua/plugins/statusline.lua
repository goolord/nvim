return function()
    local dark_bg = '#1d2021'
    local custom_gruvbox = {
        normal = {
            a = { bg = dark_bg , fg = vim.g.terminal_color_15, gui = 'bold' },
            b = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
            c = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
        },
        insert = {
            a = { bg = dark_bg, fg = vim.g.terminal_color_14, gui = 'bold' },
            b = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
            c = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
        },
        visual = {
            a = { bg = dark_bg, fg = vim.g.terminal_color_11, gui = 'bold' },
            b = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
            c = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
        },
        replace = {
            a = { bg = dark_bg, fg = vim.g.terminal_color_9, gui = 'bold' },
            b = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
            c = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
        },
        command = {
            a = { bg = dark_bg, fg = vim.g.terminal_color_13, gui = 'bold' },
            b = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
            c = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
        },
        inactive = {
            a = { bg = dark_bg, fg = vim.g.terminal_color_7, gui = 'bold' },
            b = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
            c = { bg = vim.g.terminal_color_0, fg = vim.g.terminal_color_15 },
        },
    }

    local config = require('lualine').get_config()
    config.options.theme = custom_gruvbox
    config.options.component_separators = {left = '|', right = '|'}
    config.options.section_separators = {left = '', right = ''}
    config.options.icons_enabled = true
    config.extensions = { 'fugitive', 'nvim-tree' }

    require('lualine').setup(config)
end
