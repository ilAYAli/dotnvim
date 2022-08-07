---[ let: global ]--------------------------------------------------------------
local M = {}

function M.set_theme()
    if vim.env['ITERM_PROFILE'] == "Light" then
        vim.o.background = "light"
        vim.cmd.colorscheme("github_light")

        vim.api.nvim_set_hl(0, 'SignColumn',        { bg = "#eeeeee", fg = "#000000" })
        vim.api.nvim_set_hl(0, 'CursorLine',        { bg = "#ddddee" })
        vim.api.nvim_set_hl(0, 'Visual',            { bg = "#eacb8a" })
    else
        -- vim.cmd.colorscheme("nvcode")
        --vim.cmd.colorscheme("nord")
        --vim.cmd("colorscheme nightfox")
        --vim.cmd.colorscheme('kanagawa')
        vim.cmd("colorscheme nordfox")
        vim.api.nvim_set_hl(0, 'Normal',            { bg = "#15151a" })
        vim.api.nvim_set_hl(0, 'TelescopeNormal',   { bg = "#151515" })
        vim.api.nvim_set_hl(0, 'TSComment',         { bg = "#111111", fg ="#777777" })
        vim.api.nvim_set_hl(0, 'DiagnosticError',   { fg = "#807070" })
        vim.api.nvim_set_hl(0, 'Pmenu',             { bg = "#222244" })
        vim.api.nvim_set_hl(0, 'PmenuSel',          { bg = "#aaaaaa", fg = "#000000" })
        vim.api.nvim_set_hl(0, 'SignColumn',        { bg = "#151515" })

        -- -- [ diff ]-----------------------------------------------------------------
        vim.api.nvim_set_hl(0, 'DiffAdd',           { bg = "#285d16", fg = "#dde7ea" })
        vim.api.nvim_set_hl(0, 'DiffDelete',        { bg = "#600000", fg = "#dde7ea" })
        vim.api.nvim_set_hl(0, 'DiffText',          { bg = "#ab6606", fg = "#dde7ea" })
        --vim.api.nvim_set_hl(0, 'DiffChange',        { bg = "#403000" })
        vim.api.nvim_set_hl(0, 'DiffChange',        { bg = "#000000" })
    end

    --vim.api.nvim_set_hl(0, 'NormalFloat',           { fg = "#ff9e3b" })
    vim.api.nvim_set_hl(0, 'FloatBorder',           { fg = "#ff9e3b" })
    vim.api.nvim_set_hl(0, 'WinBar',                { bg = "#3b4252", fg = "#dddddd" })
    vim.api.nvim_set_hl(0, 'WinBarModified',        { bg = "#dedede", fg = "#363636" })

    vim.api.nvim_set_hl(0, 'ExtraWhitespace',       { bg = "#ff0000" })
    vim.cmd.match("ExtraWhitespace /\\s\\+\\%#\\@<!$/")
end

return M
