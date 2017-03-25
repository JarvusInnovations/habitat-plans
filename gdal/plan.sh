pkg_name=gdal
pkg_origin=core
pkg_version=2.1.3
pkg_description="GDAL is a translator library for raster and vector geospatial data formats"
pkg_upstream_url=http://www.gdal.org/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.osgeo.org/gdal/${pkg_version}/gdal-${pkg_version}.tar.gz
pkg_shasum=ae6a0a0dc6eb45a981a46db27e3dfe16c644fcf04732557e2cb315776974074a
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
