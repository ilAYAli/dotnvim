local fn = vim.fn
local api = vim.api

local M = {}

-- possible values are 'arrow' | 'rounded' | 'blank'
local active_sep = 'blank'

-- change them if you want to different separator
M.separators = {
  arrow = { '', '' },
  rounded = { '', '' },
  blank = { '', '' },
}

-- highlight groups
M.colors = {
  active        = '%#StatusLine#',
  inactive      = '%#StatuslineNC#',
  mode          = '%#Mode#',
  mode_alt      = '%#ModeAlt#',
  git           = '%#Git#',
  git_alt       = '%#GitAlt#',
  filetype      = '%#Filetype#',
  filetype_alt  = '%#FiletypeAlt#',
  line_col      = '%#LineCol#',
  line_col_alt  = '%#LineColAlt#',
}

M.trunc_width = setmetatable({
  mode       = 0,
  git_status = 90,
  filename   = 140,
  line_col   = 60,
}, {
  __index = function()
      return 80
  end
})

M.is_truncated = function(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

M.get_git_status = function(self)
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
  local is_head_empty = signs.head ~= ''

  if self:is_truncated(self.trunc_width.git_status) then
    return is_head_empty and string.format('  %s ', signs.head or '') or ''
  end

  return is_head_empty and string.format(
    ' +%s ~%s -%s |  %s |',
    signs.added, signs.changed, signs.removed, signs.head
  ) or ''
end

M.get_filename = function(self)
  if self:is_truncated(self.trunc_width.filename) then return " %<%f " end
  return " %<%F "
end

M.get_filetype = function()
  local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  local filetype = vim.bo.filetype

  if filetype == '' then return '' end
  return string.format(' %s %s ', icon, filetype):lower()
end


M.get_line_col = function(self)
  if self:is_truncated(self.trunc_width.line_col) then return '%p%% %l:%c ' end
  return ' %p%% %l:%c '
end


M.set_active = function(self)
  local colors = self.colors
  local git = colors.git .. self:get_git_status()
  local filename = colors.active .. self:get_filename()
  local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
  local filetype = colors.filetype .. self:get_filetype()
  local line_col = colors.line_col .. self:get_line_col()
  local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]

  return table.concat({
    --colors.active, mode, mode_alt, git, git_alt,
    git, filename,
    "%=",
    filetype_alt, filetype, line_col_alt, line_col
  })
end

M.set_inactive = function(self)
  return self.colors.inactive .. '%= %F %='
end

Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then return statusline:set_active() end
    if mode == "inactive" then return statusline:set_inactive() end
  end
})

-- set statusline
-- TODO: replace this once we can define autocmd using lua
api.nvim_exec2([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
  augroup END
]], {})
