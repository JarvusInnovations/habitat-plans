pkg_name=libx11proto
pkg_origin=core
pkg_version=7.0.31
pkg_description="X.org X11Proto protocol headers."
pkg_upstream_url=https://cgit.freedesktop.org/xorg/proto/xproto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/proto/xproto-${pkg_version}.tar.bz2
pkg_shasum=c6f9747da0bd3a95f86b17fb8dd5e717c8f3ab7f0ece3ba1b247899ec1ef7747
pkg_dirname="xproto-${pkg_version}"
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/gcc
)
