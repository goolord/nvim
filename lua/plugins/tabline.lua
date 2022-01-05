local fn = vim.fn
local M = {}
local lsp = vim.lsp
local icons = require("nvim-web-devicons")

local forced_space = string.char(226, 128, 130)

local function highlight(text, group)
    return table.concat({'%#', group, '#', text, '%*'})
end

local active_tab = 'TabLineSel'
local inactive_tab = 'TabLine'
local default_name = '[No Name]'
local separator = '%='
local lsp_hl = 'TabLine'

local function get_extension(f)
    local match = f:match("^.+(%..+)$")
    local ext = ""
    if match ~= nil then
        ext = match:sub(2)
    end
    return ext
end

local function lsp_status()
    local statuses = {}

    for _, msg in ipairs(lsp.util.get_progress_messages()) do
        if not msg.done and not statuses[msg.name] then
            local status = msg.title

            if msg.percentage then
                status = status .. ' ' .. msg.percentage .. '%%'
            end

            statuses[msg.name] = status
        end
    end

    for _, client in ipairs(lsp.get_active_clients()) do
        if not statuses[client.name] then
            statuses[client.name] = 'active'
        end
    end

    if vim.tbl_isempty(statuses) then
        return ''
    end

    local cells = {}
    local names = {}

    -- This ensures clients are always displayed in a consistent order.
    for name, _ in pairs(statuses) do
        table.insert(names, name)
    end

    table.sort(names, function(a, b)
        return a < b
    end)

    for _, name in ipairs(names) do
        local status = statuses[name]
        local text = name .. ': ' .. status

        table.insert(cells, text)
    end

    return forced_space
    .. highlight(table.concat(cells, ', '), lsp_hl)
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
        table.insert(tabline, '%' .. tab .. 'X %X')
    end

    -- table.insert(tabline, "%#TabLine#%999@v:lua.require'plugins.tabline'.tabnew@ + %X")
    table.insert(tabline, '%#TabLineFill#')
    table.insert(tabline, separator)
    table.insert(tabline, lsp_status())

    return table.concat(tabline)
end

function M.tabnew()
    vim.cmd('tabnew')
end

vim.cmd('autocmd User LspProgressUpdate redrawtabline')
vim.opt.tabline = "%!v:lua.require'plugins.tabline'.render()"

return M
