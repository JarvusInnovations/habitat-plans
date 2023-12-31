#
# This package is NOT officially support by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=libxfont
pkg_distname=libXfont
pkg_origin=xorg
pkg_version=1.4.5
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Libraries: libXfont"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/current/src/everything/${pkg_distname}-${pkg_version}.tar.bz2"
pkg_shasum=bbf96fb80b6b95cdb1dc968085082a6e668193a54cd9d6e2af669909c0cb7170
pkg_deps=(core/glibc core/freetype core/zlib core/bzip2 core/libpng xorg/libfontenc)
pkg_build_deps=(core/gcc core/make core/pkg-config xorg/xproto xorg/xtrans xorg/fontsproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
