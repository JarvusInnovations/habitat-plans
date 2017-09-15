pkg_name=dbus-glib
pkg_origin=core
pkg_version=0.108
pkg_source=https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-${pkg_version}.tar.gz
pkg_shasum=9f340c7e2352e9cdf113893ca77ca9075d9f8d5e81476bf2bf361099383c602c

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_deps=(
  core/expat
  core/dbus
  core/glib
  core/pcre
  core/zlib
  core/glibc
)

pkg_build_deps=(
  core/gcc
  core/pkg-config
  core/make
)

