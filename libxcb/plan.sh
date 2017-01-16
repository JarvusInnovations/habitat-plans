pkg_name=libxcb
pkg_origin=core
pkg_version=1.12
pkg_description="X.org X11Proto protocol headers."
pkg_upstream_url=https://cgit.freedesktop.org/xorg/proto/xproto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"=
pkg_source=https://www.x.org/archive/individual/xcb/libxcb-${pkg_version}.tar.bz2
pkg_shasum=4adfb1b7c67e99bc9c2ccb110b2f175686576d2f792c8a71b9c8b19014057b5b
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/gcc
  core/python2
  core/pkg-config
  jarvus/xcb-proto
  jarvus/libXau
  jarvus/libpthread-stubs
  jarvus/libx11proto
)
