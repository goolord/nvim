return function()
    local telescope = require('telescope')

    -- Default: { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local blank_border = {
        results = { ' ', ' ', ' ͟', ' ', ' ', ' ', ' ', ' ͟' };
        prompt = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' };
        preview = { ' ͟', ' ', ' ', ' ', ' ͟', ' ͟', ' ', ' ' };
    }

    telescope.setup {
        defaults = {
            -- layout_strategy = 'bottom_pane',
            border = true,
            prompt_title = false,
            results_title = false,
            preview_title = false,
            dynamic_preview_title = true,
            borderchars = blank_border,
            path_display = { "truncate" },
            prompt_prefix = '  ',
            layout_config = {
                height = 300.0,
                width = 300.0,
                -- prompt_position="top",
            },
            selection_caret = ' ',
            entry_prefix = '  ',
            mappings = {
                i = {
                    -- map actions.which_key to <C-h> (default: <C-/>)
                    -- actions.which_key shows the mappings for your picker,
                    -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                    ["<C-h>"] = "which_key"
                },
            },
        },

        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- ["smart_case", "ignore_case", "respect_case"]
            },
            ["ui-select"] = {
                require('telescope.themes').get_cursor({
                    borderchars = blank_border,
                    layout_config = {
                        width = 60
                    },
                    initial_mode = "normal",
                }),
            },
        }
    }
    telescope.load_extension('fzf')
    telescope.load_extension('lsp_handlers')
    telescope.load_extension('ui-select')
    telescope.load_extension('neoclip')
    telescope.load_extension('hoogle')
end
