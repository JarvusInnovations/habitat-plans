#!/bin/bash


# welcome message and environment detection
echo
echo "--> Welcome to MkDocs Studio! Detecting environment..."
if [ -z "${DOCS_REPO}" ]; then
    DOCS_REPO="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd)"
    DOCS_REPO="${DOCS_REPO:-/src}"
fi
echo "    DOCS_REPO=${DOCS_REPO}"
echo


# set up developer commands
echo
echo "--> Setting up MkDocs Studio commands..."

echo "    * Use 'watch-docs' to start live-reloading docs server"
watch-docs() {
    local requirements="${DOCS_REQUIREMENTS}"

    if [ -z "${requirements}" ]; then
        echo "\$DOCS_REQUIREMENTS not defined in environment"
        local lens_config_path="${DOCS_REPO}/.holo/branches/${DOCS_HOLOBRANCH:-gh-pages}.lenses/mkdocs.toml"

        if [ -f "${lens_config_path}" ]; then
            echo "Loading requirements from ${lens_config_path}"
            requirements="$(hab pkg exec jarvus/stoml stoml "${lens_config_path}" hololens.requirements)"
        else
            echo "Also did not find ${lens_config_path}"
        fi
    fi

    echo

    hab pkg exec jarvus/mkdocs python -m venv "/hab/cache/docs.venv"

    (
        set -e # exit subshell if any commands fail
        set -h # turn on a shell feature so activate can turn it back off without tripping -e
        source "/hab/cache/docs.venv/bin/activate";

        pip install --upgrade pip;
        pip install mkdocs ${requirements};

        mkdocs serve --dev-addr "0.0.0.0:${DOCS_PORT:-8000}";
    )
}

echo "    * Use 'bg-watch-docs' to run watch-docs in a background job"
bg-watch-docs() {
    watch-docs > /hab/cache/mkdocs.log 2>&1 &

    jobs -l %%
    echo
    echo "* job launched to background, use 'kill %<job-id>' to terminate"
    echo
}

echo
