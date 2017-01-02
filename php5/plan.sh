pkg_name=php5
pkg_distname=php
pkg_origin=core
pkg_version=5.6.23
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('PHP-3.01')
pkg_upstream_url=http://php.net/
pkg_description="PHP is a popular general-purpose scripting language that is especially suited to web development."
pkg_source=https://php.net/get/${pkg_distname}-${pkg_version}.tar.bz2/from/this/mirror
pkg_filename=${pkg_distname}-${pkg_version}.tar.bz2
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_shasum=facd280896d277e6f7084b60839e693d4db68318bfc92085d3dc0251fd3558c7
pkg_deps=(
  core/curl
  core/openssl
  core/zlib
  core/libxml2
  core/glibc
)
pkg_build_deps=(
  core/bison2
  core/gcc
  core/make
  core/re2c
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_interpreters=(bin/php)

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --enable-exif \
    --enable-fpm \
    --enable-mbstring \
    --enable-opcache \
    --with-curl="$(pkg_path_for curl)" \
    --with-openssl="$(pkg_path_for openssl)" \
    --with-xmlrpc \
    --with-zlib="$(pkg_path_for zlib)" \
    --with-libxml-dir="$(pkg_path_for libxml2)"

  make

  return $?
}

do_check() {
  make test

  return $?
}