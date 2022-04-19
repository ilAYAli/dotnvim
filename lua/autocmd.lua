
local api = vim.api
local misc_au = api.nvim_create_augroup("misc_au", { clear = true })

--vim.api.nvim_exec([[
--  augroup misc_au
--  autocmd!
--    "autocmd BufWritePost plugins.lua PackerCompile
--    "autocmd BufReadPost * call setpos(".", getpos("'\""))
--    "autocmd BufReadPost *.log :call highlight#enable()
--
--
--    " lsp:
--    "autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
--    "autocmd CursorHold * lua vim.lsp.buf.hover()
--  augroup END
--]], false)


-- lua autocomd:
local api = vim.api
local my_au = api.nvim_create_augroup("my_au", { clear = true })

api.nvim_create_autocmd("BufReadPost", {
  command = [[call setpos(".", getpos("'\""))]],
  group = my_au,
})
api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "PackerCompile",
  group = my_au,
})


