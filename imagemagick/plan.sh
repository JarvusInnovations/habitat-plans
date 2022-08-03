pkg_name=imagemagick
pkg_origin=jarvus
pkg_version=7.1.0-45
pkg_description="A software suite to create, edit, compose, or convert bitmap images."
pkg_upstream_url="http://imagemagick.org/"
pkg_license=('Apache2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/ImageMagick/ImageMagick/archive/${pkg_version}.tar.gz
pkg_shasum=3df6ca6dff15a4e8a20b4593c60285a59e38890440494d91a344e5c0e2bb3eec
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
