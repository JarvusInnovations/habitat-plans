pkg_name="webdav-sync"
pkg_origin="jarvus"
pkg_version="0.5.0"
pkg_description="Sync local files and directories to a WebDAV server"
pkg_upstream_url="https://github.com/bermi/webdav-sync"
pkg_license=("MIT")
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_source="https://github.com/bermi/webdav-sync/archive/v${pkg_version}.tar.gz"
pkg_shasum="f5a93c77a8f2174c515b95b9056156ef24c830ae82c101669d6daea8efe51731"

pkg_bin_dirs=(bin)

pkg_build_deps=(
  pkg-config
)

pkg_deps=(
  core/node
  core/curl
)


# implement build workflow
do_build() {
  pushd "${CACHE_PATH}" > /dev/null

  build_line "Installing dependencies with NPM"
  npm install

  build_line "Fixing interpreter"
  sed -e "s#\#\!/usr/bin/env node#\#\!$(pkg_path_for node)/bin/node#" --in-place "bin/webdav-sync"

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