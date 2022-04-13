return function()
    local wk = require("which-key")
    local lspconfig = require('lspconfig')

    local function custom_on_attach(client, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local function buf_keymap(km) wk.register(km, opts) end

        -- keymaps
        buf_keymap {
            ['<C-e>'] = { ':lua vim.diagnostic.open_float(0, {scope="line"})<CR>', 'Show diagnostics' },
            K = { ':lua vim.lsp.buf.hover()<CR>', 'Hover' },
            g = {
                ['['] = { ':lua vim.diagnostic.goto_prev()<CR>', 'Previous diagnostic' },
                [']'] = { ':lua vim.diagnostic.goto_next()<CR>', 'Next diagnostic' },
                d = { ':lua vim.lsp.buf.definition()<CR>', 'Go to definition' },
            },
            ["<Leader>"] = {
                ['fs'] = { ':lua vim.lsp.buf.workspace_symbol()<CR>', 'LSP Symbol' },
                l = {
                    name = "+LSP",
                    k = { ':lua vim.lsp.buf.signature_help()<CR>', 'Signature help' },
                    R = { ':lua vim.lsp.buf.rename()<CR>', "Rename" },
                    a = { ':lua vim.lsp.buf.code_action()<CR>', "Codeactions" },
                    c = {
                        name = "+codelens",
                        c = { ':lua vim.lsp.codelens.run()<CR>', 'Run' },
                        r = { ':lua vim.lsp.codelens.refresh()<CR>', 'Refresh' },
                    },
                    i = { ':lua vim.lsp.buf.implementation()<CR>', 'Implementation' },
                    r = { ':lua vim.lsp.buf.references()<CR>', 'References' },
                    s = {
                        name = "+set",
                        l = { ':lua vim.diagnostic.set_loclist()<CR>', 'Loclist' },
                        q = { ':lua vim.diagnostic.set_qflist()<CR>', 'Quickfix list' },
                    },
                    t = { ':lua vim.lsp.buf.type_definition()<CR>', 'Type definition' },
                    w = {
                        name = "+workspace",
                        a = { ':lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add folder' },
                        l = { ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List folders' },
                        r = { ':lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove folder' },
                    },
                }
            }
        }
        local formatting = { ["<Leader>lf"] = {':lua vim.lsp.buf.formatting()<CR>', 'Formatting'} }
        wk.register(formatting, { buffer = bufnr, mode = 'n' })
        wk.register(formatting, { buffer = bufnr, mode = 'v' })
        wk.register(formatting, { buffer = bufnr, mode = 'o' })

        local gotodef = { ['<C-]>'] = { ':lua vim.lsp.buf.definition()<CR>', 'Go to definition' } }
        wk.register(gotodef, { buffer = bufnr, mode = 'n' })
        wk.register(gotodef, { buffer = bufnr, mode = 'v' })

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
