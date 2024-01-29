local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local my_au = augroup("my_au", { clear = true })

-- autocmd("VimEnter", {
--     group = my_au,
--     pattern = "*",
--     callback = function()
--         --vim.cmd("colorscheme nordfox")
--         require("theme").setup()
--     end
-- })

-- autocmd("ColorSchemePre", {
--     group = my_au,
--     pattern = "*",
--     callback = function()
--       require('theme').setup();
--         vim.cmd("hi clear");
--     end
-- })
--
--autocmd("ColorScheme", {
--    group = my_au,
--    pattern = "*",
--    callback = function()
--      require('theme').setup();
--        --vim.cmd("colorscheme nordfox")
--    end
--})


--vim.api.nvim_create_autocmd({'InsertEnter'}, {
--  callback = function () vim.lsp.inlay_hint(0, true) end,
--})
--
--vim.api.nvim_create_autocmd({'InsertLeave'}, {
--  callback = function () vim.lsp.inlay_hint(0, false) end,
--})

-- Persistent Folds
local save_fold = augroup("Persistent Folds", { clear = true })
autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})
autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = save_fold,
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

    -- don't indent comments: (set by ftplugins)
    vim.opt.formatoptions:remove('r')
    vim.opt.formatoptions:remove('o')
  end
})

-- autocmd("TextYankPost", {
--   group = my_au,
--   pattern = "*",
--   callback = function()
--     if vim.v.event.operator == 'y' == true and vim.v.event.regname == '' then
--       require('osc52').copy_visual()
--     end
--   end
-- })

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
