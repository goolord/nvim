return function()
    local wk = require("which-key")
    local lspconfig = require('lspconfig')

    local function custom_on_attach(client, bufnr)
        -- keymaps
        wk.add {
            { noremap = true, silent = true, buffer = bufnr },
            { "<C-e>", function () vim.diagnostic.open_float(0, {scope="line"}) end, desc = 'Show diagnostics' },
            { "K", vim.lsp.buf.hover, desc = 'Hover' },
            { "g[", vim.diagnostic.goto_prev, desc = 'Previous diagnostic' },
            { "g]", vim.diagnostic.goto_next, desc = 'Next diagnostic' },
            { "gd", vim.lsp.buf.definition, desc = 'Go to definition' },
            { "<Leader>fs", vim.lsp.buf.workspace_symbol, desc = 'LSP Symbol' },
            { "<Leader>l", name = "+LSP" },
            { "<Leader>lk", vim.lsp.buf.signature_help, desc = 'Signature help' },
            { "<Leader>lR", vim.lsp.buf.rename, desc = "Rename" },
            { "<Leader>la", vim.lsp.buf.code_action, desc = "Codeactions" },
            { "<Leader>lc", name = "+codelens" },
            { "<Leader>lc", vim.lsp.codelens.refresh, desc = 'Refresh' },
            { "<Leader>lc", vim.lsp.codelens.run, desc ='Run' },
            { "<Leader>li", vim.lsp.buf.implementation, desc = 'Implementation' },
            { "<Leader>lr", vim.lsp.buf.references, desc = 'References' },
            { "<Leader>ls", name = "+set" },
            { "<Leader>lsl", vim.diagnostic.set_loclist, desc= 'Loclist' },
            { "<Leader>lsq", vim.diagnostic.set_qflist, desc ='Quickfix list' },
            { "<Leader>lt", vim.lsp.buf.type_definition, desc = 'Type definition' },
            { "<Leader>lw", name = "+workspace" },
            { "<Leader>lwaa", vim.lsp.buf.add_workspace_folder, desc = 'Add folder' },
            { "<Leader>lwal", function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = 'List folders' },
            { "<Leader>lwar", vim.lsp.buf.remove_workspace_folder, desc = 'Remove folder' },
            { "<Leader>lf", function () vim.lsp.buf.format { async = true }  end, desc = 'Formatting' },
            { "<C-]>", vim.lsp.buf.definition, desc = 'Go to definition' }
        }

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
        -- cmd = { 'static-ls' },
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

    lspconfig.tsserver.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities
    }

end
