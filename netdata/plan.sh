pkg_name=netdata
pkg_origin=jarvus
pkg_version=1.20.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="netdata is a system for distributed real-time performance and health monitoring."
pkg_upstream_url="https://github.com/netdata/netdata"
pkg_source="https://github.com/netdata/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=c739e0fa8d6d7f433c0c7c8016b763e8f70519d67f0b5e7eca9ee5318f210d90
pkg_build_deps=(
  core/autoconf
  core/autogen
  core/automake
  core/gcc
  core/make
  core/pkg-config
)
pkg_deps=(
  core/bash
  core/coreutils
  core/curl
  core/gawk
  core/glibc
  core/libuv
  core/mysql-client
  core/netcat
  core/node
  core/python
  core/sed
  core/util-linux
  core/which
  core/zlib
)
pkg_bin_dirs=(sbin)
pkg_exports=(
  [host]=server.address
  [port]=server.port
)
pkg_exposes=(port)
pkg_svc_run="netdata -D -c ${pkg_svc_config_path}/netdata.conf"


do_setup_environment() {
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python3.7/site-packages"

  set_runtime_env -f NETDATA_PKG_CONFIG_DIR "${pkg_prefix}/etc/netdata"
  set_runtime_env -f NETDATA_PKG_WEB_DIR "${pkg_prefix}/share/netdata/web"
}

do_prepare() {
  python -m venv "${pkg_prefix}"
  source "${pkg_prefix}/bin/activate"
}

do_build() {
  # patch shell script shebang lines to use habitat-provided env
  fix_interpreter "./*.sh" core/coreutils bin/env

  ACLOCAL_PATH="$(pkg_path_for core/pkg-config)/share/aclocal" autoreconf -ivf
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-zlib \
    --with-math \
    --with-user="${pkg_svc_user}"

  make
}

do_install() {
  do_default_install || return $?

  pushd "${pkg_prefix}" > /dev/null

  # delete edit script, it won't work with Habitat
  rm "${pkg_prefix}/etc/netdata/edit-config"

  build_line "Fixing libexec interpreters"
  find ./libexec/netdata -type f -executable \
    -print \
    -exec bash -c 'sed -e "s#\#\!/usr/bin/env bash#\#\!$1/bin/bash#" --in-place "$2"' _ "$(pkg_path_for bash)" "{}" \;

  build_line "Installing python dependencies"
  pip install "mysqlclient"
  pip freeze > requirements.txt

  popd > /dev/null
}
