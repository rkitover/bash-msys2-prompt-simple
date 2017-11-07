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
        printf '\001[35m\002%s' "$MSYSTEM "
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
        printf '\001[0;36m\002[\001[35m\002%s\001[36m\002]\001[0m\002' "${_br}"
    fi
}

BMPS_cwd() {
    case "$PWD" in
        "$HOME")
            printf '\001[33m\002~'
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

            printf '\001[33m\002~/%s' "${_pwd}"
            ;;
        *)
            printf '\001[33m\002%s' "${PWD}"
            ;;
    esac
}

_esc=$(printf '\001')
_end=$(printf '\002')

PS1='$(BMPS_cmd_status)  $(BMPS_msystem)$(BMPS_cwd) $(BMPS_git_branch)${_esc}
${_end}${_esc}[0;34m${_end}'"${USER}"'${_esc}[0;37m${_end}@${_esc}[1;34m${_end}$(hostname)  ${_esc}[1;31m${_end}➤${_esc}[0m${_end}  '
