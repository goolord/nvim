return function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn['vsnip#anonymous'](args.body)
            end
        },

        formatting = {
            format = function(entry, vim_item)
                -- vim_item.menu = ({
                --     nvim_lsp = '[L]',
                --     buffer   = '[B]',
                -- })[entry.source.name]
                vim_item.kind = lspkind.presets.default[vim_item.kind]
                return vim_item
            end
        },

        completion = {
            trim_match = false,
        },

        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
        },

        sources = {
            -- { name = 'buffer' },
            { name = 'cmp_tabnine' },
            { name = 'nvim_lsp' },
            -- { name = 'emoji' },
            -- { name = 'tags' },
            { name = 'path' },
            { name = 'calc' },
            { name = 'vsnip' },
        };
    }

end
