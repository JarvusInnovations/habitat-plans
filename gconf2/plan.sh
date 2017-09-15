pkg_name=gconf2
pkg_origin=core
pkg_version=3.2.6
pkg_source=ftp://ftp.gnome.org/pub/GNOME/sources/GConf/${pkg_version%.*}/GConf-${pkg_version}.tar.xz
pkg_shasum=1912b91803ab09a5eed34d364bf09fe3a2a9c96751fde03a4e0cfa51a04d784c
pkg_dirname=GConf-${pkg_version}

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

pkg_deps=(
  core/glib
  core/pcre
  core/libxml2
  core/dbus

  jarvus/dbus-glib
)

pkg_build_deps=(
  core/gcc
  core/pkg-config
)

