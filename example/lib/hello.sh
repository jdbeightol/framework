#!/bin/bash

# hello::world says hello with echo!
#
# params:
#   1 - (optional) name to greet
# env vars:
#   HELLO_WORD to define the word used to say hello
# return:
#   0 - success
function hello::world() {
    if [ -z "$1" ]; then
        echo "${HELLO_WORD} world"
        return 0
    fi
    echo "${HELLO_WORD}, $1"
    return 0
}

# the word to use when saying hello.  consider uncommenting adding others here,
# or defining your own after loading this library to experiment.  the last one
# defined should take precendence.
export HELLO_WORD="hello"
#export HELLO_WORD="Hello"
#export HELLO_WORD="hallo"
#export HELLO_WORD="привет"
#export HELLO_WORD="こんにちは"

# functions should be exported to ensure subshells inherit them as expected.
export -f hello::world
