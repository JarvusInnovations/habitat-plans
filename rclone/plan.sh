pkg_name=rclone
pkg_origin=jarvus
pkg_version="1.56.2"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_plan_source="https://github.com/JarvusInnovations/habitat-plans/tree/master/rclone"
pkg_license=("MIT")
pkg_source="https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="a5b0b7dfe17d9ec74e3a33415eec4331c61d800d8823621e61c6164e8f88c567"

pkg_deps=(core/glibc)
pkg_build_deps=(core/go)

pkg_bin_dirs=(bin)


do_build() {
  go build
}

do_install() {
  cp -v rclone "${pkg_prefix}/bin/"
}
