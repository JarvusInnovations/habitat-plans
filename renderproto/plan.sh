pkg_name=renderproto
pkg_origin=core
pkg_version=0.11
pkg_description="X.org X11Proto protocol headers."
pkg_upstream_url=https://cgit.freedesktop.org/xorg/proto/xproto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.x.org/archive/individual/proto/renderproto-${pkg_version}.tar.bz2
pkg_shasum=c4d1d6d9b0b6ed9a328a94890c171d534f62708f0982d071ccd443322bedffc2
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
)
