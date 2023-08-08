return {
--[ telescope ]-----------------------------------------------------------------
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    },
  },

--[ treesitter ]----------------------------------------------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
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
  },
  { 'p00f/nvim-ts-rainbow' },

  {
    'nvim-treesitter/playground',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },

--[ cmp ]-----------------------------------------------------------------------
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline'
    }
  },

--[ lsp ]-----------------------------------------------------------------------
  { 'neovim/nvim-lspconfig' },
  { "onsails/lspkind-nvim" },
  { "weilbith/nvim-code-action-menu" },
  -- { 'jose-elias-alvarez/null-ls.nvim' },

--[ mason ]---------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    build = ":MasonUpdate"
  },

--[ mine ]----------------------------------------------------------------------
  { dir = '~/.config/nvim/mine/plugins/start' },
  { dir = '~/.config/nvim/mine/plugins/highlight' },
  { dir = '~/.config/nvim/mine/plugins/pastetoggle' },
  { dir = '~/.config/nvim/mine/plugins/namespace' },

  {
    'ilAYAli/scMRU.nvim',
    enabled = function()
      vim.fn.has('unix')
    end
  },
  { 'kkharji/sqlite.lua' },

--[ dev ]-----------------------------------------------------------------------
  { 'tpope/vim-fugitive' },
  {
    'TimUntersberger/neogit',
    dependencies = 'nvim-lua/plenary.nvim'
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  },
  { 'sindrets/diffview.nvim' },
  { 'mhinz/vim-signify' },
  { 'samoshkin/vim-mergetool' },
  { 'tikhomirov/vim-glsl' }, -- opengl syntax highlightning:

--[ styling ]-------------------------------------------------------------------

  { -- notifucation popup:
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
  },

  { -- winbar: function:
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig'
  },

  { 'norcalli/nvim-colorizer.lua' },

--[ themes ]--------------------------------------------------------------------
  { 'rebelot/kanagawa.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { 'theniceboy/nvim-deus' },

--[ misc ]----------------------------------------------------------------------
  { 'roxma/vim-tmux-clipboard' },
  { 'ojroques/nvim-osc52' },
  --{ 'lewis6991/fileline.nvim' },
  { 'wsdjeg/vim-fetch' },             -- file-line alt.
  { 'tpope/vim-abolish' },            -- Subvert
  { 'skywind3000/asyncrun.vim' },

  { 'alexghergh/nvim-tmux-navigation', config = function()
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
  },

}
