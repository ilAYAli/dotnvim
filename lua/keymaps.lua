

--vim.keymap.set('n', 'J', 'gJ') -- join linjes without space
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
--vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end)
vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end)
vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
--vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)

--[[ CMDp ]]--------------------------------------------------------------------
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
--vim.keymap.set({ "i", "x", "n", "s" }, "<C-f>", ':Telescope lsp_dynamic_workspace_symbols<CR>')

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

vim.keymap.set({'n', 'x', 'v', 'i'}, '<M-v>', [["+p]])
vim.keymap.set({'n', 'x', 'v', 'i'}, '<D-v>', '<esc>"+P')

vim.keymap.set('n', '<F3>', ':Telescope lsp_dynamic_workspace_symbols<CR>')
vim.keymap.set('n', '<F4>', function()
  vim.o.signcolumn = vim.o.signcolumn == "yes" and "no" or "yes"
end)
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
vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
vim.keymap.set('v', '<C-c>', require('osc52').copy_visual)
vim.keymap.set('v', '<D-c>', require('osc52').copy_visual)

vim.keymap.set('n', '<leader>o', ':Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>')
vim.keymap.set("n", '<leader>b', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>l', ':call Mslog()<CR>')
vim.keymap.set('n', '<leader>l', ':call highlight#enable()<CR>')
vim.keymap.set('n', '<leader>ws', ':%s/\\s\\+$//<CR>')
vim.keymap.set('n', '<leader>hg', ':TSHighlightCapturesUnderCursor<CR>')
vim.keymap.set('n', '<leader>,', '<c-w>w')


--vim.keymap.set('n', '<leader>ss', ':Telescope live_grep default_text=vim.fn.expand("<cword>")')
vim.keymap.set('n', '<leader>.', '<esc>:w!<CR>')
vim.keymap.set('n', '<c-z>', '<cmd>Telescope find_files find_command=rg,--ignore,--files,--sortr,accessed<cr>')
--vim.keymap.set('n', '<c-x>', '<cmd>Telescope find_files find_command=rg,--ignore,--files,--sortr,accessed<cr>')
vim.keymap.set('n', '<c-x>', ':Telescope oldfiles<CR>')
--vim.keymap.set('n', '<c-z>', ':Telescope oldfiles<CR>')
--vim.keymap.set("n", "<c-z>", "<Cmd>Telescope frecency workspace=CWD<CR>")
--vim.keymap.set("n", "<c-x>", "<Cmd>Telescope frecency workspace=CWD<CR>")
--vim.keymap.set('n', '<c-z>', function() require("mru").display_cache({}) end)
--vim.keymap.set('n', '<c-x>', function() require("mru").display_repos({}) end)
--vim.keymap.set('n', '<c-s>', function() require("mru").display_cache({algorithm="mfu"}) end)
vim.keymap.set('n', '>>', function()
    local ts = require("telescope.builtin")
    ts.lsp_workspace_symbols({query=vim.fn.expand("<cword>")})
end)
vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end)

vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', '<leader>/', ':Telescope lsp_document_symbols<CR>')
--vim.keymap.set('n', '<leader>/', ':Telescope lsp_dynamic_workspace_symbols<CR>')
vim.keymap.set('n', '<leader>-', function() vim.fn.execute('split') end)

-- other:
vim.keymap.set('n', '<s-right>', function()
  --local ts = require("telescope.builtin").lsp_implementations()
  vim.lsp.buf.definition()
end)

vim.keymap.set('n', '<leader>t', function() require("trouble").toggle() end)


vim.keymap.set('n', '<s-left>', function()
    require("telescope.builtin").lsp_references({fname_width=70})
end)

vim.keymap.set('n', '<s-up>', function()
    vim.lsp.buf.implementation()
end)

vim.keymap.set('n', '<s-down>', '<c-o>')

vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('x', '<leader>c', require('osc52').copy_visual)

vim.keymap.set('n', 'ZZ', ':wqa!<CR>')
vim.keymap.set('n', 'QA', ':wqa!<CR>')
vim.keymap.set('n', '*', '*``')
--vim.keymap.set('n', 's', '<cmd>HopWord<CR>')
vim.keymap.set('n', 'gdh', ':diffget //2<CR>')
vim.keymap.set('n', 'gdl', ':diffget //3<CR>')

--[[ imap ]]--------------------------------------------------------------------
vim.keymap.set('i', 'jk', '<esc>')

--[[ tmap ]]--------------------------------------------------------------------
vim.keymap.set('t', '<c-w>h', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<c-w>j', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<c-w>k', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<c-w>l', '<c-\\><c-n><c-w>l')
