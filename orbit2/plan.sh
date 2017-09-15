pkg_name=orbit2
pkg_origin=core
pkg_version=2.14.19
pkg_source=ftp://ftp.gnome.org/pub/gnome/sources/ORBit2/${pkg_version%.*}/ORBit2-${pkg_version}.tar.gz
pkg_shasum=5724ed85c626ce406156d2f7c4d104d670eb82cf78e582c325e713a31632c9bd
pkg_dirname=ORBit2-${pkg_version}

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

pkg_deps=(
  core/glib
  core/glibc
  core/pcre

  jarvus/idl
)

pkg_build_deps=(
  core/gcc
  core/pkg-config
  core/make
)

do_build() {
    attach
    # currently fails due to: https://stackoverflow.com/questions/25590498/cannot-build-orbit2-fix-apparently-found-but-where-is-it
    do_default_build
    attach
}