function! s:Rg(...)
    let l:args = fnameescape(join(a:000))
    "exe "Telescope grep_string search=" . l:args
    exe 'lua require("telescope.builtin").grep_string({search="' . join(a:000) . '", layout_config={width=0.99, height=0.99}})'
endfu

command! -nargs=* Rg call <sid>Rg(<q-args>)

command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > "), layout_strategy="vertical",layout_config={width=0.99, height=0.99}})


cnoreabbrev rg Rg