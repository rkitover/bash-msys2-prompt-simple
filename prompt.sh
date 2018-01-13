#!/bin/sh

_esc=$(printf '\001')
_end=$(printf '\002')

BMPS_cmd_status() {
    if [ "$?" -eq 0 ]; then
        printf "${_esc}[0;32m${_end}%s" '✔'
    else
        printf "${_esc}[0;31m${_end}%s" '✘'
    fi
}

BMPS_msystem() {
    if [ -n "$MSYSTEM" ]; then
        # need trailing space here
        printf "${_esc}[35m${_end}%s " "$MSYSTEM"
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
        printf "${_esc}[0;36m${_end}[${_esc}[35m${_end}%s${_esc}[36m${_end}]${_esc}[0m${_end}" "${_br}"
    fi
}

BMPS_cwd() {
    case "$PWD" in
        "$HOME")
            printf "${_esc}[33m${_end}%s" '~'
            ;;
        "$HOME"/*)
            _pwd=${PWD#$HOME}

            while :; do
                case "$_pwd" in
                    /*)
                        _pwd=${_pwd#/}
                        ;;
                    *)
                        break
                        ;;
                esac
            done

            printf "${_esc}[33m${_end}~/%s" "${_pwd}"
            ;;
        *)
            printf "${_esc}[33m${_end}%s" "${PWD}"
            ;;
    esac
}

PS1="\$(BMPS_cmd_status)  \$(BMPS_msystem)\$(BMPS_cwd) \$(BMPS_git_branch)${_esc}
${_end}${_esc}[0;34m${_end}\${USER}${_esc}[0;37m${_end}@${_esc}[1;34m${_end}\$(hostname)  ${_esc}[1;31m${_end}${_esc}➤${_end}${_esc}[0m${_end}  "
