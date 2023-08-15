---[ let: global ]--------------------------------------------------------------
local M = {}

local fmt = string.format

local function get_color_from_hl(name)
  local result = {}
  for k, v in pairs(vim.api.nvim_get_hl_by_name(name, true)) do
    result[k] = fmt("#%06x", v)
  end
  return result
end

local function to_rgb(color)
  return tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6), 16)
end

local function clamp_color(color)
  return math.max(math.min(color, 255), 0)
end

-- https://stackoverflow.com/a/13532993
local function brighten(color, percent)
  local r, g, b = to_rgb(color)
  r = clamp_color(math.floor(tonumber(r * (100 + percent) / 100)))
  g = clamp_color(math.floor(tonumber(g * (100 + percent) / 100)))
  b = clamp_color(math.floor(tonumber(b * (100 + percent) / 100)))

  return "#" .. fmt("%0x", r) .. fmt("%0x", g) .. fmt("%0x", b)
end

local function highlight(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp
  vim.cmd(hl)
end

local function gen_hl()
  local normal = get_color_from_hl("Normal")
  local darkbg = brighten(normal.background, -10) -- darken by 10%

  local groups = {
    DarkerBackground = { bg = darkbg },
  }

  for name, values in pairs(groups) do
    highlight(name, values)
  end
end

function M.setup(theme)
  vim.cmd('hi clear')

  if theme == nil then
    if vim.env['ITERM_PROFILE'] == "Light" then
      theme = "dayfox"
    else
      --theme = 'nordfox'
      theme = 'kanagawa-dragon'
    end
  else
  end

  if vim.fn.has 'gui_running' == 1 then
    --theme = "dayfox"
    theme = "kanagawa"
  end

  vim.g.colors_name = theme

  local ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
  if not ok then
    vim.cmd 'colorscheme default'
  end

  ----[ theme specific changes ]------------------------------------------------
  if theme == 'nordfox' then
    vim.api.nvim_set_hl(0, 'Normal',            { bg = "#15151a" })
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

  ----[ theme agnostic changes ]------------------------------------------------
  vim.api.nvim_set_hl(0, 'ExtraWhitespace',     { bg = "#aa0000" })
  vim.cmd.match("ExtraWhitespace /\\s\\+\\%#\\@<!$/")


  ----[ link highlight groups ]-------------------------------------------------
  local normal = get_color_from_hl("Normal")
  local darkbg = brighten(normal.background, -10) -- darken by 10%
  local lightbg = brighten(normal.background, 150)
  local groups = {
    LighterBackground = { bg = lightbg },
    DarkerBackground = { bg = darkbg },
  }

  for name, values in pairs(groups) do
    highlight(name, values)
  end


  vim.api.nvim_set_hl(0, 'SignColumn',      { link = "CursorColumn" })
  vim.api.nvim_set_hl(0, 'SignColumn',      { link = "LighterBackground" })
  vim.api.nvim_set_hl(0, 'WinBar',          { link = "LighterBackground" })
  vim.api.nvim_set_hl(0, "StatusLine",      { link = "WinBar" })
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { link = "Normal" })
end


return M
