local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local my_au = augroup("my_au", { clear = true })

--autocmd("ColorScheme", {
--    group = my_au,
--    pattern = "*",
--    callback = function()
--        require("theme").set_theme()
--    end
--})

autocmd("BufReadPost", {
    group = my_au,
    pattern = "*.log",
    callback = function()
        vim.call('highlight#toggle')
    end
})

autocmd("BufReadPost", {
    group = my_au,
    pattern = "*",
    callback = function()
        vim.fn.setpos(".", vim.fn.getpos("'\""))
    end
})

autocmd("BufWritePost", {
    group = my_au,
    pattern = "plugins.lua",
    callback = function()
        vim.call("PackerCompile")
    end
})

