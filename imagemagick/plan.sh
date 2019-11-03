pkg_name=imagemagick
pkg_origin=jarvus
pkg_version=7.0.9-2
pkg_description="A software suite to create, edit, compose, or convert bitmap images."
pkg_upstream_url="http://imagemagick.org/"
pkg_license=('Apache2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://www.imagemagick.org/download/releases/ImageMagick-${pkg_version}.tar.xz
pkg_shasum=459675a44f4aa1f68ba079b8ba0a83cd1c07b4530a67311082be3c863f601e9a
pkg_deps=(
    core/gcc-libs
    core/glibc
    core/libjpeg-turbo
    core/libpng
    core/xz
    core/zlib
)
pkg_build_deps=(
    core/coreutils
    core/diffutils
    core/gcc
    core/glibc
    core/make
    core/patch
    core/pkg-config
    core/sed
    core/zlib
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/ImageMagick-6)
pkg_lib_dirs=(lib)
pkg_dirname=ImageMagick-${pkg_version}

do_build() {
    CC="gcc -std=gnu99" ./configure --prefix=$pkg_prefix
    make
}
