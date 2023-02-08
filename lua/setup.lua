--------------------------------------------------------------------------------
-- SETUP
--------------------------------------------------------------------------------

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
  }
}

--[ treesitter ]----------------------------------------------------------------
require("nvim-treesitter.configs").init {
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
  window = {
		documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered({
			col_offset = -3,
		}),
	},
  formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, item)
			local kind = string.lower(item.kind)
			item.kind = icons.kinds[item.kind] or "?"
			item.abbr = item.abbr:match("[^(]+")
			item.menu = (icons.cmp_sources[entry.source.name] or "") .. kind
			return item
		end,
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

--[ dev ]-----------------------------------------------------------------------

local navic = require("nvim-navic")
navic.setup { highlight = true }

require('lspconfig')['clangd'].setup {
  cmd = clangd_cmd,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end
}

require('lspconfig')['tsserver'].setup{
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


require'lspconfig'.sumneko_lua.setup {
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

--[ misc ]----------------------------------------------------------------------

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	float = {
		border = "single",
		format = function(diagnostic)
			return string.format(
				"%s (%s) [%s]",
				diagnostic.message,
				diagnostic.source,
				diagnostic.code or diagnostic.user_data.lsp.code
			)
		end,
	},
})
--[ workarounds ]---------------------------------------------------------------
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

require("neo-tree").setup({
  window = { width = 25 },
})
