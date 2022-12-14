local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local my_au = augroup("my_au", { clear = true })

autocmd("ColorScheme", {
    group = my_au,
    pattern = "*",
    callback = function()
        require("theme").set_theme()
    end
})

autocmd("BufReadPost", {
    group = my_au,
    pattern = "*.log",
    callback = function()
        vim.fn['highlight#toggle']()
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
        vim.cmd.PackerCompile()
    end
})

autocmd("TextYankPost", {
    group = my_au,
    pattern = "*",
    callback = function()
      if vim.v.event.operator == 'y' == true and vim.v.event.regname == '' then
         require('osc52').copy_visual()
      end
    end
})

autocmd("RecordingEnter", {
    group = my_au,
    pattern = "*",
    callback = function()
      print("recording");
      vim.o.cmdheight = 1
    end
})
autocmd("RecordingLeave", {
    group = my_au,
    pattern = "*",
    callback = function()
      vim.o.cmdheight = 0
    end
})
