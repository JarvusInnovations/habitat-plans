pkg_origin=jarvus
pkg_name=ghostscript
pkg_version=9.50

pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=('AGPLv3')
pkg_description="Ghostscript is a versatile processor for PostScript data with the ability to render PostScript to different targets."
pkg_upstream_url=https://www.ghostscript.com/
pkg_source=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${pkg_version//.}/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=db9bb0817b6f22974e6d5ad751975f346420c2c86a0afcfe6b4e09c47803e7d4
pkg_deps=(
  core/glibc
  core/libtiff
)
pkg_build_deps=(
  core/coreutils
  core/m4
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/libtool
  core/pkg-config
  core/automake
  core/autoconf
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  ./configure \
    --prefix=${pkg_prefix} \
    --disable-cups \
    --disable-compile-inits \
    --disable-gtk \
    --disable-fontconfig \
    --without-libidn \
    --with-system-libtiff \
    --without-x
}

do_install() {
  make install
  make soinstall

  install -v -m644 base/*.h ${pkg_prefix}/include/ghostscript
  ln -v -s ghostscript ${pkg_prefix}/include/ps
}
