return function ()
    vim.g.clap_popup_border = 'nil'
    vim.g.clap_theme = 'gruvbox_dark'
    vim.g.clap_layout = {
        relative = 'editor',
        height = '80%',
        row = '11%'
    }
    vim.g.clap_disable_run_rooter = true
    vim.g.clap_enable_icon = 1
    vim.g.clap_provider_grep_enable_icon = 1
    vim.g.clap_current_selection_sign = {
        text = '',
        texthl = 'ClapCurrentSelectionSign',
        linehl = 'ClapCurrentSelection'
    }
    vim.g.clap_spinner_frames =
        { "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘" }
    vim.g.clap_provider_grep_delay = 100
end
