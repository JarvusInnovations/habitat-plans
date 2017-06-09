#
# This package is NOT officially supported by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=recordproto
pkg_origin=xorg
pkg_version=1.14.2
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Protocol Headers: recordproto"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="a777548d2e92aa259f1528de3c4a36d15e07a4650d0976573a8e2ff5437e7370"
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
    make check
}
