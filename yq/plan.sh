pkg_origin=jarvus
pkg_name=yq
pkg_version="4.6.2"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_description="Portable command-line YAML processor"
pkg_upstream_url=https://github.com/mikefarah/yq
pkg_source="https://github.com/mikefarah/yq/archive/v${pkg_version}.tar.gz"
pkg_shasum="3edee5bae40afdf8869803c6f81eb15adbaaf373ba27e4907d6dd5dceebaf65c"
pkg_build_deps=(core/git core/go)
pkg_bin_dirs=(bin)


do_setup_environment() {
  set_buildtime_env GOPATH "${CACHE_PATH}.go"
}

do_build() {
  go build
}

do_install() {
  cp -v "yq" "${pkg_prefix}/bin/"
}
