pkg_origin=jarvus
pkg_name=kube-pod-update-status
pkg_version="master"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_source="https://github.com/multi-io/kube-pod-update-status/archive/${pkg_version}.zip"
pkg_shasum=bd47cf1079880cad56cd0873d2a3bacab5756e2a33b8f45790c46491a106ac36
pkg_upstream_url=https://github.com/multi-io/kube-pod-update-status
pkg_build_deps=(core/git core/go)
pkg_deps=(core/bash)
pkg_bin_dirs=(bin)


do_setup_environment() {
  set_buildtime_env GOPATH "${CACHE_PATH}.go"
}

do_build() {
  pushd "${CACHE_PATH}" > /dev/null
  go build -o bin/kube-pod-update-status

  sed -e "s#\#\!/usr/bin/env bash#\#\!$(pkg_path_for bash)/bin/bash#" -i fix-all-pods.sh
  sed -e "s#./kube-pod-update-status#${pkg_prefix}/bin/kube-pod-update-status#" -i fix-all-pods.sh
  popd > /dev/null
}

do_install() {
  cp -v "${CACHE_PATH}/bin"/* "${pkg_prefix}/bin/"
  cp -v "${CACHE_PATH}/fix-all-pods.sh" "${pkg_prefix}/bin/fix-all-pods"
}
