--[ telescope ]-----------------------------------------------------------------
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
    frecency = {
      hide_current_buffer = true,
      show_unindexed = true,
    }
  }
}

-- use git grep, not ripgrep
require('telescope.config').values.vimgrep_arguments = {
  'git',
  'grep',
  '--no-color',
  '--column'
}


local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
  },
  mapping = {
     ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
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
  sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = true
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol",
      symbol_map = { Copilot = "" },
      menu = ({
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        luasnip = "[luasnip]",
        nvim_lua = "[lua]",
        latex_symbols = "[latex]",
      })
    }),
  },
  sources = {
    { name = "copilot" },
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

--[ COMMON ]--------------------------------------------------------------------
local navic = require("nvim-navic")
navic.setup { highlight = true }

--[ CSHARP ]--------------------------------------------------------------------
local util = require'lspconfig.util'
require'lspconfig'.omnisharp.setup{
  root_dir = function(file)
    if file:sub(-#".csx") == ".csx" then
      return util.path.dirname(file)
    end
    return util.root_pattern("*.sln")(file) or util.root_pattern("*.csproj")(file)
    --return vim.fn.getcwd()
  end,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}


--[ C++ ]-----------------------------------------------------------------------
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

--vim.g.ale_linters_ignore = {
--  "cpp": "eslint",
--}

require('lspconfig')['clangd'].setup {
  cmd = clangd_cmd,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}

--[ JS ]------------------------------------------------------------------------
require('lspconfig')['tsserver'].setup{
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


--[ LUA ]-----------------------------------------------------------------------
require'lspconfig'.lua_ls.setup {
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
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

--[ MISC DEV ]------------------------------------------------------------------
-- 'cc', 'ccls', 'clangcheck', 'clangd', 'clangtidy', 'clazy', 'cppcheck', 'cpplint', 'cquery', 'cspell'

vim.g.ale_linters = {
  cpp = { "clangtidy", "cppcheck" }
}

--require("indent_blankline").setup {
--    -- for example, context is off by default, use this to turn it on
--    show_current_context = true,
--    show_current_context_start = true,
--}

---<osc52>---------
local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

---</osc52>---------

--require'colorizer'.setup()

--[ misc ]----------------------------------------------------------------------

--vim.diagnostic.config({
--  virtual_text = false,
--  signs = true,
--  float = {
--    border = "single",
--    format = function(diagnostic)
--      return string.format(
--        "%s (%s) [%s]",
--        diagnostic.message,
--        diagnostic.source,
--        diagnostic.code or diagnostic.user_data.lsp.code
--      )
--    end,
--  },
--})

--[ workarounds ]---------------------------------------------------------------
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
