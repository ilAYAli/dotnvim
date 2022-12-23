---[ let: global ]--------------------------------------------------------------
local M = {}

function M.setup(theme)
  vim.cmd('hi clear')

  if theme == nil then
    if vim.env['ITERM_PROFILE'] == "Light" then
      theme = "dayfox"
    else
      theme = 'nordfox'
    end
  else
  end
  vim.g.colors_name = theme

  local ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
  if not ok then
    vim.cmd 'colorscheme default'
  end

  ----[ theme agnostic changes ]------------------------------------------------
  vim.api.nvim_set_hl(0, 'ExtraWhitespace',     { bg = "#ff0000" })
  vim.cmd.match("ExtraWhitespace /\\s\\+\\%#\\@<!$/")


  ----[ theme specific changes ]------------------------------------------------
  if theme == 'nordfox' then
    vim.api.nvim_set_hl(0, 'Normal',            { bg = "#15151a" })
    vim.api.nvim_set_hl(0, 'TelescopeNormal',   { bg = "#151515" })
    vim.api.nvim_set_hl(0, 'TSComment',         { bg = "#111111", fg ="#777777" })
    vim.api.nvim_set_hl(0, 'DiagnosticError',   { fg = "#807070" })
    vim.api.nvim_set_hl(0, 'Pmenu',             { bg = "#222244" })
    vim.api.nvim_set_hl(0, 'PmenuSel',          { bg = "#aaaaaa", fg = "#000000" })
    vim.api.nvim_set_hl(0, 'SignColumn',        { bg = "#151515" })
    vim.api.nvim_set_hl(0, 'Comment',           { fg = "#8092ac" })

    --vim.api.nvim_set_hl(0, 'WinBar',                { bg = "#3b4252", fg = "#dddddd" })
    --vim.api.nvim_set_hl(0, 'WinBarModified',        { bg = "#dedede", fg = "#363636" })
    --vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { bg = "#30322f", fg = "#cccccc" })

    vim.api.nvim_set_hl(0, 'DiffAdd',           { bg = "#285d16", fg = "#dde7ea" })
    vim.api.nvim_set_hl(0, 'DiffDelete',        { bg = "#600000", fg = "#dde7ea" })
    vim.api.nvim_set_hl(0, 'DiffText',          { bg = "#ab6606", fg = "#dde7ea" })
    vim.api.nvim_set_hl(0, 'DiffChange',        { bg = "#000000" })
  end
end

return M
