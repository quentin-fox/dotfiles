if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=golangci-lint\ run\ --out-format\=line-number\ --print-issued-lines\=false
CompilerSet errorformat=%f:%l:%c:\ %m,%f:%l:\ %m
