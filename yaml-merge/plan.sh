pkg_name="yaml-merge"
pkg_origin="jarvus"
pkg_version="4.0.0"
pkg_description="A super simple tool for merging YAML files"
pkg_upstream_url="https://github.com/alexlafroscia/yaml-merge"
pkg_maintainer="Jarvus Innovations <hello@jarv.us>"
npm_scope="alexlafroscia"

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
  npm install "@${npm_scope}/${pkg_name}@${pkg_version}"

  build_line "Fixing interpreters"
  sed -e "s#\#\!/usr/bin/env node#\#\!$(pkg_path_for node14)/bin/node#" --in-place --follow-symlinks node_modules/.bin/*

  popd > /dev/null
}

do_strip() {
  return 0
}
