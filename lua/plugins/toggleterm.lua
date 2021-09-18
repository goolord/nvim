return function()
    require"toggleterm".setup {
      direction = 'vertical',
      hide_numbers = true,
      insert_mappings = false,
      open_mapping = [[<Leader>tt]],
      persist_size = true,
      shade_filetypes = {},
      shade_terminals = true,
      size = vim.o.columns * 0.5,
      start_in_insert = false,
    }
end
