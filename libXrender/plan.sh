pkg_name=libXrender
pkg_origin=core
pkg_version=0.9.10
pkg_description="Core X11 protocol client library"
pkg_upstream_url=https://github.com/mirror/libX11
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/lib/libXrender-${pkg_version}.tar.bz2
pkg_shasum=c06d5979f86e64cabbde57c223938db0b939dff49fdb5a793a1d3d0396650949
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config

  jarvus/libX11
  jarvus/xorg-macros
  jarvus/libxtrans
  jarvus/libx11proto
  jarvus/xextproto
  jarvus/inputproto
  jarvus/kbproto
  jarvus/libxcb
  jarvus/libpthread-stubs
  jarvus/xcb-proto
  jarvus/libXau

  jarvus/renderproto
)