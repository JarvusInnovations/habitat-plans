pkg_name=rclone
pkg_origin=jarvus
pkg_version="1.49.4"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_plan_source="https://github.com/JarvusInnovations/habitat-plans/tree/master/rclone"
pkg_license=("MIT")
pkg_source="https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="d21baf46551d9f3ee33dbc921cfaac503b0142339bdcc75eee973f7ed4b7a354"

pkg_deps=(core/glibc)
pkg_build_deps=(core/go)

pkg_bin_dirs=(bin)


do_build() {
  go build
}

do_install() {
  cp -v rclone "${pkg_prefix}/bin/"
}
