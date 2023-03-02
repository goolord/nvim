return function()

    local tree = require('nvim-tree')

    tree.setup {
        renderer = {
            highlight_opened_files = "name",
            -- highlight_git = true,
            indent_markers = {
                enable = true,
            },
            icons = {
                git_placement = "after",
                glyphs = {
                    default = '',
                    symlink = '',
                },
                show = {
                    git = true,
                    folder = true,
                    file = true,
                    folder_arrow = false,
                }
            }
        },
        actions = {
            open_file = {
                window_picker = {
                    exclude = {
                        filetype = {
                            "packer",
                            "qf",
                            "Trouble",
                        },
                        buftype = {
                            "terminal",
                            "help"
                        }
                    },
                },
            },
        },
        filters = {
            dotfiles = true,
        },
        git = { ignore = false },
        update_focused_file = { enable = true },
        hijack_directories = { enable = true },
        view = {
            mappings = {
                list = {
                    { key = 'l', action = "edit" },
                    { key = 'o', action = "edit" },
                    { key = '<cr>', action = "edit" },
                    { key = 'I', action = "toggle_ignored" },
                    { key = 'H', action = "toggle_dotfiles" },
                    { key = 'R', action = "refresh" },
                    { key = '=', action = "preview" },
                    { key = 'X', action = "system_open" }
                }
            }
        }
    }

end
