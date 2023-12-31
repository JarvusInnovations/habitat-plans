#
# This package is NOT officially support by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=mkfontscale
pkg_origin=xorg
pkg_version=1.1.0
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Applications: mkfontdir"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/current/src/everything/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=ce55f862679b8ec127d7f7315ac04a8d64a0d90a0309a70dc56c1ba3f9806994
pkg_deps=(core/glibc core/zlib core/freetype xorg/libfontenc)
pkg_build_deps=(core/gcc core/make core/pkg-config core/libpng xorg/xproto)
pkg_bin_dirs=(bin)
