setlocal include=^import.*
setlocal includeexpr=FindModule(v:fname)[0]
" if i ever get qualified tags working
" setlocal iskeyword+=\.

function FindModule(fname)
  return systemlist('fd -p --extension hs ' . substitute(a:fname,'\\.','/','g') . '.hs')
endfunction

hi def link ConId Type

" syn match hsFunction "^\(\i\|(\)\S*"
" hi def link hsFunction Function

let g:ghcid_placement = 'right'
let g:ghcid_size = 70
let g:ghcid_keep_open = 1
