pkg_name=libX11
pkg_origin=core
pkg_version=1.6.4
pkg_description="Core X11 protocol client library"
pkg_upstream_url=https://github.com/mirror/libX11
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/mirror/libX11/archive/libX11-${pkg_version}.tar.gz
pkg_shasum=9c8555574f4d8a886fae560ddd0a952cd2647afb5469e26a20af8c8582b77eee
pkg_dirname="${pkg_name}-${pkg_name}-${pkg_version}"
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/gcc
  core/make
  core/autoconf
  core/automake
  core/libtool
  core/m4
  core/pkg-config
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
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/coreutils
)


do_build() {
  export ACLOCAL_PATH="$(pkg_path_for automake)/share/aclocal/:$(pkg_path_for pkg-config)/share/aclocal/:$(pkg_path_for libtool)/share/aclocal/:$(pkg_path_for xorg-macros)/share/aclocal/:$(pkg_path_for libxtrans)/share/aclocal/"

  ./autogen.sh  --prefix="${pkg_prefix}"

  make
}