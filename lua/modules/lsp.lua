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
        local formatting = { ["<Leader>lf"] = {':lua vim.lsp.buf.format { async = true } <CR>', 'Formatting'} }
        wk.register(formatting, { buffer = bufnr, mode = 'n' })
        wk.register(formatting, { buffer = bufnr, mode = 'v' })
        wk.register(formatting, { buffer = bufnr, mode = 'o' })

        local gotodef = { ['<C-]>'] = { ':lua vim.lsp.buf.definition()<CR>', 'Go to definition' } }
        wk.register(gotodef, { buffer = bufnr, mode = 'n' })
        wk.register(gotodef, { buffer = bufnr, mode = 'v' })

        if client.server_capabilities.code_lens then
            vim.cmd.amenu('PopUp.Run\\ Codelens :lua vim.lsp.codelens.run()<CR>')
            vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {
                pattern = "<buffer>",
                callback = function ()
                    vim.lsp.codelens.refresh()
                end,
            })
        end
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

    lspconfig.hls.setup {
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
    }

    lspconfig.rust_analyzer.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities
    }

    lspconfig.purescriptls.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities
    }

    local runtime_path = {}
    lspconfig.sumneko_lua.setup {
        on_attach = function(client, bufnr)
            runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")
            custom_on_attach(client, bufnr)
        end,
        cmd = {'lua-language-server'};
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

    lspconfig.elmls.setup{
        on_attach = custom_on_attach,
        capabilities = capabilities
    }
end
