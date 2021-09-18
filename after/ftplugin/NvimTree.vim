hi NvimTreeNormal guibg=#1d2021
hi Cursor blend=100

" hide cursor on Nvim Tree
augroup HideCursor
  au!
  au BufWinEnter,WinEnter,CmdLineLeave <buffer> set guicursor=a:block-Cursor/Cursor-blinkon0,
  au BufLeave,WinClosed,WinLeave,CmdLineEnter <buffer> set guicursor&
  " au BufWinEnter,WinEnter <buffer> call v:lua.alpha_redraw()
  " this one don't work
  " au BufLeave,WinClosed,WinLeave <buffer> call v:lua.alpha_redraw()
augroup END
