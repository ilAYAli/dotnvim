vim.g.mapleader = ","
vim.cmd("runtime! mine/functions/**/*.vim")

vim.opt.termguicolors = true
--require 'statusline'
require'plugins'
require'options'
require'commands'
require'utils'
require'autocmd'
require'keymaps'
require 'neovide'
local theme = require'theme'.set_theme()

vim.cmd("cabbrev E e")
vim.cmd("cabbrev Build AsyncRun build")
