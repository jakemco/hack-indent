" Vim indent file
" Language:	PHP
" Maintainer:	Jacob Cordero (https://github.com/jakemco/hack-indent)
" Last Change: 2017 Feb 20
"
" modified from the Go indent file at https://github.com/google/vim-ft-go
"

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

" Let's just define our own.
setlocal nolisp
setlocal autoindent
setlocal indentexpr=HackIndent(v:lnum)
setlocal indentkeys+=<:>,0=},0=),0=>,0=]

if exists('*HackIndent')
  finish
endif

" The shiftwidth() function is relatively new.
" Don't require it to exist.
if exists('*shiftwidth')
  function s:sw() abort
    return shiftwidth()
  endfunction
else
  function s:sw() abort
    return &shiftwidth
  endfunction
endif

function! HackIndent(lnum)
  let l:prevlnum = prevnonblank(a:lnum-1)
  if l:prevlnum == 0
    " top of file
    return 0
  endif

  " grab the previous and current line, stripping comments.
  let l:prevl = substitute(getline(l:prevlnum), '//.*$\|/\*.{-}\*/', '', '')
  let l:thisl = substitute(getline(a:lnum), '//.*$\|/\*.{-}\*/', '', '')
  let l:previ = indent(l:prevlnum)

  let l:ind = l:previ

  if l:prevl =~ '[<[({]\s*$'
    " previous line opened a block
    let l:ind += s:sw()
  endif
  if l:prevl =~# '^\s*\(case .*\|default\):$'
    " previous line is part of a switch statement
    let l:ind += s:sw()
  endif

  if l:thisl =~ '^\s*[>)}\]]'
    " this line closed a block
    let l:ind -= s:sw()
  endif

  " Colons are tricky.
  " We want to outdent if it's part of a switch ("case foo:" or "default:").
  if l:thisl =~# '^\s*\(case .*\|default\):$'
    let l:ind -= s:sw()
  endif

  return l:ind
endfunction

" vim: sw=2 sts=2 et
