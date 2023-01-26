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
  vim.api.nvim_set_hl(0, 'ExtraWhitespace',     { bg = "#aa0000" })
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

    vim.api.nvim_set_hl(0,  'DiagnosticFloatingError', { bg = "#ab6606", fg = "#dde7ea" })
    -- navic/winbar:
    vim.api.nvim_set_hl(0, "NavicIconsFile",          {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsModule",        {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsNamespace",     {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsPackage",       {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsClass",         {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsMethod",        {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsProperty",      {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsField",         {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsConstructor",   {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsEnum",          {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsInterface",     {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsFunction",      {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsVariable",      {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsConstant",      {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsString",        {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsNumber",        {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsBoolean",       {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsArray",         {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsObject",        {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsKey",           {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsNull",          {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsStruct",        {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsEvent",         {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsOperator",      {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", {default = true, fg = "#bf616a", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicText",               {default = true, fg = "#cccccc", bg = "#2e3440"})
    vim.api.nvim_set_hl(0, "NavicSeparator",          {default = true, fg = "#8092ac", bg = "#2e3440"})
    -- bf616a

    -- neotree
    vim.api.nvim_set_hl(0, 'NeoTreeNormal',           { bg = "#15151a" })
  end
end

return M
