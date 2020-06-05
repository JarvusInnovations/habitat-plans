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

STUDIO_HELP[studio-svc-config]="Write \$2 configuration to /hab/user/\$1/config/user.toml"
studio-svc-config() {
    local config_force
    if [ "$1" == "--force" ]; then
        shift
        config_force=true
    else
        config_force=false
    fi

    local config_pkg_name="$1"
    local config_default="$2"
    [ -z "$config_pkg_name" -o -z "$config_default" ] && { echo >&2 'Usage: init-user-config pkg_name "[default]\nconfig = value"'; return 1; }

    local config_toml_path="/hab/user/${config_pkg_name}/config/user.toml"

    if $config_force || [ ! -f "$config_toml_path" ]; then
        echo "    Initializing: $config_toml_path"
        mkdir -p "/hab/user/${config_pkg_name}/config"
        echo -e "$config_default" | awk '{$1=$1};1NF' | awk 'NF' > "$config_toml_path"
    fi
}

echo
