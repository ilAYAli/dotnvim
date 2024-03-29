-- disable :checkhealth for unused, internal plugins:
vim.tbl_map(
  function(p)
    vim.g["loaded_" .. p] = vim.endswith(p, "provider") and 0 or 1
  end,
  {
    "2html_plugin",
    "gzip",
    "matchit",
    "netrw",
    "netrwPlugin",
    "perl_provider",
    "python_provider",
    "ruby_provider",
    "node_provider",
    "tar",
    "tarPlugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
  }
)

if require'utils'.is_darwin() then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
  }
end

if vim.fn.has('nvim-0.8') == 1 then
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}%=%f%="
    --vim.o.winbar            = '%=%f%='
    vim.o.cmdheight         = 0
end

--vim.opt.guifont="SauseCodePro Nerd Font:h10"
vim.opt.guifont="JetBrainsMono Nerd Font:h12"


vim.opt.laststatus              = 3
vim.opt.showmode                = false
vim.opt.syntax                  = "on"
vim.opt.termguicolors           = true
vim.opt.mouse                   = "a"
vim.opt.scroll                  = 1
vim.opt.scrolloff               = 0
vim.opt.infercase               = true
vim.opt.grepprg                 ="rg --no-heading --smart-case --vimgrep"
--vim.opt.cinoptions              = "l1,g0,N-s,(0,W4u2"
vim.opt.cinoptions              = 'l1,N-s,t0,(s,u1,W4,-j,J1'
vim.opt.hidden                  = true
vim.opt.foldenable              = false
--vim.opt.lazyredraw              = true
--vim.opt.diffopt                 = "filler,iblank,vertical,closeoff,linematch:60"
vim.opt.diffopt               = "filler,internal,algorithm:histogram,indent-heuristic"
vim.opt.inccommand              = "nosplit"
vim.opt.splitbelow              = true
vim.opt.backspace               = "indent,eol,start"
vim.opt.previewheight           = 20
vim.opt.helpheight              = 99999
vim.opt.showcmd                 = true
vim.opt.showmatch               = true
vim.opt.showfulltag             = true
vim.opt.gdefault                = true                          -- Use g flag by default in substitutes :s/foo/bar/g
vim.opt.virtualedit             = "block"                       -- Allow more flexible visual block selection
vim.opt.selection               = "inclusive"                   -- Selection is inclusive, unix-style
vim.opt.visualbell              = true
vim.opt.joinspaces              = false                         -- Don't use double space after a period
vim.opt.shortmess               = "cfilnxtToOFI"
--vim.opt.showbreak               = "↳  ⇢"
vim.opt.spelllang               = "nb,en"
vim.opt.switchbuf               = "usetab,useopen"
vim.opt.autoread                = false                         -- Don't autoread on external file change

--[ menu:
vim.opt.wildoptions             = "pum,tagfile"
vim.opt.wildmode                = "longest:full,full"
vim.opt.list                    = true
vim.opt.completeopt             = "menu,menuone,noselect"

--[ indent
vim.opt.expandtab               = true
vim.opt.softtabstop             = 4
vim.opt.tabstop                 = 8
vim.opt.shiftwidth              = 4
vim.opt.autoindent              = false

---[ search:
vim.opt.path                    = vim.o.path .. "**"
vim.opt.wrapscan                = true
vim.opt.ignorecase              = true
vim.opt.smartcase               = true

---[ timers:
vim.opt.updatetime              = 300
vim.opt.timeoutlen              = 1000
vim.opt.ttimeoutlen             = 0

---[ undo:
vim.opt.swapfile                = false
vim.opt.undofile                = true
vim.opt.undolevels              = 10000
vim.opt.backupdir               = vim.env.HOME .. "/.cache/"
vim.opt.undodir                 = vim.env.HOME .. "/.cache/"

--[ b&w:
--vim.opt.number                  = true
vim.opt.cursorline              = true
vim.opt.foldenable              = false

-- [ global:
vim.g.asyncrun_open             = 1

-- [ disable default vim plugins:
vim.g.loaded_gzip               = 1
vim.g.loaded_tar                = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_zip                = 1
vim.g.loaded_zipPlugin          = 1

vim.g.loaded_getscript          = 1
vim.g.loaded_getscriptPlugin    = 1
vim.g.loaded_vimball            = 1
vim.g.loaded_vimballPlugin      = 1

vim.g.loaded_2html_plugin       = 1
vim.g.loaded_logiPat            = 1
vim.g.loaded_rrhelper           = 1

vim.g.loaded_netrw              = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_netrwSettings      = 1
vim.g.loaded_netrwFileHandlers  = 1
