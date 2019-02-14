pkg_name="htpasswd"
pkg_origin="jarvus"
pkg_version="2.4.0"
pkg_description="Node.js package for HTTP Basic Authentication password file utility."
pkg_upstream_url="https://github.com/http-auth/htpasswd"
pkg_license=("MIT")
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_source="https://github.com/http-auth/htpasswd/archive/${pkg_version}.tar.gz"
pkg_shasum="38e8832f5c1e3aeb8cfb52ccb652a2393b090fa1135dcfa8acd23dcf737d3de5"

pkg_bin_dirs=(bin)

pkg_deps=(
  core/node
)


# implement build workflow
do_build() {
  pushd "${CACHE_PATH}" > /dev/null

  build_line "Installing dependencies with NPM"
  npm install

  build_line "Fixing interpreter"
  sed -e "s#\#\!/usr/bin/env node#\#\!$(pkg_path_for node)/bin/node#" --in-place "bin/htpasswd"

  popd > /dev/null
}

do_install() {
  pushd "${CACHE_PATH}" > /dev/null
  cp -r ./* "${pkg_prefix}/"
  chmod +x "${pkg_prefix}/bin/"*
  popd > /dev/null
}

do_strip() {
  return 0
}