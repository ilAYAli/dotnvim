vim.g.mapleader = ","
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.cmd("runtime! mine/functions/**/*.vim")

require'plugins'
require'options'
require'keymaps'
require'theme'
require'utils'
require'autocmd'

_G.set_theme()

vim.cmd("cabbrev E e")
vim.cmd("cabbrev Build AsyncRun build")
