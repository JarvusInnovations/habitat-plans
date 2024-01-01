pkg_name=kubectl-neat
pkg_origin=core
pkg_version=2.0.3
pkg_description="Clean up Kubernetes yaml and json output to make it readable"
pkg_upstream_url=https://github.com/itaysk/kubectl-neat
pkg_license=('Apache-2.0')
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_source=https://github.com/itaysk/kubectl-neat/archive/refs/tags/v${pkg_version}.tar.gz
pkg_shasum=d4788cac64102db35c69e21d99a67a08a83848f955cb9bf14fa9a56c49935b4f
pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_svc_run="${pkg_name}"


do_build() {
  make build
}

do_install() {
  cp -v "dist/kubectl-neat_linux_amd64" "${pkg_prefix}/bin/kubectl-neat"
}
