pkg_name=inputproto
pkg_origin=core
pkg_version=2.3.2
pkg_description="X.org X11Proto protocol headers."
pkg_upstream_url=https://cgit.freedesktop.org/xorg/proto/xproto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/proto/inputproto-${pkg_version}.tar.bz2
pkg_shasum=893a6af55733262058a27b38eeb1edc733669f01d404e8581b167f03c03ef31d
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/gcc
)
