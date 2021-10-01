pkg_name=kubeseal
pkg_origin=jarvus
pkg_version="0.16.0"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_plan_source="https://github.com/JarvusInnovations/habitat-plans/tree/master/kubeseal"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/bitnami-labs/sealed-secrets/archive/v${pkg_version}.tar.gz"
pkg_shasum="ecbd8bf71679cf68425a1aad64c7e9263c1361534ee5bd67210e4cd2ed1ca3a0"
pkg_dirname="sealed-secrets-${pkg_version}"

pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/make)

pkg_bin_dirs=(bin)


do_build() {
  make kubeseal VERSION="${pkg_version}"
}

do_install() {
  cp -v kubeseal "${pkg_prefix}/bin/"
}
