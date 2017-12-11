pkg_name=pure-ftpd
pkg_origin=jarvus
pkg_version="1.0.47"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=("BSD-4-Clause") # BSD license varient not confirmed
pkg_source="https://download.pureftpd.org/pub/${pkg_name}/releases/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="cb1b695e779a06e42d62d7a1a428d2f605d621dfd5afe4e192b5f9fc4e343692"
pkg_plan_source="https://github.com/JarvusInnovations/habitat-plans/tree/master/pure-ftpd"

pkg_build_deps=(
  core/make
  core/gcc
)

pkg_deps=(
  core/glibc
)

pkg_bin_dirs=(bin sbin)