# References:
# - https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/compilers/flutter
# - https://github.com/NixOS/nixpkgs/issues/36759
#
# Releases: https://flutter.dev/docs/development/tools/sdk/releases?tab=linux

pkg_name=flutter
pkg_origin=jarvus
pkg_upstream_url="https://flutter.dev"
pkg_license=("BSD 3-Clause")
pkg_version="1.23.0-18.1.pre"
pkg_channel="beta"
pkg_filename="flutter_linux_${pkg_version}-${pkg_channel}.tar.xz" # TODO: drop v prefix beyond 1.15.x
pkg_dirname="flutter"
pkg_source="https://storage.googleapis.com/flutter_infra/releases/${pkg_channel}/linux/${pkg_filename}"
pkg_shasum="c8e3dba770228c28d3be4b8075d18a292dfcdda0a4c15a4229096facfe776984"
pkg_maintainer="Chris Alfano <chris@jarv.us>"

pkg_deps=(
  core/bash
  core/cacerts
  core/coreutils
  core/curl
  core/git
  core/glibc
  core/gzip
  core/tar
  core/unzip
  core/which
  core/xz
)

pkg_build_deps=(
  core/patch
  core/patchelf
)

pkg_bin_dirs=(bin)


do_setup_environment() {
  set_buildtime_env FLUTTER_ROOT "${CACHE_PATH}"
  set_buildtime_env FLUTTER_TOOLS_DIR "${CACHE_PATH}/packages/flutter_tools"
  set_buildtime_env SCRIPT_PATH "${CACHE_PATH}/packages/flutter_tools/bin/flutter_tools.dart"
  set_buildtime_env SNAPSHOT_PATH "${CACHE_PATH}/bin/cache/flutter_tools.snapshot"
  set_buildtime_env STAMP_PATH "${CACHE_PATH}/bin/cache/flutter_tools.stamp"
  set_buildtime_env DART_SDK_PATH "${CACHE_PATH}/bin/cache/dart-sdk"
  set_buildtime_env PUB_CACHE "${CACHE_PATH}/.pub-cache"

  set_buildtime_env DART "${CACHE_PATH}/bin/cache/dart-sdk/bin/dart"
  set_buildtime_env PUB "${CACHE_PATH}/bin/cache/dart-sdk/bin/pub"

  set_runtime_env DART_VM_OPTIONS "--root-certs-file=$(pkg_path_for cacerts)/ssl/certs/cacert.pem"
  set_runtime_env FLUTTER_SUPPRESS_ANALYTICS "true"
  set_runtime_env FLUTTER_WEB "true"
}

do_build() {
  build_line "Applying patches"
  for patch in "${PLAN_CONTEXT}/patches/"*.patch; do
    patch -p1 < "${patch}"
  done

  build_line "Fixing shebang lines"
  grep -nrlI '^\#\!/usr/bin/env' ./bin/ | while read -r target; do
    echo "${target}"
    sed -e "s#\#\!/usr/bin/env sh#\#\!$(pkg_path_for bash)/bin/sh#" -i "${target}"
    sed -e "s#\#\!/usr/bin/env bash#\#\!$(pkg_path_for bash)/bin/bash#" -i "${target}"
  done

  build_line "Fixing ELF interpreters"
  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-\(pie-\)\?executable; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" {} \;

  build_line "Running: pub upgrade"
  pushd "${FLUTTER_TOOLS_DIR}" > /dev/null
  "${PUB}" upgrade --offline
  popd > /dev/null

  build_line "Updating stamp and version"
  local revision="$(git rev-parse HEAD)"
  "${DART}" --snapshot="${SNAPSHOT_PATH}" --packages="${FLUTTER_TOOLS_DIR}/.packages" "${SCRIPT_PATH}"
  echo "${revision}" > "${STAMP_PATH}"
  echo -n "${pkg_version}" > version

  build_line "Cleaning up caches"
  rm -rf bin/cache/{artifacts,downloads}
  rm -f  bin/cache/*.stamp
  rm -rf .pub-cache

  return 0
}

do_install() {
  cp -r . "${pkg_prefix}"

  build_line "Wrapping flutter command"
  pushd "${pkg_prefix}" > /dev/null
  rm -v bin/flutter.bat
  cat <<END_OF_WRAPPER > "bin/flutter"
#!$(pkg_path_for bash)/bin/bash

set -a
source "${pkg_prefix}/RUNTIME_ENVIRONMENT"
set +a

export PUB_CACHE=\${PUB_CACHE:-"\$HOME/.pub-cache"}

exec ${pkg_prefix}/bin/cache/dart-sdk/bin/dart \
  --packages=${pkg_prefix}/packages/flutter_tools/.packages \
  ${DART_VM_OPTIONS} \
  ${pkg_prefix}/bin/cache/flutter_tools.snapshot \
  --no-version-check \
  "\$@"
END_OF_WRAPPER
  chmod +x "bin/flutter"
  popd > /dev/null
}

do_strip() {
  return 0
}
