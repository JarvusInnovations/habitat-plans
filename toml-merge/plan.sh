pkg_name=toml-merge
pkg_origin=jarvus
pkg_version="1.0.0"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_plan_source="https://github.com/JarvusInnovations/habitat-plans/tree/master/toml-merge"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/boivie/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum="a943f6081250c5863549c9824e1ba4bebda41961652c68eefb8e0b023d4bc081"

pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/git)

pkg_bin_dirs=(bin)


do_setup_environment() {
  set_buildtime_env GOPATH "${CACHE_PATH}"
}

do_build() {
  go get github.com/BurntSushi/toml
  go build
}

do_install() {
  cp -v "${pkg_name}-${pkg_version}" "${pkg_prefix}/bin/${pkg_name}"
}
