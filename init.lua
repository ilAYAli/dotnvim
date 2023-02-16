if vim.g.vscode then
  return
end

vim.g.mapleader = ","
vim.cmd("runtime! mine/functions/**/*.vim")

vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
     "git",
     "clone",
     "--filter=blob:none",
     "--single-branch",
     "https://github.com/folke/lazy.nvim.git",
     lazypath,
   })
 end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins")
require('setup')
require('autocmd')
require('options')
require('commands')
require('utils')
require('keymaps')
require('neovide')
require 'statusline'
require('theme').setup()

vim.cmd("cabbrev E e")
vim.cmd("cabbrev Build AsyncRun build")
