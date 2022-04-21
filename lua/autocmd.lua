
local api = vim.api
local my_au = api.nvim_create_augroup("my_au", { clear = true })

api.nvim_create_autocmd("BufWritePost", {
    group = my_au,
    pattern = "plugins.lua",
    command = "PackerCompile",
})

api.nvim_create_autocmd("BufReadPost", {
    group = my_au,
    pattern = "*.log",
    command = "call highlight#enable()",
})

api.nvim_create_autocmd("BufReadPost", {
    group = my_au,
    pattern = "*",
    command = [[call setpos(".", getpos("'\""))]],
})
api.nvim_create_autocmd("BufWritePost", {
    group = my_au,
    pattern = "plugins.lua",
    command = "PackerCompile",
})

-- api.nvim_create_autocmd("CursorHold", {
--     group = my_au,
--     pattern = "*",
--     callback = function()
--         vim.lsp.buf.hover()
--     end
-- })

