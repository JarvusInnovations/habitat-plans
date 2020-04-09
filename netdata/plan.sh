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
  core/go
  core/make
  core/pkg-config
)
pkg_deps=(
  core/bash
  core/coreutils
  core/curl
  core/gawk
  core/glibc
  core/grep
  core/jq-static
  core/libuv
  core/mysql-client
  core/netcat
  core/node
  core/postgresql11-client
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
pkg_svc_user="root"
pkg_svc_run="netdata -D -c ${pkg_svc_config_path}/conf.d/netdata.conf"

plugin_go_version=0.18.0
plugin_go_source="https://github.com/netdata/go.d.plugin/archive/v${plugin_go_version}.tar.gz"
plugin_go_filename="go.d.plugin-${plugin_go_version}.tar.gz"
plugin_go_dirname="go.d.plugin-${plugin_go_version}"
plugin_go_source_shasum=562018e328cbfa6f1e1427af1e4dbb2ab7bd7415c1c36cdcb3ba80e066cc13ec

do_setup_environment() {
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python3.7/site-packages"

  set_runtime_env -f NETDATA_PKG_CONFIG_DIR "${pkg_prefix}/etc/netdata"
  set_runtime_env -f NETDATA_PKG_WEB_DIR "${pkg_prefix}/share/netdata/web"
  set_runtime_env -f NETDATA_PKG_PLUGINS_DIR "${pkg_prefix}/libexec/netdata/plugins.d"
}

do_before() {
  plugin_go_cache_path="$HAB_CACHE_SRC_PATH/${plugin_go_dirname}"
}

do_download() {
  do_default_download
  download_file "${plugin_go_source}" "${plugin_go_filename}" "${plugin_go_source_shasum}"
}

do_verify() {
  do_default_verify
  verify_file "${plugin_go_filename}" "${plugin_go_source_shasum}"
}

do_clean() {
  do_default_clean
  rm -rf "${plugin_go_cache_path}"
}

do_unpack() {
  do_default_unpack
  unpack_file "${plugin_go_filename}"
}

do_prepare() {
  python -m venv "${pkg_prefix}"
  source "${pkg_prefix}/bin/activate"
}

do_build() {
  # patch shell script shebang lines to use habitat-provided env
  fix_interpreter "./*.sh" core/coreutils bin/env

  # see https://github.com/netdata/netdata/blob/master/netdata-installer.sh
  build_line "Building netdata"
  ACLOCAL_PATH="$(pkg_path_for core/pkg-config)/share/aclocal" autoreconf -ivf
  CFLAGS="${CFLAGS} -O2" ./configure \
    --prefix="${pkg_prefix}" \
    --with-zlib \
    --with-math \
    --with-user="${pkg_svc_user}"

  make

  # see https://github.com/netdata/go.d.plugin/blob/master/hack/go-build.sh
  build_line "Building go.d.plugin"
  pushd "${plugin_go_cache_path}" > /dev/null
  go mod download
  CGO_ENABLED=0 go build -o go.d.plugin -ldflags "-w -s -X main.version=${plugin_go_version}" github.com/netdata/go.d.plugin/cmd/godplugin
  popd > /dev/null
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
  pip install --upgrade pip
  pip install "mysqlclient" "psycopg2" "dnspython" "pymongo"
  pip freeze > requirements.txt

  build_line "Installing go.d.plugin"
  cp -v "${plugin_go_cache_path}/go.d.plugin" "./libexec/netdata/plugins.d/"
  cp -rv "${plugin_go_cache_path}/config"/* "./lib/netdata/conf.d/"

  popd > /dev/null
}
