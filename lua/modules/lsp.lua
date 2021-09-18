local lspconfig = require('lspconfig')

return function()

    local function custom_on_attach(client, bufnr)
        local function buf_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        -- keymaps
        buf_keymap('n', 'K'         , ':lua vim.lsp.buf.hover()<CR>'                       , {noremap = false, silent = true})
        buf_keymap('n', '<C-]>'     , ':lua vim.lsp.buf.definition()<CR>'                  , {noremap = false, silent = true})
        buf_keymap('n', 'gA'        , ':lua vim.lsp.buf.code_action()<CR>'                 , {noremap = true , silent = true})
        buf_keymap('n', 'gd'        , ':lua vim.lsp.buf.definition()<CR>'                  , {noremap = true , silent = true})
        buf_keymap('n', 'gD'        , ':lua vim.lsp.buf.type_definition()<CR>'             , {noremap = true , silent = true})
        buf_keymap('n', '<leader>fs', ':lua vim.lsp.buf.workspace_symbol()<CR>'            , {noremap = true , silent = true})
        buf_keymap('n', '<C-e>'     , ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true , silent = true})
        buf_keymap('n', 'g['        , ':lua vim.lsp.diagnostic.goto_prev()<CR>'            , {noremap = true , silent = true})
        buf_keymap('n', 'g]'        , ':lua vim.lsp.diagnostic.goto_next()<CR>'            , {noremap = true , silent = true})
        buf_keymap('n', 'gl'        , ':lua vim.lsp.diagnostic.set_loclist()<CR>'          , {noremap = true , silent = true})
        buf_keymap('n', 'gr'        , ':lua vim.lsp.buf.references()<CR>'                  , {noremap = true , silent = true})
        buf_keymap('n', 'gR'        , ':lua vim.lsp.buf.rename()<CR>'                      , {noremap = true , silent = true})
        buf_keymap('' , '<leader>F' , ':lua vim.lsp.buf.formatting()<CR>'                  , {noremap = true , silent = true})

        vim.opt_local.signcolumn = 'yes'
        -- vim.cmd('setlocal signcolumn=yes')
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
                hlintOn = false,
            }
        }
    }
    require('rust-tools').setup {
        server = {
            on_attach = custom_on_attach,
            capabilities = capabilities
        }
    }

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
