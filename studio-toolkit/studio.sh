#!/bin/bash

declare -A STUDIO_HELP

STUDIO_HELP[sup-log]="Tail the Supervisor's output (Ctrl+c to stop)"


_setup_developer_user() {
    echo
    echo "--> Creating developer:developer user:group..."

    local group_args
    if [ -n "${STUDIO_DEVELOPER_GID}" ]; then
        echo "    Using STUDIO_DEVELOPER_GID=${STUDIO_DEVELOPER_GID}"
        group_args="-g ${STUDIO_DEVELOPER_GID}"
    fi

    hab pkg exec core/busybox-static addgroup ${group_args} developer

    local user_args
    if [ -n "${STUDIO_DEVELOPER_UID}" ]; then
        echo "    Using STUDIO_DEVELOPER_GID=${STUDIO_DEVELOPER_GID}"
        user_args="-u ${STUDIO_DEVELOPER_UID}"
    fi

    hab pkg exec core/busybox-static adduser -H -D ${user_args} -G developer developer
}

if [ "${STUDIO_DEVELOPER}" != "false" ]; then
    _setup_developer_user
fi


echo
echo "--> Setting up studio toolkit commands..."

STUDIO_HELP[studio-help]="Show help for all registered studio commands"
studio-help() {
    echo
    echo "--> Available studio commands (run studio-help any time to reprint):"
    echo

    local _commandsWidth=$(printf '%s\n' "${!STUDIO_HELP[@]}" | wc -L)

    for command in $(printf '%s\n' "${!STUDIO_HELP[@]}" | sort); do
        printf "    \e[92m\e[1m%-${_commandsWidth}.${_commandsWidth}s\e[0m  %s\n" "${command}" "${STUDIO_HELP[$command]}"
    done

    echo
}

STUDIO_HELP['studio-svc-config <svc> <toml>']="Write <toml> configuration to /hab/user/<svc>/config/user.toml"
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
    [ -z "$config_pkg_name" -o -z "$config_default" ] && { echo >&2 'Usage: studio-svc-config pkg_name "[default]\nconfig = value"'; return 1; }

    local config_toml_path="/hab/user/${config_pkg_name}/config/user.toml"

    if $config_force || [ ! -f "$config_toml_path" ]; then
        echo "    Initializing: $config_toml_path"
        mkdir -p "/hab/user/${config_pkg_name}/config"
        echo -e "$config_default" | awk '{$1=$1};1NF' | awk 'NF' > "$config_toml_path"
    fi
}

echo
