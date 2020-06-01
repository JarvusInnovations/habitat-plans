pkg_name="nodemon"
pkg_origin="jarvus"
pkg_version="2.0.4"
pkg_description="nodemon is a tool that helps develop node.js based applications by automatically restarting the node application when file changes in the directory are detected."
pkg_upstream_url="https://nodemon.io/"
pkg_maintainer="Jarvus Innovations <hello@jarv.us>"

pkg_deps=(
  core/bash
  core/node
)

pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  pushd "${pkg_prefix}" > /dev/null

  build_line "Installing ${pkg_name}@${pkg_version}"
  npm install "${pkg_name}@${pkg_version}"

  build_line "Generating bin wrapper"
  cat <<EOF > "bin/nodemon"
#!$(pkg_path_for bash)/bin/bash

set -a
source "${pkg_prefix}/RUNTIME_ENVIRONMENT"
set +a

export PATH="${pkg_prefix}/node_modules/.bin:\${PATH}"

exec $(pkg_path_for node)/bin/node ${pkg_prefix}/node_modules/.bin/nodemon \$@
EOF
  chmod -v 755 "bin/nodemon"

  popd > /dev/null
}
