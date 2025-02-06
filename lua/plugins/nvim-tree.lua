return function()
    local function hl(group, options)
        vim.api.nvim_set_hl(0, group, options)
    end
    local tree = require('nvim-tree')

    local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "l"   , api.node.open.edit         , opts("Edit"))
        vim.keymap.set("n", "o"   , api.node.open.edit         , opts("Edit"))
        vim.keymap.set("n", "<cr>", api.node.open.edit         , opts("Edit"))
        vim.keymap.set("n", "I"   , api.tree.toggle_gitignore_filter, opts("Toggle ignored"))
        vim.keymap.set("n", "H"   , api.tree.toggle_hidden_filter   , opts("Toggle dotfiles"))
        vim.keymap.set("n", "R"   , api.tree.reload            , opts("Refresh"))
        vim.keymap.set("n", "="   , api.node.open.preview      , opts("Preview"))
        vim.keymap.set("n", "X"   , api.node.run.system        , opts("System open"))
        vim.keymap.set("n", "?"   , api.tree.toggle_help       , opts("Help"))
    end

    tree.setup {
        on_attach = my_on_attach,
        renderer = {
            highlight_opened_files = "name",
            highlight_git = true,
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
    }

    hl('NvimTreeGitFileDirtyHL', {})
    hl('NvimTreeGitFileStagedHL', {})
end
