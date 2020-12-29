#!/bin/bash


# welcome message and environment detection
echo
echo "--> Welcome to MkDocs Studio! Detecting environment..."
if [ -z "${DOCS_REPO}" ]; then
    DOCS_REPO="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd)"
    DOCS_REPO="${DOCS_REPO:-/src}"
fi
echo "    DOCS_REPO=${DOCS_REPO}"


# set up developer commands
declare -A STUDIO_HELP

echo
echo "--> Setting up MkDocs Studio commands..."

STUDIO_HELP[docs-watch]="Start live-reloading docs server"
docs-watch() {
    local requirements
    IFS=' ' read -r -a requirements <<< "${DOCS_REQUIREMENTS}"

    if [ ${#requirements[@]} -eq 0 ]; then
        echo "\$DOCS_REQUIREMENTS not defined in environment"
        local lens_config_path="${DOCS_REPO}/.holo/branches/${DOCS_HOLOBRANCH:-gh-pages}.lenses/mkdocs.toml"

        if [ -f "${lens_config_path}" ]; then
            echo "Loading requirements from ${lens_config_path}"
            IFS=' ' read -r -a requirements <<< "$(hab pkg exec jarvus/stoml stoml "${lens_config_path}" hololens.requirements)"
        else
            echo "Also did not find ${lens_config_path}"
        fi
    fi

    echo

    hab pkg exec jarvus/mkdocs python -m venv "/hab/cache/docs.venv"

    (
        set -e # exit subshell if any commands fail
        set -h # turn on a shell feature so activate can turn it back off without tripping -e

        cd "${DOCS_REPO}"
        source "/hab/cache/docs.venv/bin/activate";

        pip install --upgrade pip;
        pip install mkdocs "${requirements[@]}";

        exec mkdocs serve --dev-addr "0.0.0.0:${DOCS_PORT:-8000}";
    )
}

STUDIO_HELP[docs-start]="Start live-reloading docs server in background job"
docs-start() {
    docs-stop || true

    echo
    echo "--> Launching \`mkdocs serve\` in the background..."

    touch ~/mkdocs.log
    tail -n 0 -f ~/mkdocs.log | sed 's/^/    /' &
    _tail_pid=$!

    docs-watch > ~/mkdocs.log 2>&1 &
    _docs_pid=$!

    until hab pkg exec core/curl curl --fail "localhost:${DOCS_PORT:-8000}/index.html" 2>/dev/null >/dev/null; do sleep .5; done;
    kill $_tail_pid
    echo

    echo
    echo -e "    \e[1m* MkDocs hot-reload now available: \e[92mhttp://localhost:${DOCS_PORT:-8000}\e[0m"
    echo -e "    \e[1m* MkDocs output logged to: \e[0m~/mkdocs.log"
}

STUDIO_HELP[docs-stop]="Stop live-reloading docs server started in background"
docs-stop() {
    [ -n "${_docs_pid}" ] && {
        echo
        echo "--> Stopping docs server..."
        echo "    Killing process #${_docs_pid}"
        kill -- "-${_docs_pid}" # kill entire group
        unset _docs_pid
    }
}

STUDIO_HELP[docs-log]="Open and follow mkdocs serve output"
docs-log() {
    less -r +F ~/mkdocs.log
}

echo
