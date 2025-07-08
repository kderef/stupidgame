odin := 'odin'
src := 'game'
exe := 'bin/game'

alias b := build
alias r := run

build:
    {{odin}} build {{src}} -out:{{exe}}

run:
    {{exe}}
