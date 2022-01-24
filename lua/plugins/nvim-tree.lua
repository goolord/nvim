return function()

    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
    }

    vim.g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 0,
    }
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_window_picker_exclude = {
        filetype = {
            "packer",
            "qf"
        },
        buftype = {
            "terminal"
        }
    }

    local tree = require('nvim-tree')
    local tree_cb = require('nvim-tree.config').nvim_tree_callback

    tree.setup {
        ignore = {'.git', 'node_modules', '.cache'},
        update_focused_file = { enable = true },
        update_to_buf_dir = { enable = true },
        view = {
            mappings = {
                list = {
                    { key='l'   , cb=tree_cb("edit") },
                    { key='o'   , cb=tree_cb("edit") },
                    { key='<cr>', cb=tree_cb("edit") },
                    { key='I'   , cb=tree_cb("toggle_ignored") },
                    { key='H'   , cb=tree_cb("toggle_dotfiles") },
                    { key='R'   , cb=tree_cb("refresh") },
                    { key='='   , cb=tree_cb("preview") }
                }
            }
        }
    }

end
