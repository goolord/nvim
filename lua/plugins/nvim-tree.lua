return function()
    local tree = require('nvim-tree')
    local tree_cb = require('nvim-tree.config').nvim_tree_callback

    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
    }

    vim.g.nvim_tree_show_icons = {
        folder_arrows = 0,
    }

    tree.setup {
        ignore = {'.git', 'node_modules', '.cache'},
        update_focused_file = { enable = true },
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

    vim.cmd[[
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'cd '.argv()[0] | execute 'NvimTreeOpen' | wincmd p | q | endif
    ]]
end
