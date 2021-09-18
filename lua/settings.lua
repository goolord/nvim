vim.opt.bg            = 'dark'
vim.opt.completeopt   = 'menu,menuone,noselect'
vim.opt.cursorline    = true
vim.opt.directory     = os.getenv('HOME') .. '/.swap/'
vim.opt.errorbells    = false
vim.opt.expandtab     = true
vim.opt.foldenable    = false
vim.opt.grepprg       = 'rg --vimgrep --follow --no-heading'
vim.opt.guifont       = 'monospace:h16.4'
vim.opt.hidden        = true
vim.opt.inccommand    = 'nosplit'
vim.opt.lazyredraw    = true
vim.opt.linebreak     = true
vim.opt.list          = true
vim.opt.listchars     = 'tab:»-»'
vim.opt.mouse         = 'a'
vim.opt.number        = true
vim.opt.omnifunc      = 'syntaxcomplete#Complete'
vim.opt.pumblend      = 10
vim.opt.pumheight     = 15
vim.opt.pyxversion    = 3
vim.opt.scrolloff     = 5
vim.opt.shiftwidth    = 2
vim.opt.shortmess     = 'atToOc'
vim.opt.showmode      = false
vim.opt.sidescrolloff = 10
vim.opt.softtabstop   = 2
vim.opt.startofline   = false
vim.opt.tabstop       = 2
vim.opt.termguicolors = true
vim.opt.title         = true
vim.opt.ttimeoutlen   = 50
vim.opt.undodir       = os.getenv('HOME') .. '/.swap/'
vim.opt.undofile      = true
vim.opt.undolevels    = 1000
vim.opt.undoreload    = 10000
vim.opt.updatetime    = 300
vim.opt.wildmode      = 'full'
vim.opt.wildoptions   = 'pum'
vim.opt.winblend      = 0
vim.opt.wrap          = true
vim.opt.writebackup   = true

vim.cmd('syntax sync minlines=256')

vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.vimsyn_embed = 'l'

vim.g.neovide_cursor_animation_length = 0

require('modules.diagnostic')
require('modules.colors')
