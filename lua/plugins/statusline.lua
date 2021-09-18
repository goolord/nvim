return function()
    require('lualine').setup {
        options = {
            theme = 'gruvbox',
            component_separators = {left = '|', right = '|'},
            section_separators = {left = '', right = ''},
            icons_enabled = true,
        },
        extensions = { 'fugitive', 'nvim-tree' },
    }
end
