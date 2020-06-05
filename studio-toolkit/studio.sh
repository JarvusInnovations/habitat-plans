#!/bin/bash

declare -A STUDIO_HELP

echo
echo "--> Setting up studio toolkit..."

STUDIO_HELP[studio-help]="Show help for all registered studio commands"
studio-help() {
    echo
    echo "--> Available studio commands:"
    echo

    local _commandsWidth=$(printf '%s\n' "${!STUDIO_HELP[@]}" | wc -L)

    for command in $(printf '%s\n' "${!STUDIO_HELP[@]}" | sort); do
        printf "    \e[92m\e[1m%-${_commandsWidth}.${_commandsWidth}s\e[0m  %s\n" "${command}" "${STUDIO_HELP[$command]}"
    done

    echo
}

echo
