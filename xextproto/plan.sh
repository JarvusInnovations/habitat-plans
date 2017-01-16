pkg_name=xextproto
pkg_origin=core
pkg_version=7.3.0
pkg_description="X.org X11Proto protocol headers."
pkg_upstream_url=https://cgit.freedesktop.org/xorg/proto/xproto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/proto/xextproto-${pkg_version}.tar.bz2
pkg_shasum=f3f4b23ac8db9c3a9e0d8edb591713f3d70ef9c3b175970dd8823dfc92aa5bb0
pkg_dirname="xextproto-${pkg_version}"
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/gcc
)
