--[ packer ]--------------------------------------------------------------------
local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
  vim.cmd [[packadd packer.nvim]]
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
    config = function()
      require('telescope').setup {
        defaults = {
          layout_config = {
            vertical = {
              width=0.99,
              height=0.99
            },
            horizontal = {
              width=0.99,
              height=0.99
            }
          }
        },
        opts = {
          show_untracked = false,
          ignore_patterns = {"*.git/*", "*.gitignore", "*.ccls-cache/*", "*/tmp/*", "*.cache/*"},
        },
      }
    end
  }

--[ treesitter ]----------------------------------------------------------------
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "cpp", "python", "lua" },
        -- ensure_installed = "maintained",
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
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
  }

  use "onsails/lspkind-nvim"

--[ local ]---------------------------------------------------------------------
  use '~/.config/nvim/mine/plugins/start'
  use '~/.config/nvim/mine/plugins/highlight'
  use '~/.config/nvim/mine/plugins/pastetoggle'
  use '~/.config/nvim/mine/plugins/namespace'

--[ dev ]---------------------------------------------------------------------
  use 'ilAYAli/scMRU.nvim'
  use 'https://github.com/jose-elias-alvarez/null-ls.nvim.git'
  use 'kyazdani42/nvim-web-devicons'

  --use 'ggandor/lightspeed.nvim'
  use 'tpope/vim-fugitive'
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
  use 'EdenEast/nightfox.nvim'
  use 'mhartington/oceanic-next'
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use 'folke/tokyonight.nvim'
  use 'https://github.com/theniceboy/nvim-deus.git'
  use 'projekt0n/github-nvim-theme'
  use 'tikhomirov/vim-glsl'                                    -- opengl syntax highlightning:
  use 'norcalli/nvim-colorizer.lua'

--[ misc ]--------------------------------------------------------------------
  use 'https://github.com/wsdjeg/vim-fetch.git'                -- file-line alt.
  use { 'ojroques/vim-oscyank', branch = 'main' }                -- yank to clipboard over ssh
  use 'christoomey/vim-tmux-navigator'
  use 'vimpostor/vim-tpipeline'
  use 'https://github.com/tpope/vim-abolish.git'               -- Subvert

end)



--------------------------------------------------------------------------------
-- SETUP
--------------------------------------------------------------------------------

--[ telescope ]-----------------------------------------------------------------
require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
  }
}

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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
require("nvim-lsp-installer").setup {}

if string.sub(vim.fn.hostname(), 1, 9) == "Xdbuild29" then
    require('lspconfig')['ccls'].setup {
      capabilities = capabilities
    }
else
    require('lspconfig')['clangd'].setup {
      cmd = clangd_cmd,
      capabilities = capabilities
    }
end

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

