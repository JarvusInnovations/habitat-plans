pkg_name=libpthread-stubs
pkg_origin=core
pkg_version=0.3
pkg_description="X Network Transport layer shared code"
pkg_upstream_url=https://cgit.freedesktop.org/xorg/lib/libxtrans
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/xcb/libpthread-stubs-${pkg_version}.tar.bz2
pkg_shasum=35b6d54e3cc6f3ba28061da81af64b9a92b7b757319098172488a660e3d87299
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/gcc
)
