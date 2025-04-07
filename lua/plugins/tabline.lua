local fn = vim.fn
local M = {}
local icons = require('mini.icons')

local function highlight(text, group)
    return table.concat({'%#', group, '#', text, '%*'})
end

local active_tab = 'TabLineSel'
local inactive_tab = 'TabLine'
local default_name = '[No Name]'
local separator = '%='

local function get_extension(f)
    local match = f:match("^.+(%..+)$")
    local ext = ""
    if match ~= nil then
        ext = match:sub(2)
    end
    return ext
end

function M.render()
    local tabline = {}

    for tab = 1, fn.tabpagenr('$') do
        local winnr = fn.tabpagewinnr(tab)
        local buflist = fn.tabpagebuflist(tab)
        local bufnr = buflist[winnr]
        local bufname = fn.bufname(bufnr)

        if bufname == '' then
            bufname = default_name
        else
            bufname = fn.fnamemodify(bufname, ':t'):gsub('%%', '%%%%')
        end

        local modified = fn.getbufvar(bufnr, '&mod')

        local ext = get_extension(bufname)

        table.insert(tabline, table.concat({
            '%',
            tab,
            'T',
            '%#',
            tab == fn.tabpagenr() and active_tab or inactive_tab,
            '#',
            ' ',
            tab,
            ': ',
            icons.get_icon(bufname, ext, { default = true }),
            ' ',
            bufname,
            ' ',
            modified == 1 and '[+] ' or '',
        }))
        table.insert(tabline, '%' .. tab .. 'X󰅙 %X')
    end

    -- table.insert(tabline, "%#Pmenu#%999@v:lua.require'plugins.tabline'.tabnew@ + %X")
    table.insert(tabline, '%#TabLineFill#')
    table.insert(tabline, separator)

    return table.concat(tabline)
end

function M.tabnew () vim.cmd.tabnew() end

vim.opt.tabline = "%!v:lua.require'plugins.tabline'.render()"

return M
