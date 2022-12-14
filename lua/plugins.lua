--[ packer ]--------------------------------------------------------------------
local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
  vim.cmd.packadd("packer.nvim")
end

-- silence sumneko regarding: unused global 'use':
local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim'


--[ telescope ]-----------------------------------------------------------------
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    },
  }

  require('telescope').setup{
    defaults = {
      layout_strategy = "vertical",
      fname_width = 70,
      mappings = { },
      layout_config = {
        vertical = { width=0.99, height=0.99 },
        horizontal = { width=0.99, height=0.99 }
      }
    },
    pickers = {
      colorscheme = {
        enable_preview = true
      },
      opts = {
        show_untracked = false,
        ignore_patterns = {"*.git/*", "*.gitignore", "*.ccls-cache/*", "*/tmp/*", "*.cache/*"},
      },
    },
    extensions = {
    }
  }

--[ treesitter ]----------------------------------------------------------------
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "cpp", "python", "lua", "javascript" },
        -- ensure_installed = "maintained",
        auto_install = true,
        ignore_install = { "haskell" },
        highlight = {
          enable = true,
        },
        refactor = {
          highlight_definitions = {
            enable = true
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = ",r",
            },
          },
        },
        playground = {
          enable = false,
          disable = { "" },
          updatetime = 25,
          persist_queries = false
        }
      }
    end
  }

  use 'p00f/nvim-ts-rainbow'

--[ treesitter plugins ]--------------------------------------------------------
  use {
    'nvim-treesitter/playground',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    }
  }

--[ cmp ]-----------------------------------------------------------------------
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline'

    }
  }

--[ LSP ]-----------------------------------------------------------------------
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use "onsails/lspkind-nvim"
  use "weilbith/nvim-code-action-menu"

--[ local ]---------------------------------------------------------------------
  use '~/.config/nvim/mine/plugins/start'
  use '~/.config/nvim/mine/plugins/highlight'
  use '~/.config/nvim/mine/plugins/pastetoggle'
  use '~/.config/nvim/mine/plugins/namespace'

--[ dev ]---------------------------------------------------------------------
  use 'ilAYAli/scMRU.nvim'
  use 'https://github.com/jose-elias-alvarez/null-ls.nvim.git'
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'
  use 'lukas-reineke/indent-blankline.nvim'

  --use 'ggandor/lightspeed.nvim'
  use 'tpope/vim-fugitive'
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim'
  }
  use 'skywind3000/asyncrun.vim'

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  use 'mhinz/vim-signify'
  use 'https://github.com/samoshkin/vim-mergetool.git'

--[ theme ]-------------------------------------------------------------------
  use 'feline-nvim/feline.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup()
    end
  }
  use 'rebelot/kanagawa.nvim'
  use 'sam4llis/nvim-tundra'
  use 'EdenEast/nightfox.nvim'
  use 'https://github.com/theniceboy/nvim-deus.git'
  use 'projekt0n/github-nvim-theme'
  use 'tikhomirov/vim-glsl'                                    -- opengl syntax highlightning:

--[ misc ]--------------------------------------------------------------------
  use 'https://github.com/wsdjeg/vim-fetch.git'                -- file-line alt.
  use 'https://github.com/roxma/vim-tmux-clipboard.git'
  use 'ojroques/nvim-osc52'

  --use 'vimpostor/vim-tpipeline'
  use 'https://github.com/tpope/vim-abolish.git'               -- Subvert

end)



--------------------------------------------------------------------------------
-- SETUP
--------------------------------------------------------------------------------

--[ treesitter ]----------------------------------------------------------------
require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

--[ cmp ]-----------------------------------------------------------------------
-- cmp_nvim_lsp.default_capabilitie
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local clangd_cmd = {
  "clangd",
  "--background-index",
  "-j=12",
  "--clang-tidy",
  "--clang-tidy-checks=*",
  "--all-scopes-completion",
  "--cross-file-rename",
  "--completion-style=detailed",
  "--header-insertion-decorators",
  "--header-insertion=iwyu",
  "--pch-storage=memory",
}

local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  experimental = {
    native_menu = false,
    ghost_text = true
  },
  formatting = {
    format = require("lspkind").cmp_format({with_text = true, menu = ({
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        luasnip = "[luasnip]",
        nvim_lua = "[lua]",
        latex_symbols = "[latex]",
      })}),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'vsnip' },
  },
}


cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

--[ LSP ]-----------------------------------------------------------------------
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

require("mason").setup()
require("mason-lspconfig").setup()


require('lspconfig')['clangd'].setup {
  cmd = clangd_cmd,
  capabilities = capabilities
}

require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

--[ dev ]-----------------------------------------------------------------------
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.cppcheck,
    },
})

require('neogit').setup{}

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

---<osc52>---------
local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

---</osc52>---------

require'colorizer'.setup()

use { 'alexghergh/nvim-tmux-navigation', config = function()
        local nvim_tmux_nav = require('nvim-tmux-navigation')
        nvim_tmux_nav.setup {
            disable_when_zoomed = true -- defaults to false
        }
        vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
        vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end
}

--[ misc ]----------------------------------------------------------------------

--[ workarounds ]---------------------------------------------------------------
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

