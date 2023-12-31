#
# This package is NOT officially support by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=libfontenc
pkg_origin=xorg
pkg_version=1.1.1
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Libraries: libfontenc"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/current/src/everything/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=de72812f1856bb63bd2226ec8c2e2301931d3c72bd0f08b0d63a0cdf0722017f
pkg_deps=(core/glibc core/zlib)
pkg_build_deps=(core/gcc core/make core/pkg-config xorg/xproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
