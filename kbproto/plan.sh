pkg_name=kbproto
pkg_origin=core
pkg_version=1.0.7
pkg_description="X.org X11Proto protocol headers."
pkg_upstream_url=https://cgit.freedesktop.org/xorg/proto/xproto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/proto/kbproto-${pkg_version}.tar.bz2
pkg_shasum=f882210b76376e3fa006b11dbd890e56ec0942bc56e65d1249ff4af86f90b857
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/gcc
)
