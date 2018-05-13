pkg_name=libfcgi
pkg_origin=core
pkg_version="2.4.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("fastcgi")
pkg_source="http://ftp.debian.org/debian/pool/main/${pkg_name:0:4}/${pkg_name}/${pkg_name}_${pkg_version}.orig.tar.gz"
pkg_filename="${pkg_name}_${pkg_version}.orig.tar.gz"
pkg_dirname="${pkg_name}-${pkg_version}.orig"
pkg_shasum="c21f553f41141a847b2f1a568ec99a3068262821e4e30bc9d4b5d9091aa0b5f7"

pkg_build_deps=(
  core/make
  core/gcc
  core/patch
)

pkg_deps=(
  core/glibc
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)


do_build() {
  patch -p0 -i "${PLAN_CONTEXT}/stdio.patch"

  do_default_build
}
