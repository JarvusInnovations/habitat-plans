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

pkg_build_deps=(
  core/git
)

pkg_deps=(
  core/coreutils
  core/node
)


# implement build workflow
do_build() {
  pushd "${CACHE_PATH}" > /dev/null

  build_line "Installing dependencies with NPM"
  npm install

  build_line "Fixing interpreter"
  fix_interpreter "bin/*" core/coreutils bin/env

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