pkg_name=postgresql
pkg_version=9.6.1
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=e5101e0a49141fc12a7018c6dad594694d3a3325f5ab71e93e0e51bd94e51fcd
pkg_deps=(
  core/bash
  core/envdir
  core/glibc
  core/openssl
  core/perl
  core/readline
  core/zlib
  core/libossp-uuid
  core/wal-e

  # for postgis
  jarvus/geos
)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make

  # for postgis
  core/perl
  core/libxml2
  core/diffutils
  jarvus/proj
  jarvus/gdal
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=port
  [superuser_name]=superuser.name
  [superuser_password]=superuser.password
)
pkg_exposes=(port)

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

ext_postgis_version=2.3.2
ext_postgis_source=http://download.osgeo.org/postgis/source/postgis-${ext_postgis_version}.tar.gz
ext_postgis_filename=postgis-${ext_postgis_version}.tar.gz
ext_postgis_shasum=e92e34c18f078a3d1a2503cd870efdc4fa9e134f0bcedbbbdb8b46b0e6af09e4

do_before() {
  ext_postgis_dirname="postgis-${ext_postgis_version}"
  ext_postgis_cache_path="$HAB_CACHE_SRC_PATH/${ext_postgis_dirname}"
}

do_download() {
  do_default_download
  download_file $ext_postgis_source $ext_postgis_filename $ext_postgis_shasum
}

do_verify() {
  do_default_verify
  verify_file $ext_postgis_filename $ext_postgis_shasum
}

do_clean() {
  do_default_clean
  rm -rf "$ext_postgis_cache_path"
}

do_unpack() {
  do_default_unpack
  unpack_file $ext_postgis_filename
}

do_build() {
	# ld manpage: "If -rpath is not used when linking an ELF
	# executable, the contents of the environment variable LD_RUN_PATH
	# will be used if it is defined"
	./configure --disable-rpath \
              --with-openssl \
              --prefix="$pkg_prefix" \
              --with-uuid=ossp \
              --with-includes="$LD_INCLUDE_PATH" \
              --with-libraries="$LD_LIBRARY_PATH" \
              --sysconfdir="$pkg_svc_config_path" \
              --localstatedir="$pkg_svc_var_path"
	make world

  HAB_LIBRARY_PATH="$(pkg_path_for proj)/lib"
  export LIBRARY_PATH="${LIBRARY_PATH}:${HAB_LIBRARY_PATH}"
  build_line "Added habitat libraries to LIBRARY_PATH: ${HAB_LIBRARY_PATH}"

  build_line "Building ${ext_postgis_dirname}"
  pushd "$ext_postgis_cache_path" > /dev/null
  ./configure --prefix="$pkg_prefix"
  make
  popd > /dev/null
}

do_install() {
  make install-world

  build_line "Installing ${ext_postgis_dirname}"
  pushd "$ext_postgis_cache_path" > /dev/null
  make install DESTDIR="${pkg_prefix}" REGRESS=1
  popd > /dev/null

  attach
}
