pkg_name=idl
pkg_origin=core
pkg_version=0.8.14
pkg_source=https://ftp.gnome.org/pub/gnome/sources/libIDL/${pkg_version%.*}/libIDL-${pkg_version}.tar.gz
pkg_shasum=bca99570f1ab453e11ae627b209561019cde5aaa98f71f43cc6da048d3bc7e72
pkg_dirname=libIDL-${pkg_version}

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_deps=(
  core/glib
  core/pcre
)

pkg_build_deps=(
  core/gcc
  core/pkg-config
  core/make
  core/flex
  core/bison2
)

