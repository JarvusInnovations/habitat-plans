pkg_name=netdata
pkg_origin=jarvus
pkg_version="1.10.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0")
pkg_description="netdata is a system for distributed real-time performance and health monitoring."
pkg_upstream_url="https://github.com/firehol/netdata"
pkg_source="https://github.com/firehol/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="645b1cb60a779132c816d1bad377574884992c214bbb0f7a483649878884dbab"

pkg_build_deps=(
  core/autoconf
  core/autogen
  core/automake
  core/pkg-config
  core/gcc
  core/make
)


pkg_deps=(
  core/glibc
  core/util-linux
  core/zlib

  # for fix_interpreter
  core/coreutils
)

pkg_bin_dirs=(sbin)
pkg_exports=(
  [host]=server.address
  [port]=server.port
)
pkg_exposes=(port)
pkg_svc_run="netdata -D -c ${pkg_svc_config_path}/netdata.conf"


do_build() {
  # patch shell script shebang lines to use habitat-provided env
  fix_interpreter "./*.sh" core/coreutils bin/env

  ACLOCAL_PATH="$(pkg_path_for core/pkg-config)/share/aclocal" ./autogen.sh

  ./configure \
    --prefix="${pkg_prefix}" \
    --with-zlib \
    --with-math \
    --with-user="${pkg_svc_user}"

  make
}

do_install() {
  do_default_install || return $?

  rm -r "${pkg_prefix}/var"
}
