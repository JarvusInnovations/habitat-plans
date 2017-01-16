pkg_name=libXau
pkg_origin=core
pkg_version=1.0.8
pkg_description="X Network Transport layer shared code"
pkg_upstream_url=https://cgit.freedesktop.org/xorg/lib/libxtrans
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/lib/libXau-${pkg_version}.tar.bz2
pkg_shasum=fdd477320aeb5cdd67272838722d6b7d544887dfe7de46e1e7cc0c27c2bea4f2
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/gcc
  core/pkg-config
  jarvus/libx11proto
)
