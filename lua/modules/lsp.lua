return function()
    local wk = require("which-key")

    local function custom_on_attach(client, bufnr)
        -- keymaps
        wk.add {
            { noremap = true, silent = true, buffer = bufnr },
            { "<C-e>", function () vim.diagnostic.open_float(0, {scope="line"}) end, desc = 'Show diagnostics' },
            { "K", vim.lsp.buf.hover, desc = 'Hover' },
            { "g[", vim.diagnostic.goto_prev, desc = 'Previous diagnostic' },
            { "g]", vim.diagnostic.goto_next, desc = 'Next diagnostic' },
            { "gd", function () Snacks.picker.lsp_definitions() end, desc = 'Go to definition' },
            { "<Leader>fs", function () Snacks.picker.lsp_workspace_symbols() end , desc = 'LSP Symbol' },
            { "<Leader>l", name = "+LSP" },
            { "<Leader>lk", vim.lsp.buf.signature_help, desc = 'Signature help' },
            { "<Leader>lR", vim.lsp.buf.rename, desc = "Rename" },
            { "<Leader>la", require("actions-preview").code_actions , desc = "Codeactions" },
            { "<Leader>lc", name = "+codelens" },
            { "<Leader>lc", vim.lsp.codelens.refresh, desc = 'Refresh' },
            { "<Leader>lc", vim.lsp.codelens.run, desc ='Run' },
            { "<Leader>li", function () Snacks.picker.lsp_implementations () end, desc = 'Implementation' },
            { "<Leader>lr", function () Snacks.picker.lsp_references () end, nowait = true, desc = 'References' },
            { "<Leader>ls", name = "+set" },
            { "<Leader>lsl", vim.diagnostic.set_loclist, desc= 'Loclist' },
            { "<Leader>lsq", vim.diagnostic.set_qflist, desc ='Quickfix list' },
            { "<Leader>lt", function () Snacks.picker.lsp_type_definitions() end, desc = 'Type definition' },
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

    local function static_ls_index_file(file)
        local queryOutput = vim.system({"sqlite3", ".hiedb", 'select hieFile from mods where hs_src = \'' .. file .. '\';' }):wait()
        local hifile = "." .. string.sub(queryOutput.stdout:gsub("\n$", ""), string.len(vim.fn.getcwd()) + 1)
        local srcBaseDir = hifile:match("(.-).hiefiles")

        vim.system({"hiedb", "-D", ".hiedb", "index", hifile, "--src-base-dir", srcBaseDir})
    end
    local function static_ls_on_attach (client, bufnr)
        local file = io.open(".hiedb", "r")
        if file then
            file:close()
        else
            vim.system({"hiedb", "init", ".hiedb"})
            vim.system({"fd", ".hiefiles", "-u", "-j", "1", "-x", "hiedb", "-D", ".hiedb", "index", "{}", "--src-base-dir", "{//}"}) -- initialize hiedb if it doesn't exist
        end
        static_ls_index_file(vim.api.nvim_buf_get_name(bufnr))
        vim.api.nvim_create_autocmd("LspNotify", {
            pattern = "*",
            callback = function (args)
                if args.data.method == 'textDocument/didSave' then
                    static_ls_index_file(args.file)
                end
            end,
        })
        custom_on_attach(client, bufnr)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    }

    vim.lsp.config("*", {
        capabilities = capabilities
    })

    vim.lsp.config("hls", {
        -- cmd = { 'static-ls' },
        -- on_attach = static_ls_on_attach,
        settings = {
            haskell = {
                plugin = {
                    hlint = { globalOn = false },
                    tactics = { globalOn = false },
                    rename = { globalOn = true },
                }
            }
        }
    })

    local runtime_path = {}
    vim.lsp.config("lua_ls", {
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
    })

    vim.lsp.config("elmls", {})
    vim.lsp.config("cssls", {})
    vim.lsp.config("ts_ls", {})
    vim.lsp.config("sourcekit", {})
    vim.lsp.config("rust_analyzer", {})
    vim.lsp.config("purescriptls", {})

    vim.lsp.enable {
        "sourcekit", "ts_ls", "cssls", "elmls", "lua_ls",
        "purescriptls", "rust_analyzer", "hls"
    }

    vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*",
        callback = function (args)
            custom_on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
        end,
    })

end
