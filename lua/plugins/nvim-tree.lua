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

    local tree = require('nvim-tree')

    local function xdg_open(node)
        os.execute('xdg-open ' .. node.absolute_path)
    end

    tree.setup {
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
        ignore = {'.git', 'node_modules', '.cache'},
        update_focused_file = { enable = true },
        update_to_buf_dir = { enable = true },
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
