pkg_name=libXext
pkg_origin=core
pkg_version=1.3.3
pkg_description="Core X11 protocol client library"
pkg_upstream_url=https://github.com/mirror/libX11
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/lib/libXext-${pkg_version}.tar.gz
pkg_shasum=eb0b88050491fef4716da4b06a4d92b4fc9e76f880d6310b2157df604342cfe5
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
)