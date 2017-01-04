pkg_name=gnatsd
pkg_origin=core
pkg_version=0.9.6
pkg_description="A High Performance NATS Server written in Go."
pkg_upstream_url=https://github.com/nats-io/gnatsd
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/nats-io/gnatsd/archive/v${pkg_version}.tar.gz
pkg_shasum=18d6d1b014bfd262da101e15ed914e194b51b47e3e1a8ca4e8743c742d65310c
pkg_deps=(core/go core/glibc)
pkg_build_deps=(core/go core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_svc_run="${pkg_name}"

do_build() {
  export GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"

  local libs_src_path="${GOPATH}/src/github.com/nats-io/gnatsd"

  mkdir -p "${libs_src_path}"

  ln -s \
    "${GOPATH}/auth" \
    "${GOPATH}/server" \
    "${GOPATH}/logger" \
    "${GOPATH}/conf" \
    "${GOPATH}/util" \
    "${GOPATH}/vendor" \
    "${libs_src_path}"

  go build
}


do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp  "${pkg_name}-${pkg_version}" "${pkg_prefix}/bin/${pkg_name}"
}
