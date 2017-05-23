pkg_name=postgis
pkg_origin=core
pkg_version=2.3.2
pkg_description="Spatial and Geographic objects for PostgreSQL"
pkg_upstream_url=http://postgis.net/
pkg_license=('GPLv2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.osgeo.org/postgis/source/postgis-${pkg_version}.tar.gz
pkg_shasum=e92e34c18f078a3d1a2503cd870efdc4fa9e134f0bcedbbbdb8b46b0e6af09e4
pkg_build_deps=(
  core/gcc
  core/perl
  core/libxml2
  core/make
  #core/coreutils
  
  jarvus/geos
  jarvus/proj
  jarvus/gdal
)
pkg_deps=(
  core/postgresql
  core/glibc
)

do_build() {
  export LIBRARY_PATH="${LIBRARY_PATH}:$(pkg_path_for proj)/lib:$(pkg_path_for glibc)/lib"

  do_default_build
  return $?
}

do_install() {
  # postgis' install does not handle prefix well: https://trac.osgeo.org/postgis/ticket/635
  # postgresql doesn't want to load extensions from place outside its prefix: http://www.postgresql-archive.org/Configurable-location-for-extension-control-files-td5757897.html
  # see also: https://github.com/NixOS/nixpkgs/pull/5926
    
  make install DESTDIR="${pkg_prefix}" REGRESS=1

  pushd "${pkg_prefix}" >/dev/null

  mv "${pkg_prefix}$(pkg_path_for postgresql)/bin"/* ./bin/
  mv "${pkg_prefix}$(pkg_path_for postgresql)/share/contrib"/* ./share/contrib/
  mv "${pkg_prefix}$(pkg_path_for postgresql)/share/extension" ./share/
  mv "${pkg_prefix}${pkg_prefix}/include" ./
  mv "${pkg_prefix}${pkg_prefix}/lib"/* ./lib/
  rm -R "${pkg_prefix}/hab"

  popd > /dev/null

  return $?
}
