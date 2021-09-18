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
