vim.g.mapleader = ","
vim.cmd("runtime! mine/functions/**/*.vim")

local theme = require'theme'.set_theme()
--require 'statusline'
require'plugins'
require'options'
require'commands'
require'utils'
require'autocmd'
require'keymaps'

vim.cmd("cabbrev E e")
vim.cmd("cabbrev Build AsyncRun build")
