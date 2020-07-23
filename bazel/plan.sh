pkg_name=bazel
pkg_origin=core
pkg_version='3.4.1'
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Apache-2.0')
pkg_description="Build and test software of any size, quickly and reliably"
pkg_upstream_url='https://www.bazel.build/'
pkg_source="https://github.com/bazelbuild/bazel/releases/download/${pkg_version}/${pkg_name}-${pkg_version}-dist.zip"
pkg_shasum='27af1f11c8f23436915925b25cf6e1fb07fccf2d2a193a307c93437c60f63ba8'
pkg_build_deps=(
  core/libarchive
  core/patch
  core/patchelf
  core/protobuf-cpp
  core/which
)
pkg_deps=(
  core/bash
  core/coreutils
  core/corretto11
  core/gawk
  core/gcc
  core/git
  core/glibc
  core/go
  core/gzip
  core/python
  core/tar
  core/unzip
  core/zip
)
pkg_bin_dirs=(bin)

do_prepare() {
  pushd .. >/dev/null
  patch -p1 -i "${PLAN_CONTEXT}/do_not_clear_env.patch"
  popd >/dev/null
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_setup_environment() {
 set_runtime_env SSL_CERT_FILE "$(pkg_path_for cacerts)/ssl/certs/cacert.pem"
}

do_build() {
  pushd .. >/dev/null
  export TMPDIR=/tmp
  export LD_LIBRARY_PATH="${LD_RUN_PATH}"
  export EXTRA_BAZEL_ARGS="--host_javabase=@local_jdk//:jdk"
  ./compile.sh || return $?
  popd >/dev/null
}

do_install() {
  pushd .. >/dev/null
  build_line "Patching binary with rpath: ${LD_RUN_PATH}"
  patchelf --set-rpath "${LD_RUN_PATH}" ./output/bazel
  mkdir -p "${pkg_prefix}/"{bin,bin.real}
  cp ./output/bazel "${pkg_prefix}/bin.real/bazel"
  cat <<END_OF_WRAPPER > "${pkg_prefix}/bin/bazel"
#!$(pkg_path_for bash)/bin/bash

set -a
source "${pkg_prefix}/RUNTIME_ENVIRONMENT"
set +a

export LD_LIBRARY_PATH="${LD_RUN_PATH}"

exec ${pkg_prefix}/bin.real/bazel \
  "\$@"
END_OF_WRAPPER
  chmod +x "${pkg_prefix}/bin/bazel"
  popd >/dev/null
}

do_end() {
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}

do_strip() {
  return 0
}
