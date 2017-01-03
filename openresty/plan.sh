origin=jarvus
pkg_name=openresty
pkg_version=1.11.2.2
pkg_description="OpenResty is a full-fledged web application server by bundling the standard nginx core, lots of 3rd-party nginx modules, as well as most of their external dependencies."
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=('BSD-2-Clause')
pkg_upstream_url=https://openresty.org
pkg_source=https://openresty.org/download/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=7f9ca62cfa1e4aedf29df9169aed0395fd1b90de254139996e554367db4d5a01
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(
  core/glibc
  core/perl
  #core/libedit
  #core/ncurses
  #core/bzip2
)
pkg_build_deps=(
  core/gcc
  core/make
  core/coreutils

  # libraries that MAY be needed at runtime too, check LDD:
  core/zlib
  core/openssl
  core/pcre
  core/postgresql
  core/geoip
)
pkg_bin_dirs=(bin nginx/sbin luajit/bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(80 443)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-ld-opt="${LDFLAGS}" \
    --with-cc-opt="${CFLAGS}" \
    --with-libpq="$(pkg_path_for postgresql)" \
    --with-pcre-jit \
    --with-luajit \
    --with-http_v2_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_geoip_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_sub_module \
    --with-ipv6 \
    --with-http_stub_status_module \
    --with-http_secure_link_module \
    --with-http_sub_module \
    --with-http_postgres_module

    make -j
}

# Workaround from: https://github.com/habitat-sh/habitat/issues/1041)
# This makes /usr/bin/env available to all scripts
do_prepare() {
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv $(pkg_path_for coreutils)/bin/env /usr/bin/env
    _clean_env=true
  fi
}

do_end() {
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}

