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
                vim_item.kind = lspkind.presets.default[vim_item.kind]
                if entry.source.name == 'cmp_tabnine' then
                    vim_item.kind = ''
                end
                return vim_item
            end
        },

        mapping = {
            ['<C-p>'] = cmp.select_prev_item(),
            ['<C-n>'] = cmp.select_next_item(),
            ['<C-d>'] = cmp.mapping(cmp.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.complete(), { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping({
                i = cmp.abort(),
                c = cmp.close(),
            }),
            ['<CR>'] = cmp.confirm({ select = false }),
            ['<Tab>'] = cmp.mapping(cmp.select_next_item(), { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(cmp.select_prev_item(), { 'i', 's' })
        },

        sources = {
            { name = 'nvim_lsp' },
            -- { name = 'buffer' },
            { name = 'cmp_tabnine' },
            -- { name = 'emoji' },
            -- { name = 'tags' },
            { name = 'path' },
            { name = 'vsnip' },
        };

        -- experimental = { ghost_text = true },
        -- view = { entries = "native" },

        enabled = function ()
            return vim.o.bt == ''
        end
    }

    cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' }
      }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      enabled = true,
    })

end
