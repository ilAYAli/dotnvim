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
  { 'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "python", "lua", "javascript" },
        sync_install = false,
        auto_install = true,
        ignore_install = { },
        highlight = { enable = true, }
      }
    end
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
  { "onsails/lspkind-nvim" }, -- vscode like LSP completion pictograms
  { "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  },

--[ mason ]---------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    build = ":MasonUpdate"
  },

--[ mine ]----------------------------------------------------------------------
  { dir = '~/.config/nvim/mine/plugins/start' },
  { dir = '~/.config/nvim/mine/plugins/highlight' },
  { dir = '~/.config/nvim/mine/plugins/namespace' },

  --{
  --  'ilAYAli/scMRU.nvim',
  --  dependencies = 'kkharji/sqlite.lua',
  --  enabled = function()
  --    return vim.fn.has('unix')
  --  end
  --},

--[ dev ]-----------------------------------------------------------------------
  -- { 'dense-analysis/ale' },

  { 'tpope/vim-fugitive' },

  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '+' },
          change       = { text = '│' },
          delete       = { text = '-' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
      }
    end
  },
  { 'sindrets/diffview.nvim' },
  { 'samoshkin/vim-mergetool' },

--[ styling ]-------------------------------------------------------------------
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', lazy = true
    },
  },

  { -- winbar: function:
    'SmiteshP/nvim-navic',
    dependencies = {
      'neovim/nvim-lspconfig'
    }
  },

--[ themes ]--------------------------------------------------------------------
  { 'folke/tokyonight.nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'EdenEast/nightfox.nvim' },
  --{ 'theniceboy/nvim-deus' },

--[ copilot ]-------------------------------------------------------------------
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },

--[ misc ]----------------------------------------------------------------------
  { 'ctrlpvim/ctrlp.vim'},
  --{ 'norcalli/nvim-colorizer.lua' },
  { 'roxma/vim-tmux-clipboard' },
  { 'ojroques/nvim-osc52' },
  --{ 'lewis6991/fileline.nvim' },
  { 'wsdjeg/vim-fetch' },             -- file-line alt.
  { 'tpope/vim-abolish' },            -- Subvert
  { 'skywind3000/asyncrun.vim' },

  { 'alexghergh/nvim-tmux-navigation',
    config = function()
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
