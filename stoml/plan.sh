pkg_origin=jarvus
pkg_name=stoml
pkg_version="0.4.0"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_description="Simple TOML parser for Bash"
pkg_upstream_url=https://github.com/freshautomations/stoml
pkg_source="https://github.com/freshautomations/stoml/archive/v${pkg_version}.tar.gz"
pkg_shasum="5b41845021181cf2e2204f9e30213d002ff2bc4c299a2b4edad1a9910e429546"
pkg_build_deps=(core/git core/go)
pkg_bin_dirs=(bin)


do_setup_environment() {
  set_buildtime_env GOPATH "${CACHE_PATH}.go"
}

do_build() {
  go build
}

do_install() {
  cp -v "stoml" "${pkg_prefix}/bin/"
}
