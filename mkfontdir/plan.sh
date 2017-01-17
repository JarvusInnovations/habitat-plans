#
# This package is NOT officially support by the Xorg project.  Please
# report bugs related to this package on GitHub:
#
# https://github.com/stevendanna/habitat-plans
#
pkg_name=mkfontdir
pkg_origin=xorg
pkg_version=1.0.7
pkg_maintainer="Steven Danna <steve@chef.io>"
pkg_description="X.Org Applications: mkfontdir"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/current/src/everything/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=56d52a482df130484e51fd066d1b6eda7c2c02ddbc91fe6e2be1b9c4e7306530
pkg_deps=(xorg/mkfontscale)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)
