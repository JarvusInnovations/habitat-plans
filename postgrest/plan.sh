pkg_name=postgrest
pkg_origin=jarvus
pkg_version=0.3.2.0
pkg_source=https://github.com/begriffs/postgrest/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}-ubuntu.tar.xz
pkg_shasum=1ac3d636e2a072f316b9b192269d9a82447cf8041e66d31b9fcacb29e98f050d
pkg_upstream_url=https://github.com/begriffs/postgrest
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=('MIT')
pkg_bin_dirs=(bin)
pkg_deps=(core/postgresql)

do_build() {
  return 0
}

do_install() {
  mkdir -p ${pkg_prefix}/bin
  cp -av $HAB_CACHE_SRC_PATH/postgrest ${pkg_prefix}/bin/
}
