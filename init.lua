vim.g.mapleader = ","
vim.fn.mkdir(vim.env.HOME .. '/.cache/', 'p')

vim.cmd("runtime! mine/functions/**/*.vim")

require'plugins'
require'options'
require'maps'
require'theme'
require'utils'

vim.api.nvim_exec([[
  augroup misc_au
  autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
    autocmd BufWritePost plugins.lua PackerCompile

    autocmd BufReadPost *.log :call highlight#enable()

    " lsp:
    "autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
    "autocmd CursorHold * lua vim.lsp.buf.hover()
  augroup END
]], false)

_G.set_theme()
-- abbreviations:
vim.cmd("cabbrev E e")
vim.cmd("cabbrev Build AsyncRun build")
