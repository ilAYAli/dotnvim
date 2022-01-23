---[ let: global ]--------------------------------------------------------------
function _G.set_theme()
  if vim.env['ITERM_PROFILE'] == "Light" then
    vim.o.background = "light"
    vim.cmd("colorscheme github")

    vim.cmd("highlight SignColumn guibg=#eeeeee guifg=#000000")
    vim.cmd("highlight CursorLine guibg=#ddddee guifg=none")
    vim.cmd("highlight Visual ctermfg=none guifg=none ctermbg=3, guibg=#eacb8a")
  else
    vim.cmd("colorscheme nord")
    vim.cmd("hi Normal      guibg=#0d1116")
    vim.cmd("hi TSComment   guibg=#111111 guifg=#777777")
    vim.cmd("highlight DiagnosticError guifg=#706000")
    --
    -- [ diff ]-----------------------------------------------------------------
    --vim.cmd("hi DiffChange  guifg=#1e1e1e guibg=#aaaa22 gui=NONE")
    --vim.cmd("hi DiffAdd     guifg=#1e1e1e guibg=#608b4e")
    --vim.cmd("hi DiffDelete  guifg=#1e1e1e guibg=#aa2222")
    --vim.cmd("hi DiffText    guifg=#81a1c1 guibg=NONE")
    vim.cmd("hi DiffAdd     guibg=#1b4429")
    vim.cmd("hi DiffDelete  guibg=#70212f")
    vim.cmd("hi DiffChange  guifg=#ebcb8b")
    vim.cmd("hi DiffText    guibg=#1e4273")

    ---[ misc ]-----------------------------------------------------------------
    vim.cmd("hi Pmenu       guibg=#222244")
    vim.cmd("hi PmenuSel    guifg=#000000 guibg=#aaaaaa")
    vim.cmd("hi SignColumn  guibg=#151515")
  end

  vim.cmd("hi Search guifg=#000000 guibg=#ffb266")
  vim.cmd("hi ExtraWhitespace ctermbg=red guibg=red")
  vim.cmd("match ExtraWhitespace /\\s\\+\\%#\\@<!$/")
end

local function init()
  vim.api.nvim_exec([[
  augroup pwa_theme
  autocmd ColorScheme * lua set_theme()
  augroup END
  ]], false)
  _G.set_theme()
end

init()
