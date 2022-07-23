vim.api.nvim_create_user_command('GG',
function(opts)
    local needle = vim.fn.expand("<cword>")
    if #opts.fargs > 0 then
        needle = table.concat(opts.fargs, " ")
    end
    require("telescope.builtin").grep_string({search=needle, layout_strategy="vertical",layout_config={width=0.99, height=0.99}})
end, { nargs = '*' })
vim.keymap.set('n', '<leader>ss', ':GG')
