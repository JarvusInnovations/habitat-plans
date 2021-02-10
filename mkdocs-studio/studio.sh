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

    # overlay parent
    local docs_root="${DOCS_REPO}"
    local docs_content_dir="${DOCS_CONTENT_DIR:-docs}"

    if [ -n "${DOCS_PARENT_SOURCE}" ]; then
        local docs_parent_holobranch="${DOCS_PARENT_HOLOBRANCH:-docs-skeleton}"

        echo
        echo "--> Setting up docs overlay with from parent source ${DOCS_PARENT_SOURCE}=>${docs_parent_holobranch}..."

        mkdir -p \
            "/hab/cache/mkdocs/site" \
            "/hab/cache/mkdocs/workdir" \
            "/hab/cache/mkdocs/merged/docs" \
            "${DOCS_REPO}/.git/overlay-workdir/mkdocs"

        echo
        echo "    Getting parent source ref: git holo source ls ${DOCS_PARENT_SOURCE}"
        local docs_parent_ref
        docs_parent_ref="$(git holo source ls "${DOCS_PARENT_SOURCE}" | awk '{print $2}')"
        if [ $? -ne 0 ] || [ -z "${docs_parent_ref}" ]; then
            echo
            echo "    Failed to find ref for source ${DOCS_PARENT_SOURCE}, try: git holo source fetch ${DOCS_PARENT_SOURCE}"
            return 1
        fi

        echo
        echo "    Building parent tree: git holo project --ref=${docs_parent_ref} ${docs_parent_holobranch}"
        local docs_parent_tree
        docs_parent_tree="$(git holo project --ref="${docs_parent_ref}" "${docs_parent_holobranch}")"
        if [ $? -ne 0 ] || [ -z "${docs_parent_tree}" ]; then
            echo
            echo "    Failed to build tree for parent docs"
            return 1
        fi

        echo
        echo "    Exporting parent tree: ${docs_parent_tree}"
        [ -d "/hab/cache/mkdocs/parent" ] && rm -r "/hab/cache/mkdocs/parent"
        mkdir -p "/hab/cache/mkdocs/parent"
        git archive "${docs_parent_tree}" --format=tar | (cd "/hab/cache/mkdocs/parent"; tar -xvf -)


        if mount | grep -q '/hab/cache/mkdocs/merged/docs'; then
            echo
            echo "    Deactivating existing mount..."
            umount '/hab/cache/mkdocs/merged/docs'
        fi

        echo
        echo "    Merging configuration..."
        if [ -f "${DOCS_REPO}/mkdocs.yml" ]; then
            hab pkg exec jarvus/yaml-merge yaml-merge \
                "${DOCS_REPO}/mkdocs.yml" \
                > "/hab/cache/mkdocs/merged/mkdocs.yml"
        elif [ -f "/hab/cache/mkdocs/parent/mkdocs.yml" ]; then
            (
                cd "/hab/cache/mkdocs/parent"
                shopt -s nullglob
                config_overrides=(/hab/cache/mkdocs/parent/mkdocs.*.yml "${DOCS_REPO}"/mkdocs.*.yml)
                if [ ${#config_overrides[@]} -ne 0 ]; then
                    echo "$( IFS=' '; echo "    merging mkdocs.yml overrides: ${config_overrides[*]}")"
                fi

                hab pkg exec jarvus/yaml-merge yaml-merge \
                    mkdocs.yml \
                    ${config_overrides[*]} \
                    > "/hab/cache/mkdocs/merged/mkdocs.yml"
            )
        else
            echo
            echo "    No mkdocs.yml found in repo or parent"
            return 1
        fi

        if [ -d "/hab/cache/mkdocs/parent/.holo" ]; then
            echo
            echo "    Copying holo lenses..."
            cp -rv "/hab/cache/mkdocs/parent/.holo" "/hab/cache/mkdocs/merged/"
        fi

        echo
        echo "    Setting up overlay mount..."
        mount \
            -t overlay \
            -o lowerdir="/hab/cache/mkdocs/parent/${docs_content_dir}",upperdir="${DOCS_REPO}/${docs_content_dir}",workdir="${DOCS_REPO}/.git/overlay-workdir/mkdocs" \
            overlay "/hab/cache/mkdocs/merged/${docs_content_dir}"

        docs_root="/hab/cache/mkdocs/merged"
    fi


    echo
    echo "--> Discovering required python packages..."
    local requirements
    IFS=' ' read -r -a requirements <<< "${DOCS_REQUIREMENTS}"

    if [ ${#requirements[@]} -eq 0 ]; then
        echo "\$DOCS_REQUIREMENTS not defined in environment"
        local docs_holobranch="${DOCS_HOLOBRANCH:-gh-pages}"
        local lens_config_path="${docs_root}/.holo/branches/${docs_holobranch}.lenses/mkdocs.toml"

        if [ ! -f "${lens_config_path}" ]; then
            echo "Also did not find ${lens_config_path}"
            lens_config_path="${docs_root}/.holo/lenses/mkdocs.toml"
        fi

        if [ -f "${lens_config_path}" ]; then
            echo "Loading requirements from ${lens_config_path}"
            IFS=' ' read -r -a requirements <<< "$(hab pkg exec jarvus/stoml stoml "${lens_config_path}" hololens.requirements)"
        else
            echo "Also did not find ${lens_config_path}"

            # try looking inside holobranch
            echo "Looking for lens within holobranch ${docs_holobranch}"
            pushd "${docs_root}" > /dev/null
            local docs_holo_tree
            docs_holo_tree="$(git holo project --working --no-lens "${docs_holobranch}")"
            if [ $? -eq 0 ] && [ -n "${docs_holo_tree}" ]; then
                lens_config_path="${docs_holo_tree}:.holo/lenses/mkdocs.toml"
                echo "Looking for ${lens_config_path}"

                if [ "blob" == "$(git cat-file -t "${lens_config_path}")" ]; then
                    echo "Loading requirements from ${lens_config_path}"
                    IFS=' ' read -r -a requirements <<< "$(hab pkg exec jarvus/stoml stoml <(git cat-file -p "${lens_config_path}") hololens.requirements)"
                fi

            else
                echo "Failed to read projection result"
            fi
            popd > /dev/null
        fi
    fi

    echo

    hab pkg exec jarvus/mkdocs python -m venv "/hab/cache/mkdocs/venv"

    (
        set -e # exit subshell if any commands fail
        set -h # turn on a shell feature so activate can turn it back off without tripping -e

        cd "${docs_root}"
        source "/hab/cache/mkdocs/venv/bin/activate";

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
