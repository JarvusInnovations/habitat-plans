pkg_name="underscore"
pkg_origin="jarvus"
pkg_version="0.2.19"
pkg_description="Command-line utility-belt for hacking JSON and Javascript."
pkg_upstream_url="https://github.com/ddopson/underscore-cli"
pkg_license=("BSD")
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_source="https://github.com/ddopson/underscore-cli/archive/v${pkg_version}.tar.gz"
pkg_shasum="2aa9d64268d9d29917615a6b1fa7f08fc4b88e7435e9192dc231e4c51b894cec"

pkg_bin_dirs=(bin)

# override because the repo name is underscore-cli
pkg_filename="underscore-cli-${pkg_version}.tar.gz"
pkg_dirname="underscore-cli-${pkg_version}"

pkg_deps=(
  core/node
)


# implement build workflow
do_build() {
  pushd "${CACHE_PATH}" > /dev/null

  build_line "Installing dependencies with NPM"
  npm install

  build_line "Fixing interpreter"
  sed -e "s#\#\!/usr/bin/env node#\#\!$(pkg_path_for node)/bin/node#" --in-place "bin/underscore"

  popd > /dev/null
}

do_install() {
  pushd "${CACHE_PATH}" > /dev/null
  cp -r ./* "${pkg_prefix}/"
  popd > /dev/null
}

do_strip() {
  return 0
}