-- gui
vim.opt.showmode      = false
vim.opt.cursorline    = true
vim.opt.number        = true
vim.opt.termguicolors = true
vim.opt.title         = true
vim.opt.foldenable    = false
vim.opt.linebreak     = true
vim.opt.pumblend      = 10
vim.opt.pumheight     = 15
vim.opt.wrap          = true
vim.opt.signcolumn    = 'number'
vim.opt.list          = true
vim.opt.listchars     = { trail = '.', tab = '»-»' }
-- vim.opt.smoothscroll  = true
-- gui frontend
vim.opt.guifont       = 'monospace:h16.4'
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_refresh_rate = 120
vim.g.neovide_scroll_animation_length = 0
-- behavior
vim.opt.complete      = nil
vim.opt.completeopt   = 'menu,menuone,noselect'
vim.opt.grepprg       = 'rg --vimgrep --follow --no-heading'
vim.opt.hidden        = true
vim.opt.inccommand    = 'nosplit'
vim.opt.lazyredraw    = true
vim.opt.mouse         = 'a'
vim.opt.scrolloff     = 5
vim.opt.shortmess     = 'atToOc'
vim.opt.sidescrolloff = 10
vim.opt.timeoutlen    = 400
vim.opt.ttimeoutlen   = 50
-- tabs
vim.opt.tabstop       = 4
vim.opt.softtabstop   = 2
vim.opt.shiftwidth    = 2
vim.opt.expandtab     = true
-- fs
vim.opt.undofile      = true
vim.opt.undolevels    = 1000
vim.opt.undoreload    = 10000
vim.opt.writebackup   = true

vim.cmd.syntax('sync minlines=256')

-- Ensure Neovim uses PowerShell when spawning subshells on Windows
if vim.fn.has("win32") == 1 then
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end

require('modules.diagnostic')
