return function()

    local tree = require('nvim-tree')

    local function xdg_open(node)
        os.execute('xdg-open ' .. node.absolute_path)
    end

    tree.setup {
        renderer = {
            indent_markers = {
                enable = true,
            },
            icons = {
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
                            "qf"
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
            exclude = {'.git', 'node_modules', '.cache'},
        },
        update_focused_file = { enable = true },
        hijack_directories = { enable = true },
        view = {
            mappings = {
                list = {
                    { key='l'   , action = "edit" },
                    { key='o'   , action = "edit" },
                    { key='<cr>', action = "edit" },
                    { key='I'   , action = "toggle_ignored" },
                    { key='H'   , action = "toggle_dotfiles" },
                    { key='R'   , action = "refresh" },
                    { key='='   , action = "preview" },
                    { key='X'   , action = "xdg_open", action_cb = xdg_open }
                }
            }
        }
    }

end
