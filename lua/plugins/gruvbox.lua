return function()
    vim.g.gruvbox_bold = 1
    vim.g.gruvbox_filetype_hi_groups = 1
    vim.g.gruvbox_italics = 0
    vim.g.gruvbox_plugin_hi_groups = 0
    vim.opt.bg = 'dark'
    require('modules.colors')
end
