pkg_name=libxtrans
pkg_origin=core
pkg_version=1.3.5
pkg_description="X Network Transport layer shared code"
pkg_upstream_url=https://cgit.freedesktop.org/xorg/lib/libxtrans
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/lib/xtrans-${pkg_version}.tar.bz2
pkg_shasum=adbd3b36932ce4c062cd10f57d78a156ba98d618bdb6f50664da327502bc8301
pkg_dirname="xtrans-${pkg_version}"
pkg_include_dirs=(include)
pkg_build_deps=(
  core/make
  core/gcc
)
