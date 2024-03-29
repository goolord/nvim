return function()
    local cmp = require('cmp')
    local cmp_buffer = require('cmp_buffer')
    local compare = require('cmp.config.compare')
    local lspkind = require('lspkind')

    cmp.setup {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },

        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = lspkind.presets.default[vim_item.kind]
                if entry.source.name == 'cmp_tabnine' then
                    vim_item.kind = ''
                end
                return vim_item
            end
        },

        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
        },

        sources = {
            { name = 'nvim_lsp' },
            { name = 'cmp_tabnine' },
            -- { name = 'emoji' },
            -- { name = 'tags' },
            { name = 'path' },
            { name = 'luasnip' },
            {
                name = 'buffer',
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                }
            },
        };

        -- sorting = {
        --     comparators = {
        --                 compare.offset,
        --                 compare.exact,
        --                 -- compare.scopes,
        --                 compare.score,
        --                 compare.recently_used,
        --                 compare.locality,
        --                 compare.kind,
        --                 compare.sort_text,
        --                 compare.length,
        --                 compare.order,
        --                 compare.locality
        --         -- The rest of your comparators...
        --     }
        -- };

        -- experimental = { ghost_text = true },
        -- view = { entries = "native" },

        enabled = function()
            return vim.o.bt == ''
        end
    }

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' }
        }),
        enabled = true,
    })

end
