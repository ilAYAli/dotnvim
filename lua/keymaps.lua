--[[ nmap ]]--------------------------------------------------------------------

-- function keys:
vim.keymap.set('n', '<F1>', function()
    -- vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
    if vim.o.signcolumn == "no" then
        vim.o.signcolumn = "yes"
        vim.diagnostic.enable()
    else
        vim.o.signcolumn = "no"
        vim.diagnostic.disable()
    end
end)

vim.keymap.set('n', '<F1>', ":bp<CR>")
vim.keymap.set('n', '<F2>', ":bn<CR>")

vim.keymap.set('n', '<F3>', ':Telescope lsp_dynamic_workspace_symbols<CR>')
vim.keymap.set('n', '<F4>', ':call PasteToggle()<CR>')
vim.keymap.set('n', '<F10>', ':call highlight#toggle()<CR>')
vim.keymap.set('n', '<F12>', ':MergetoolToggle<CR>')

-- leader:
--vim.keymap.set('n', 'D', ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '<leader>v', function()
    if vim.g.vtext_enabled == nil or vim.g.vtext_enabled then
        vim.g.vtext_enabled = false
        vim.diagnostic.config({virtual_text = vim.g.vtext_enabled})
    else
        vim.g.vtext_enabled = true
        vim.diagnostic.config({virtual_text = vim.g.vtext_enabled})
    end
end)
-- start disabled:
--vim.api.nvim_feedkeys(",v", "m", true)

vim.keymap.set('n', '<leader>o', ':Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>')
vim.keymap.set("n", '<leader>b', ':Telescope buffers<CR>')
vim.keymap.set("n", '<leader>c', ':Telescope command_history<CR>')
vim.keymap.set('n', '<leader>l', ':call Mslog()<CR>')
vim.keymap.set('n', '<leader>l', ':call highlight#enable()<CR>')
vim.keymap.set('n', '<leader>ws', ':%s/\\s\\+$//<CR>')
vim.keymap.set('n', '<leader>hg', ':TSHighlightCapturesUnderCursor<CR>')
vim.keymap.set('n', '<leader>ss', ':Rg <c-r><c-w>')
vim.keymap.set('n', '<leader>.', '<esc>:w!<CR>')
vim.keymap.set('v', '<leader>y', ':OSCYank<CR>')
vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.rename() end)
vim.keymap.set('n', '<c-z>', function() require("mru").display_cache({}) end)
vim.keymap.set('n', '<c-x>', function() require("mru").display_repos({}) end)
vim.keymap.set('n', '<c-s>', function() require("mru").display_cache({algorithm="mfu"}) end)
vim.keymap.set('n', '>>', function()
    local ts = require("telescope.builtin")
    ts.lsp_workspace_symbols({query=vim.fn.expand("<cword>")})
end)

vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', '<leader>/', function() vim.fn.execute('vnew') end)
vim.keymap.set('n', '<leader>-', function() vim.fn.execute('split') end)

-- other:
vim.keymap.set('n', '<s-right>', function()
    local ts = require("telescope.builtin")
    ts.lsp_definitions({layout_strategy="vertical",layout_config={width=0.99, height=0.99}})
end)

vim.keymap.set('n', '<s-left>', function()
    local ts = require("telescope.builtin")
    ts.lsp_references()
end)

vim.keymap.set('n', '<s-up>', function()
    vim.lsp.buf.implementation()
end)

vim.keymap.set('n', '<s-down>', '<c-o>')
vim.keymap.set('n', ',<space>', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)
vim.keymap.set('n', 'ZZ', ':wqa!<CR>')
vim.keymap.set('n', 'QA', ':wqa!<CR>')
vim.keymap.set('n', '*', '*``')
vim.keymap.set('n', 's', '<cmd>HopWord<CR>')
vim.keymap.set('n', 'gdh', ':diffget //2<CR>')
vim.keymap.set('n', 'gdl', ':diffget //3<CR>')

--[[ imap ]]--------------------------------------------------------------------
vim.keymap.set('i', 'jk', '<esc>')

--[[ tmap ]]--------------------------------------------------------------------
vim.keymap.set('t', '<c-w>h', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<c-w>j', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<c-w>k', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<c-w>l', '<c-\\><c-n><c-w>l')

