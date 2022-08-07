
set nonu
nnoremap q :quit!<CR>
setlocal nomodifiable
setlocal readonly
syntax on
syntax region manExample start='^\cExample\=$' end='^\%(\S.*\)\=\S$' keepend contains=manSentence,manSectionHeading,manSubHeading,@c,manCFuncDefinition

if getline(1) =~ "^std::" | set ft=cpp | syntax on | endif
