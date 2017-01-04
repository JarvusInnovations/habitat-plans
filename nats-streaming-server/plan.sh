pkg_name=nats-streaming-server
pkg_origin=core
pkg_version=0.3.6
pkg_description="NATS Streaming is an extremely performant, lightweight reliable streaming platform built on NATS."
pkg_upstream_url=https://github.com/nats-io/nats-streaming-server
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/nats-io/nats-streaming-server/archive/v${pkg_version}.tar.gz
pkg_shasum=4a8d2f7b27704b7671454bcd8a6a30a2a47de169b620d116ff373c1a9c13b9da
pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_svc_run="${pkg_name}"


do_begin() {
  export GOPATH="/hab/cache"
  parent_go_path="${GOPATH}/src/github.com/nats-io"
  pkg_go_path="${parent_go_path}/${pkg_name}"
}

do_clean() {
  do_default_clean
  rm -rf "${parent_go_path}"
  return $?
}

do_prepare() {
  mkdir -p "${parent_go_path}"
  ln -s "${PWD}" "${pkg_go_path}"
  return $?
}

do_build() {
  pushd "${pkg_go_path}" > /dev/null
  go build
  local code=$?
  popd > /dev/null

  return $code
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp "${pkg_name}" "${pkg_prefix}/bin/"
  return $?
}
