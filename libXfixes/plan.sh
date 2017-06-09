#
# This package is NOT officially supported by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=libXfixes
pkg_origin=xorg
pkg_version=5.0.3
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Libraries: libXfixes"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="de1cd33aff226e08cefd0e6759341c2c8e8c9faf8ce9ac6ec38d43e287b22ad6"
pkg_deps=(core/glibc xorg/xlib xorg/libxcb xorg/libXau xorg/libXdmcp)
pkg_build_deps=(core/gcc core/make core/pkg-config xorg/xproto xorg/kbproto xorg/xextproto jarvus/fixesproto xorg/libpthread-stubs)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
