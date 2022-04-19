--[[
################################################################################
map commands
'n'     mapmode-n     Normal                                               :nmap
'v'     mapmode-v     Visual and Select                                    :vmap
's'     mapmode-s     Select                                               :smap
'x'     mapmode-x     Visual                                               :xmap
'o'     mapmode-o     Operator-pending                                     :omap
'!'     mapmode-ic     Insert and Command-line                             :map!
'i'     mapmode-i     Insert                                               :imap
'l'     mapmode-l     Insert, Command-line, Lang-Arg                       :lmap
'c'     mapmode-c     Command-line                                         :cmap
't'     mapmode-t     Terminal                                             :tmap
################################################################################
--]]

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--[[
################################################################################
nmap, normal mode:
################################################################################
--]]


local opts = { noremap=true, silent=true }
-- function keys:
vim.api.nvim_set_keymap('n', '<F1>',    "<Cmd>Telescope oldfiles<CR>", opts)
vim.api.nvim_set_keymap('n', '<c-z>',   "<Cmd>Mru<CR>", opts)
vim.api.nvim_set_keymap('n', '<c-x>',   "<Cmd>Mfu<CR>", opts)
vim.api.nvim_set_keymap('n', '<F3>',    "<Cmd>lua require('telescope.builtin').git_files({show_untracked = false})<CR>", opts)
vim.api.nvim_set_keymap('n', '<F4>',    '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '>>',    ':lua require("telescope.builtin").lsp_workspace_symbols({query=vim.fn.expand("<cword>")})<CR>', opts)
vim.api.nvim_set_keymap('n', '<F9>',    ":call PasteToggle()<CR>",  opts)
vim.api.nvim_set_keymap('n', '<F10>',   ":call highlight#toggle()<CR>",  opts)
vim.api.nvim_set_keymap('n', '<F11>',   ":MergetoolToggle<CR>", opts)
vim.api.nvim_set_keymap('n', '<F12>',   ":Neogit<CR>",  opts)

-- LSP:
vim.api.nvim_set_keymap('n', '<s-right>',  '<cmd>lua require("telescope.builtin").lsp_definitions({layout_strategy="vertical",layout_config={width=0.99, height=0.99}})<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<s-left>',  '<cmd>lua require("telescope.builtin").lsp_references()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<s-up>',    '<Cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<s-down>',  '<c-o>', { silent = true })
vim.api.nvim_set_keymap('n', ',<space>',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K',         '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 's',         '<cmd>HopWord<CR>', opts)

-- vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

-- misc:
vim.api.nvim_set_keymap('n', 'ZZ', ':wqa!<CR>', opts)
vim.api.nvim_set_keymap('n', 'QA', ':wqa!<CR>', opts)
vim.api.nvim_set_keymap('n', '*', '*``', opts)


-- git merge:
vim.api.nvim_set_keymap('n', 'gdh',         ':diffget //2<CR>', opts)
vim.api.nvim_set_keymap('n', 'gdl',         ':diffget //3<CR>', opts)

-- leader:
vim.api.nvim_set_keymap('n', '<leader>o',   ':Telescope oldfiles<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<leader>b',   ':Telescope buffers<CR>', { noremap = true, silent = false})
vim.api.nvim_set_keymap("n", '<leader>b',   ':Telescope buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", '<leader>c',   ':Telescope command_history<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l',   ':call Mslog()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>l',   ':call highlight#enable()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f',   ':lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>/',   ':vnew<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>-',   ':split<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ws',   ':%s/\\s\\+$//<CR>', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hg',  ':TSHighlightCapturesUnderCursor<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>ss',  ':lua require("telescope.builtin").grep_string({search="<c-r><c-w>", layout_strategy="vertical",layout_config={width=0.99, height=0.99}})', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>ss',  ':Rg <c-r><c-w>', { noremap = true, silent = false })

--vim.cmd("cnoreabbrev Grep Telescope grep_string search=")
--vim.cmd("cnoreabbrev grep Telescope grep_string search=")
--[[
################################################################################
cmap, command line
################################################################################
--]]

--[[
if string.find(vim.o.wildoptions, "pum") then
    vim.api.nvim_set_keymap('c', '<up>', 'pumvisible() ? "<C-p>" : "<Up>"', { noremap = true, expr = true, silent = false})
    vim.api.nvim_set_keymap('c', '<down>', 'pumvisible() ? "<C-n>" : "<Down>"', { noremap = true, expr = true, silent = false})
    --vim.cmd("nnoremap <expr><leader>ss ':silent Rg ' . expand('<cword>')")
end
vim.api.nvim_set_keymap('i', '<TAB>', 'pumvisible() ? "<C-n>" : "<TAB>"', { expr = true})
vim.api.nvim_set_keymap('i', '<s-TAB>', 'pumvisible() ? "<C-p>" : "<c-h>"', { expr = true})
--]]

--]]

--[[
################################################################################
imap, insert mode:
################################################################################
--]]
-- function keys:

-- pum:

-- misc:
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true, silent = false})

--[[
################################################################################
vmap, visual mode:
################################################################################
--]]
-- vim.api.nvim_set_keymap('v', 'jk', '<esc>', { noremap = true, silent = false})
vim.api.nvim_set_keymap('v', '<leader>y', ':OSCYank<CR>', { noremap = true, silent = false})

---[ let, insert ]--------------------------------------------------------------
vim.api.nvim_set_keymap('n', '<leader>.', '<esc>:w!<CR>', { noremap = true, silent = false})

--[[
################################################################################
tmap, terminal:
################################################################################
--]]

vim.api.nvim_set_keymap('t', '<c-w>h', '<c-\\><c-n><c-w>h', opts)
vim.api.nvim_set_keymap('t', '<c-w>j', '<c-\\><c-n><c-w>j', opts)
vim.api.nvim_set_keymap('t', '<c-w>k', '<c-\\><c-n><c-w>k', opts)
vim.api.nvim_set_keymap('t', '<c-w>l', '<c-\\><c-n><c-w>l', opts)

