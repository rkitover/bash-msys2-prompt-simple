#!/bin/sh

BMPS_cmd_status() {
    if [ "$?" -eq 0 ]; then
        printf '\001[0;32m\002✔'
    else
        printf '\001[0;31m\002✘'
    fi
}

BMPS_msystem() {
    if [ -n "$MSYSTEM" ]; then
        # need trailing space here
        printf '\001[35m\002'"$MSYSTEM "
    fi
}

BMPS_in_git_tree() {
    (
        while [ "$PWD" != / ]; do
            [ -d .git ] && exit 0
            cd ..
        done
        exit 1
    )
    return $?
}

BMPS_git_branch() {
    ! BMPS_in_git_tree && return 0

    _br=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    if [ -n "$_br" ]; then
        printf '\001[0;36m\002[\001[35m\002'"${_br}"'\001[36m\002]\001[0m\002'
    fi
}

PS1='`BMPS_cmd_status`  `BMPS_msystem`\001[33m\002\w `BMPS_git_branch`\n\002[0;34m\002'"${USER}"'\001[0;37m\002@\001[1;34m\002\h  \001[1;31m\002➤\001[0m\002  '
