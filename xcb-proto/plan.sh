pkg_name=xcb-proto
pkg_origin=core
pkg_version=1.12
pkg_description="X.org X11Proto protocol headers."
pkg_upstream_url=https://cgit.freedesktop.org/xorg/proto/xproto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"=
pkg_source=https://www.x.org/archive/individual/xcb/xcb-proto-${pkg_version}.tar.bz2
pkg_shasum=5922aba4c664ab7899a29d92ea91a87aa4c1fc7eb5ee550325c3216c480a4906
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/python2
)
