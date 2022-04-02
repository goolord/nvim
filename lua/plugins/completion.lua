return function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local tabnine = require('cmp_tabnine.config')
    tabnine:setup {
        show_prediction_strength = false
    }

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
                select = false,
            }),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
        },

        sources = {
            -- { name = 'buffer' },
            { name = 'nvim_lsp' },
            { name = 'cmp_tabnine' },
            -- { name = 'emoji' },
            -- { name = 'tags' },
            { name = 'path' },
            { name = 'vsnip' },
        };

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
