pkg_name=redis
pkg_origin=core
pkg_version=4.0-rc2
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url=http://redis.io/
pkg_license=('BSD-3-Clause')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/antirez/redis/archive/${pkg_version}.tar.gz
pkg_shasum=70941c192e6afe441cf2c8d659c39ab955e476030c492179a91dcf3f02f5db67
pkg_bin_dirs=(bin)
pkg_build_deps=(core/make core/gcc)
pkg_deps=(core/glibc)
pkg_svc_run="redis-server $pkg_svc_config_path/redis.config"
pkg_expose=(6379)

do_build() {
  make
}
