pkg_name=json-c
pkg_origin=core
pkg_version=0.12.1
pkg_description="A JSON implementation in C"
pkg_upstream_url=https://github.com/json-c/json-c
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://s3.amazonaws.com/json-c_releases/releases/json-c-${pkg_version}.tar.gz
pkg_shasum=2a136451a7932d80b7d197b10441e26e39428d67b1443ec43bbba824705e1123
pkg_build_deps=(
  core/gcc
  core/make
  core/autoconf
)
pkg_deps=(
  core/glibc
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
