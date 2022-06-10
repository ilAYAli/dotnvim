vim.g.mapleader = ","
vim.cmd("runtime! mine/functions/**/*.vim")

local theme = require'theme'.set_theme()
require'plugins'
require'options'
require'keymaps'
require'commands'
require'utils'
require'autocmd'


vim.cmd("cabbrev E e")
vim.cmd("cabbrev Build AsyncRun build")
