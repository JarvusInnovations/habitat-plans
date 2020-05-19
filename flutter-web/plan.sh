pkg_name=flutter-web
pkg_origin=jarvus
pkg_version="1.18.0-11.1.pre"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=("BSD 3-Clause")

pkg_deps=(
  core/bash
  core/coreutils
  core/curl
  core/git
  core/glibc
  core/tar
  core/unzip
  core/which
  core/xz
  core/zip
)

pkg_build_deps=(
  core/patchelf
)

pkg_bin_dirs=(bin)

cache_dart_version="2.9.0-8.2.beta"
cache_dart_source="https://storage.googleapis.com/dart-archive/channels/beta/release/${cache_dart_version}/sdk/dartsdk-linux-x64-release.zip"
cache_dart_filename="dartsdk-${cache_dart_version}.zip"
cache_dart_shasum=ac2a85c4fd4918b580175d259464dd82b7153236e202265d39cba8d9ef845ba1


do_begin() {
  if [[ ! -e "/usr/bin/env" ]]; then
    mkdir -p /usr/bin
    hab pkg binlink core/coreutils env -d /usr/bin
    _env_binlink=true
  fi

  if [[ ! -e "/lib64/ld-linux-x86-64.so.2" ]]; then
    mkdir -p /lib64
    ln -sv "$(hab pkg path core/glibc)/lib/ld-linux-x86-64.so.2" "/lib64/ld-linux-x86-64.so.2"
    _ld_solink=true
  fi
}

do_download() {
    download_file "${cache_dart_source}" "${cache_dart_filename}" "${cache_dart_shasum}"
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  pushd "${pkg_prefix}" > /dev/null

  build_line "Cloning Flutter SDK"
  rm -r bin
  git clone --branch "${pkg_version}" --depth 1 "https://github.com/flutter/flutter" .

  build_line "Caching Dart SDK"
  mkdir bin/cache
  unzip "${HAB_CACHE_SRC_PATH}/${cache_dart_filename}" -d bin/cache
  find bin/cache/dart-sdk -type d -exec chmod 755 {} \;
  find bin/cache/dart-sdk -type f -perm /u+x -exec chmod a+x,a+r {} \;
  cp bin/internal/engine.version bin/cache/engine-dart-sdk.stamp

  build_line "Fixing bash interpreters"
  grep -nrlI '^\#\!/usr/bin/env' . | while read -r target; do
    echo "${target}"
    sed -e "s#\#\!/usr/bin/env sh#\#\!$(pkg_path_for bash)/bin/sh#" -i "${target}"
    sed -e "s#\#\!/usr/bin/env bash#\#\!$(pkg_path_for bash)/bin/bash#" -i "${target}"
  done

  # build_line "Fixing ELF interpreters"
  # find . -type f -executable \
  #     -exec sh -c 'file -i "$1" | grep -q "x-\(pie-\)\?executable; charset=binary"' _ {} \; \
  #     -print \
  #     -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" {} \;

  build_line "Running flutter precache"
  flutter precache \
    --verbose \
    --web \
    --no-android \
    --no-ios \
    --no-linux \
    --no-windows \
    --no-macos \
    --no-fuchsia \
    --no-universal

  build_line "Preparing for web builds"
  flutter config --enable-web

  pushd "${HAB_CACHE_SRC_PATH}" > /dev/null
  flutter create "flutter_web_app" # easiest way to pre-populate cache with web artifacts
  rm -rf "./flutter_web_app"
  popd > /dev/null

  build_line "Making version and cache directory openly writable"
  chmod -R go+w version bin/cache/

  popd > /dev/null
}

do_end() {
  if [[ -v $_env_binlink ]]; then
    rm -f "/usr/bin/env"
  fi

  if [[ -v $_ld_solink ]]; then
    rm -f "/lib64/ld-linux-x86-64.so.2"
  fi
}
