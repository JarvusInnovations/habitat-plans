#
# This package is NOT officially supported by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=libXtst
pkg_origin=xorg
pkg_version=1.2.3
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Libraries: libXtst"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="4655498a1b8e844e3d6f21f3b2c4e2b571effb5fd83199d428a6ba7ea4bf5204"
pkg_deps=(core/glibc xorg/xlib xorg/libxcb xorg/libXau xorg/libXdmcp xorg/libxext jarvus/libXi)
pkg_build_deps=(core/gcc core/make core/pkg-config xorg/xproto xorg/kbproto xorg/renderproto xorg/inputproto xorg/xextproto xorg/libpthread-stubs jarvus/libXfixes jarvus/fixesproto jarvus/recordproto)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
