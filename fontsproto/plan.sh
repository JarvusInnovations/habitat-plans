#
# This package is NOT officially support by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=fontsproto
pkg_origin=xorg
pkg_version=2.1.2
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Protocol Headers: fontsproto"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/current/src/everything/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=869c97e5a536a8f3c9bc8b9923780ff1f062094bab935e26f96df3d6f1aa68a9
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/pkg-config xorg/util-macros)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
