return function()
    local wk = require("which-key")
    local lspconfig = require('lspconfig')

    local function custom_on_attach(client, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local function buf_keymap(km) wk.register(km, opts) end

        -- keymaps
        buf_keymap {
            ['<C-e>'] = { function () vim.diagnostic.open_float(0, {scope="line"}) end, 'Show diagnostics' },
            K = { vim.lsp.buf.hover, 'Hover' },
            g = {
                ['['] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
                [']'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
                d = { vim.lsp.buf.definition, 'Go to definition' },
            },
            ["<Leader>"] = {
                ['fs'] = { vim.lsp.buf.workspace_symbol, 'LSP Symbol' },
                l = {
                    name = "+LSP",
                    k = { vim.lsp.buf.signature_help, 'Signature help' },
                    R = { vim.lsp.buf.rename, "Rename" },
                    a = { vim.lsp.buf.code_action, "Codeactions" },
                    c = {
                        name = "+codelens",
                        c = { vim.lsp.codelens.run, 'Run' },
                        r = { vim.lsp.codelens.refresh, 'Refresh' },
                    },
                    i = { vim.lsp.buf.implementation, 'Implementation' },
                    r = { vim.lsp.buf.references, 'References' },
                    s = {
                        name = "+set",
                        l = { vim.diagnostic.set_loclist, 'Loclist' },
                        q = { vim.diagnostic.set_qflist, 'Quickfix list' },
                    },
                    t = { vim.lsp.buf.type_definition, 'Type definition' },
                    w = {
                        name = "+workspace",
                        a = { vim.lsp.buf.add_workspace_folder, 'Add folder' },
                        l = { function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List folders' },
                        r = { vim.lsp.buf.remove_workspace_folder, 'Remove folder' },
                    },
                }
            }
        }
        wk.register( {
            ["<Leader>lf"] = {function () vim.lsp.buf.format { async = true } end, 'Formatting'},
            ['<C-]>'] = { vim.lsp.buf.definition, 'Go to definition' },
        }, { buffer = bufnr, mode = '' })

        -- bugged
        -- vim.cmd[[autocmd BufEnter,CursorHold,InsertLeave <buffer> silent! lua vim.lsp.codelens.refresh()]]
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
                plugin = {
                    hlint = { globalOn = false },
                    tactics = { globalOn = false },
                    rename = { globalOn = true },
                }
            }
        }
    } end

    if vim.bo.ft == 'rust' then lspconfig.rust_analyzer.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities
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

    if vim.bo.ft == 'fsharp' then lspconfig.fsautocomplete.setup{} end

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
