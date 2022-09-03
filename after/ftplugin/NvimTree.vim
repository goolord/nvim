hi Cursor blend=100
setlocal nowrap

" hide cursor on Nvim Tree
augroup HideCursor
  au!
  au BufWinEnter,WinEnter,CmdLineLeave <buffer> set guicursor=a:block-Cursor/Cursor-blinkon0,
  au BufLeave,WinClosed,WinLeave,CmdLineEnter <buffer> set guicursor&
augroup END

au BufWinEnter <buffer> setlocal fillchars=vert:\ ,eob:\ 
