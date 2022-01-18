return function()
    -- Expand or jump
    vim.keymap.set('i', '<C-l>', "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'", {expr=true, remap=true})
end
