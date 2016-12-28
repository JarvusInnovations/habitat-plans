origin=jarvus
pkg_name=openresty
pkg_version=1.9.15.1
pkg_description="OpenResty is a full-fledged web application server by bundling the standard nginx core, lots of 3rd-party nginx modules, as well as most of their external dependencies."
pkg_maintainer="Yichun Zhang <agentzh@gmail.com>"
pkg_license=('BSD-2-Clause')
pkg_upstream_url=https://openresty.org
pkg_source=https://openresty.org/download/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=75cf020144048c9013ee487cb48107a5b99de04a5a8fa83839c8b4c3aa4eb0db
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(core/glibc core/libedit core/ncurses core/zlib core/bzip2 core/openssl core/pcre)
pkg_build_deps=(core/gcc core/make core/coreutils core/perl)
pkg_bin_dirs=(bin nginx/sbin luajit/bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(80 443)

do_build() {
  ./configure --prefix=${pkg_prefix} \
              --with-pcre-jit \
              --with-ipv6 \
              --with-http_dav_module \
              --with-http_stub_status_module \
              --with-http_v2_module \
              --with-http_gunzip_module \
              --with-http_gzip_static_module \
              --with-http_realip_module \
              --with-http_ssl_module \
              --with-http_stub_status_module \
              --with-cc-opt="$CFLAGS" \
              --with-ld-opt="$LDFLAGS" \
              -j8
    make  -j8
}

do_install() {
  make install
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

