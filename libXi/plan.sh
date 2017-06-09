#
# This package is NOT officially supported by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=libXi
pkg_origin=xorg
pkg_version=1.7.9
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Libraries: libXi"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="c2e6b8ff84f9448386c1b5510a5cf5a16d788f76db018194dacdc200180faf45"
pkg_deps=(core/glibc xorg/xlib xorg/libxext xorg/libxcb xorg/libXau xorg/libXdmcp)
pkg_build_deps=(core/gcc core/make core/pkg-config xorg/xproto xorg/xextproto xorg/kbproto xorg/inputproto xorg/libpthread-stubs jarvus/libXfixes jarvus/fixesproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
