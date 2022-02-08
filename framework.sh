#!/bin/bash

# require sources a bash library containing various functions for use in shell
# scripts.  calling require is a no-op if the specified script has already been
# loaded in this environment.
#
# params:
#   $1 - library to load
# env vars:
#   FRAMEWORK_LIB for sourcing library files
# return:
#   0 - success
#   1 - library file does not exist
#   2 - FRAMEWORK_LIB unset and library not loaded
#   3 - missing library name
#   4 - library directory does not exist or is not a directory
function require() {
    if [ -z "$1" ]; then
        framework::echoErr "missing library name"
        return 3
    fi

    local library_name
    library_name="$1"

    if [ -n "$(\declare -F | \awk "/declare -f ${library_name}::/" 2>/dev/null)" ]; then
        # already defined, no need to load again
        return 0
    fi
    if [ -z "${FRAMEWORK_LIB}" ]; then
        framework::echoErr "FRAMEWORK_LIB unset"
        return 2
    fi
    if [ ! -d "${FRAMEWORK_LIB}" ]; then
        framework::echoErr "FRAMEWORK_LIB unset not a directory"
        return 4
    fi

    local script_name
    script_name="${FRAMEWORK_LIB}/${library_name}.sh"
    # shellcheck source=/dev/null
    \source "${script_name}" 1>/dev/null 2>&1 || (
        framework::echoErr "unable to source ${script_name} in ${FRAMEWORK_LIB}"
        return 1
    )

    # success
    return 0
}

# framework::echoErr calls echo with STDOUT redirected to STDERR
#
# params:
#   #@ - echo parameters
# return:
#   echo return code
function framework::echoErr() {
    1>&2 \echo "$@"
}

# The default framework lib path
export FRAMEWORK_LIB="${HOME}/.local/lib"

export -f require
export -f framework::echoErr
