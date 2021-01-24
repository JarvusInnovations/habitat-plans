pkg_name="nodemon"
pkg_origin="jarvus"
pkg_version="2.0.5"
pkg_description="nodemon is a tool that helps develop node.js based applications by automatically restarting the node application when file changes in the directory are detected."
pkg_upstream_url="https://nodemon.io/"
pkg_maintainer="Jarvus Innovations <hello@jarv.us>"

pkg_deps=(
  core/bash
  jarvus/node14
)

pkg_bin_dirs=(node_modules/.bin)

do_build() {
  return 0
}

do_install() {
  pushd "${pkg_prefix}" > /dev/null

  build_line "Installing ${pkg_name}@${pkg_version}"
  npm install "${pkg_name}@${pkg_version}"

  build_line "Fixing interpreters"
  sed -e "s#\#\!/usr/bin/env node#\#\!$(pkg_path_for node14)/bin/node#" --in-place --follow-symlinks node_modules/.bin/*

  popd > /dev/null
}
