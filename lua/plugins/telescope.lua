return function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    local blank_border = {
        results =  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' };
        prompt =  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' };
        preview = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' };
    }

    telescope.setup {
        defaults = {
            border = true,
            prompt_title = false,
            results_title = false,
            preview_title = false,
            dynamic_preview_title = true,
            borderchars = blank_border,
            prompt_prefix = '',
            layout_config = {
                width = 0.85,
            },
            mappings = {
                n = {
                    ["gg"] = actions.move_to_top,
                    ["G"] = actions.move_to_bottom,
                }
            },
            selection_caret = ' ',
            entry_prefix = ' ',
        },

        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- ["smart_case", "ignore_case", "respect_case"]
            },

            lsp_handlers = {
                code_action = {
                    telescope = require('telescope.themes').get_cursor({
                        borderchars = blank_border,
                        layout_config = {
                            width = 55
                        },
                        -- initial_mode = "normal",
                    }),
                },
            },
        }
    }
    telescope.load_extension('fzf')
    telescope.load_extension('lsp_handlers')
    telescope.load_extension('sessions')
end

