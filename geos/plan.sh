pkg_name=geos
pkg_origin=core
pkg_version=3.6.1
pkg_description="GEOS (Geometry Engine - Open Source) is a C++ port of the ​Java Topology Suite (JTS)."
pkg_upstream_url=http://trac.osgeo.org/geos
pkg_license=('LGPL')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.osgeo.org/geos/geos-${pkg_version}.tar.bz2
pkg_shasum=4a2e4e3a7a09a7cfda3211d0f4a235d9fd3176ddf64bd8db14b4ead266189fc5
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_deps=(
  core/glibc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
