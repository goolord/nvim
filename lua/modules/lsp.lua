return function()
    local lspconfig = require('lspconfig')

    local function custom_on_attach(client, bufnr)
        local function buf_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        -- keymaps
        buf_keymap('n', 'K'         , ':lua vim.lsp.buf.hover()<CR>'                   , {noremap = false, silent = true})
        buf_keymap('n', '<C-]>'     , ':lua vim.lsp.buf.definition()<CR>'              , {noremap = false, silent = true})
        buf_keymap('n', 'gA'        , ':lua vim.lsp.buf.code_action()<CR>'             , {noremap = true , silent = true})
        buf_keymap('n', 'gd'        , ':lua vim.lsp.buf.definition()<CR>'              , {noremap = true , silent = true})
        buf_keymap('n', 'gD'        , ':lua vim.lsp.buf.type_definition()<CR>'         , {noremap = true , silent = true})
        buf_keymap('n', '<leader>fs', ':lua vim.lsp.buf.workspace_symbol()<CR>'        , {noremap = true , silent = true})
        buf_keymap('n', 'gr'        , ':lua vim.lsp.buf.references()<CR>'              , {noremap = true , silent = true})
        buf_keymap('n', 'gR'        , ':lua vim.lsp.buf.rename()<CR>'                  , {noremap = true , silent = true})
        buf_keymap('' , '<leader>F' , ':lua vim.lsp.buf.formatting()<CR>'              , {noremap = true , silent = true})
        buf_keymap('n', '<C-e>'     , ':lua vim.diagnostic.show_line_diagnostics()<CR>', {noremap = true , silent = true})
        buf_keymap('n', 'g['        , ':lua vim.diagnostic.goto_prev()<CR>'            , {noremap = true , silent = true})
        buf_keymap('n', 'g]'        , ':lua vim.diagnostic.goto_next()<CR>'            , {noremap = true , silent = true})
        buf_keymap('n', 'gl'        , ':lua vim.diagnostic.set_loclist()<CR>'          , {noremap = true , silent = true})
        buf_keymap('n', 'gq'        , ':lua vim.diagnostic.set_qflist()<CR>'           , {noremap = true , silent = true})
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    }

    if vim.bo.ft == 'haskell' then lspconfig.hls.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities,
        settings = {
            haskell = {
                hlintOn = false,
            }
        }
    } end

    if vim.bo.ft == 'rust' then require('rust-tools').setup {
        tools = {
            autoSetHints = false,
            hover_with_actions = false,
        },
        server = {
            on_attach = custom_on_attach,
            capabilities = capabilities
        }
    } end

    if vim.bo.ft == 'lua' then
        local sumneko_root_path = 'usr/share/lua-language-server'
        local sumneko_binary = '/usr/bin/lua-language-server'

        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")

        lspconfig.sumneko_lua.setup {
            on_attach = custom_on_attach,
            cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = runtime_path,
                    },
                    diagnostics = {
                        globals = {'vim'},
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = { enable = false },
                },
            },
        }
    end

    if vim.bo.ft == 'lean' then require('lean').setup {
        -- Enable the Lean language server(s)?
        --
        -- false to disable, otherwise should be a table of options to pass to
        --  `leanls` and/or `lean3ls`.
        --
        -- See https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#leanls for details.

        -- Lean 4
        lsp = { on_attach = custom_on_attach },

        -- Abbreviation support
        abbreviations = {
            -- Set one of the following to true to enable abbreviations
            builtin = true, -- built-in expander
            compe = false, -- nvim-compe source
            snippets = false, -- snippets.nvim source
            -- additional abbreviations:
            extra = {
                -- Add a \wknight abbreviation to insert ♘
                --
                -- Note that the backslash is implied, and that you of
                -- course may also use a snippet engine directly to do
                -- this if so desired.
                wknight = '♘',
            },
            -- Change if you don't like the backslash
            -- (comma is a popular choice on French keyboards)
            leader = ' ',
        },

        -- Enable suggested mappings?
        --
        -- false by default, true to enable
        mappings = true,

        -- Infoview support
        infoview = {
            -- Automatically open an infoview on entering a Lean buffer?
            autoopen = true,
            -- Set the infoview windows' widths
            width = 50,
        },

        -- Progress bar support
        progress_bars = {
            -- Enable the progress bars?
            enable = true,
            -- Use a different priority for the signs
            priority = 10,
        },
    } end
end
