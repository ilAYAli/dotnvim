-- print("initializing packets")
USER = vim.fn.expand('$USER')
HOME = vim.fn.expand('$HOME')
CWD  = vim.fn.expand('$PWD')

local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
  vim.cmd [[packadd packer.nvim]]
end


require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- lsp:
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }


  -- telescope extensions:
  use {
    "nvim-telescope/telescope-frecency.nvim",
    requires = {
      "tami5/sql.nvim"
    },
    config = function()
      require"telescope".load_extension("frecency")
    end
  }

  -- telescope:
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
        extensions = {
          frecency = {
            show_scores = false,
            show_unindexed = true,
            ignore_patterns = {"*.git/*", "*.gitignore", "*.ccls-cache/*", "*/tmp/*", "*.cache/*"},
            workspaces = {
              ["ce"]      =  (HOME.."/source/ce-main"),
              ["nvim"]    =  (HOME.."/.config/nvim"),
              ["cwd"]     =  (CWD)
            }
          }
        },
      }
    end
  }

  -- treesitter extensions:
  use {
    'nvim-treesitter/nvim-treesitter-refactor',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    }
  }
  use {
    'nvim-treesitter/playground',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    }
  }

  -- treesitter:
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


  -- local:
  use '~/.config/nvim/mine/plugins/start'
  use '~/.config/nvim/mine/plugins/highlight'
  use '~/.config/nvim/mine/plugins/pastetoggle'
  use '~/.config/nvim/mine/plugins/namespace'
  -- use '~/.config/nvim/mine/plugins/gblame'
  -- use '~/.config/nvim/mine/plugins/mru'


  --[ dev ]-------------------------------------------------------------------

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline'

    }
  }

  use 'p00f/nvim-ts-rainbow'

  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use 'ggandor/lightspeed.nvim'
  use 'tpope/vim-fugitive'
  use 'skywind3000/asyncrun.vim'

  -- use {
  --   'TimUntersberger/neogit',
  --   requires = 'nvim-lua/plenary.nvim',
  --   config = function()
  --     require('neogit').setup()
  --   end
  -- }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    "ray-x/lsp_signature.nvim",
  }
  use {
    'sindrets/diffview.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use 'nvim-lualine/lualine.nvim'
  use 'mhinz/vim-signify'
  -- use { "ray-x/lsp_signature.nvim", }
  -- use 'https://github.com/w0rp/ale.git'
  use 'https://github.com/samoshkin/vim-mergetool.git'

  --[ misc ]------------------------------------------------------------------
  use "onsails/lspkind-nvim"

  use 'https://github.com/wsdjeg/vim-fetch.git'                -- file-line alt.
  use 'ojroques/vim-oscyank'                                   -- yank to clipboard over ssh
  use 'https://github.com/urbainvaes/vim-tmux-pilot'           -- c-h/c-l switch term window
  use 'https://github.com/tpope/vim-abolish.git'               -- Subvert

  --[ theme ]-----------------------------------------------------------------
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use 'folke/tokyonight.nvim'
  use 'https://github.com/theniceboy/nvim-deus.git'
  use 'https://github.com/cormacrelf/vim-colors-github.git'    -- light theme
  use 'tikhomirov/vim-glsl'                                    -- opengl syntax highlightning:
  use 'norcalli/nvim-colorizer.lua'
end)


-- telescope
require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
  }
}

-- lsp:
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

require('lspconfig')['clangd'].setup {
  cmd = cmd,
  capabilities = capabilities
}

--local lspkind = require('lspkind')
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

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- lualine
require('lualine').setup{
  options = {
    theme = 'nord'
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = filename, 1 = relative, 2 = absolute
      }
    }
  }
}

require'hop'.setup()

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
