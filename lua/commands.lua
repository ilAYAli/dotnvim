  local telescope = require('telescope.builtin')
  local telescope_state = require('telescope.state')
  local last_search = nil

vim.api.nvim_create_user_command('GG',
  function (opts)
    local needle = vim.fn.expand("<cword>")
    if #opts.fargs > 0 then
        needle = table.concat(opts.fargs, " ")
    end
    --print("needle:", needle)
    if #needle > 0 then
      print("gg: cword search:", needle)
      telescope.grep_string({search=needle, layout_strategy="vertical",layout_config={width=0.99, height=0.99}})
      return
    end
    if last_search == nil then
      print("gg: interactive search")
      telescope.live_grep()

      local cached_pickers = telescope_state.get_global_key "cached_pickers" or {}
      last_search = cached_pickers[1]
    else
      print("gg: no cword, resuming search")
      telescope.resume({ picker = last_search })
    end
  end, { nargs = '*' })
vim.keymap.set('n', '<leader>ss', ':GG<CR>')
