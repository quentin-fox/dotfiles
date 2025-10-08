if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=yarn\ run\ tsc

let &cpo = s:cpo_save
unlet s:cpo_save
