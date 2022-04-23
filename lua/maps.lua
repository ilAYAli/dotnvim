--[[ nmap ]]--------------------------------------------------------------------
vim.keymap.set('n', '<F1>',         "<Cmd>Telescope oldfiles<CR>")
vim.keymap.set('n', '<F2>',         ':exe "set signcolumn=" .. (&signcolumn == "yes" ? "no" : "yes")<CR>')
vim.keymap.set('n', '<c-z>',        "<Cmd>Mru<CR>")
vim.keymap.set('n', '<c-x>',        "<Cmd>MruRepos<CR>")
vim.keymap.set('n', '<F3>',         "<Cmd>lua require('telescope.builtin').git_files({show_untracked = false})<CR>")
vim.keymap.set('n', '<F4>',         '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', { silent = true })
vim.keymap.set('n', '>>',           ':lua require("telescope.builtin").lsp_workspace_symbols({query=vim.fn.expand("<cword>")})<CR>')
vim.keymap.set('n', '<F9>',         ':call PasteToggle()<CR>')
vim.keymap.set('n', '<F10>',        ':call highlight#toggle()<CR>')
vim.keymap.set('n', '<F11>',        ':MergetoolToggle<CR>')
vim.keymap.set('n', '<F12>',        ':Neogit<CR>')

-- leader:
vim.keymap.set('n', '<leader>o',    ':Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader>b',    ':Telescope buffers<CR>')
vim.keymap.set("n", '<leader>b',    ':Telescope buffers<CR>')
vim.keymap.set("n", '<leader>c',    ':Telescope command_history<CR>')
vim.keymap.set('n', '<leader>l',    ':call Mslog()<CR>')
vim.keymap.set('n', '<leader>l',    ':call highlight#enable()<CR>')
vim.keymap.set('n', '<leader>f',    ':lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>/',    ':vnew<CR>')
vim.keymap.set('n', '<leader>-',    ':split<CR>')
vim.keymap.set('n', '<leader>ws',    ':%s/\\s\\+$//<CR>')
vim.keymap.set('n', '<leader>hg',   ':TSHighlightCapturesUnderCursor<CR>')
vim.keymap.set('n', '<leader>ss',   ':Rg <c-r><c-w>')
vim.keymap.set('n', '<leader>.',     '<esc>:w!<CR>')
vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>')

vim.keymap.set('n', '<s-right>',    '<cmd>lua require("telescope.builtin").lsp_definitions({layout_strategy="vertical",layout_config={width=0.99, height=0.99}})<CR>', { silent = true })
vim.keymap.set('n', '<s-left>',     '<cmd>lua require("telescope.builtin").lsp_references()<CR>', { silent = true })
vim.keymap.set('n', '<s-up>',       '<Cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
vim.keymap.set('n', '<s-down>',     '<c-o>', { silent = true })
vim.keymap.set('n', ',<space>',     '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'K',            '<Cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'ZZ',           ':wqa!<CR>')
vim.keymap.set('n', 'QA',           ':wqa!<CR>')
vim.keymap.set('n', '*',            '*``')
vim.keymap.set('n', 's',            '<cmd>HopWord<CR>')
vim.keymap.set('n', 'gdh',          ':diffget //2<CR>')
vim.keymap.set('n', 'gdl',          ':diffget //3<CR>')

--[[ imap ]]--------------------------------------------------------------------
vim.keymap.set('i', 'jk', '<esc>', { noremap = true, silent = false})

--[[ vmap ]]--------------------------------------------------------------------
vim.keymap.set('v', '<leader>y', ':OSCYank<CR>', { noremap = true, silent = false})

--[[ tmap ]]--------------------------------------------------------------------
vim.keymap.set('t', '<c-w>h', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<c-w>j', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<c-w>k', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<c-w>l', '<c-\\><c-n><c-w>l')

