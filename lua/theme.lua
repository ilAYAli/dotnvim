---[ let: global ]--------------------------------------------------------------
local M = {}

function M.set_theme()
    if vim.env['ITERM_PROFILE'] == "Light" then
        vim.o.background = "light"
        vim.cmd("colorscheme github")

        vim.api.nvim_set_hl(0, 'SignColumn',        { bg = "#eeeeee", fg = "000000" })
        vim.api.nvim_set_hl(0, 'CursorLine',        { bg = "#ddddee" })
        vim.api.nvim_set_hl(0, 'Visual',            { bg = "#eacb8a" })
    else
        -- vim.cmd("colorscheme nvcode")
        vim.cmd("colorscheme nord")

        vim.api.nvim_set_hl(0, 'Normal',            { bg = "#151515" })
        vim.cmd("hi Normal      guibg=#151515") -- wtf!
        vim.api.nvim_set_hl(0, 'TSComment',         { bg = "#111111", fg ="#777777" })
        vim.api.nvim_set_hl(0, 'DiagnosticError',   { fg = "#807070" })
        vim.api.nvim_set_hl(0, 'Pmenu',             { bg = "#222244" })
        vim.api.nvim_set_hl(0, 'PmenuSel',          { bg = "#aaaaaa", fg = "#000000" })
        vim.api.nvim_set_hl(0, 'SignColumn',        { bg = "#151515" })

        -- [ diff ]-----------------------------------------------------------------
        --vim.api.nvim_set_hl(0, 'DiffChange',        { bg = "=#aaaa22", fg = "#1e1e1e" })
        --vim.api.nvim_set_hl(0, 'DiffAdd',           { bg = "=#608b4e", fg = "#1e1e1e" })
        --vim.api.nvim_set_hl(0, 'DiffDelete',        { bg = "=#aa2222", fg = "#1e1e1e" })
    end

    vim.api.nvim_set_hl(0, 'ExtraWhitespace',       { bg = "#ff0000" })
    vim.cmd("match ExtraWhitespace /\\s\\+\\%#\\@<!$/")
end

return M
