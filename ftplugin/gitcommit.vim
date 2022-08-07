function! IgnoreCamelCaseSpell() abort
    syn match CamelCase /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
    syn cluster Spell add=CamelCase
endfunction

setlocal colorcolumn=75
setlocal spell

"au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
"call setpos('.', [0, 1, 1, 0])
norm gg0

call IgnoreCamelCaseSpell()

