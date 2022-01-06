return function()
    require("indent_blankline").setup {
        char = '▏',
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        buftype_exclude = { 'terminal' },
        filetype_exclude = {
            'help'   ,
            'alpha'  , 'Preview' ,
            '__doc__', 'peekaboo',
            'man'    , 'trans'   ,
            'fzf'    , 'markdown',
            'log'    , 'terminal',
        }
    }
end
