pkg_name=jsoncdc
pkg_origin=jarvus
pkg_version=0.0.10
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=('Apache-2.0')
pkg_upstream_url=https://github.com/posix4e/jsoncdc
pkg_description="JSONCDC provides change data capture for Postgres, translating the Postgres write ahead log to JSON."
pkg_source=https://github.com/posix4e/jsoncdc/archive/${pkg_version}.tar.gz
pkg_shasum=9c1aec6761704aa962ccd83c7c46e26089abaa1d1ef104447db727f8c527f48c
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/make
  core/gcc
  core/which
  core/rust
  core/postgresql
)
pkg_lib_dirs=(lib)

do_build() {
  make
  return $?
}

do_install() {
  cp -vr * "${pkg_prefix}/"
  return $?
}
