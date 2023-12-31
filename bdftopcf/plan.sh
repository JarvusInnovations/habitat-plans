#
# This package is NOT officially support by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=bdftopcf
pkg_origin=xorg
pkg_version=1.0.3
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Applications: bdftopcf"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/current/src/everything/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=9c90b408b2fe079495697bfc8fb13da940b2b70f4907213bf5dcc9e3024a1d0a
pkg_deps=(core/glibc core/freetype core/zlib core/bzip2 core/libpng xorg/libfontenc xorg/libxfont)
pkg_build_deps=(core/gcc core/make core/pkg-config xorg/util-macros xorg/xproto xorg/fontsproto)
pkg_bin_dirs=(bin)
