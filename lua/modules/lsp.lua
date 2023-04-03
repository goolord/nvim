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
        local formatting = { ["<Leader>lf"] = {function () vim.lsp.buf.format { async = true }  end, 'Formatting'} }
        wk.register(formatting, { buffer = bufnr, mode = 'n' })
        wk.register(formatting, { buffer = bufnr, mode = 'v' })
        wk.register(formatting, { buffer = bufnr, mode = 'o' })

        local gotodef = { ['<C-]>'] = { vim.lsp.buf.definition, 'Go to definition' } }
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
    lspconfig.lua_ls.setup {
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

    lspconfig.elmls.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities
    }

    lspconfig.cssls.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities
    }

end
