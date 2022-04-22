vim.g.mapleader = ","

vim.cmd("runtime! mine/functions/**/*.vim")

require'plugins'
require'options'
require'maps'
require'theme'
require'utils'
require'autocmd'

_G.set_theme()

vim.cmd("cabbrev E e")
vim.cmd("cabbrev Build AsyncRun build")
