pkg_name=google-cloudsql-proxy
pkg_distname=cloudsql-proxy
pkg_origin=jarvus
pkg_version="1.15"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_plan_source="https://github.com/JarvusInnovations/habitat-plans/tree/master/google-cloudsql-proxy"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/GoogleCloudPlatform/cloudsql-proxy/archive/${pkg_version}.tar.gz"
pkg_shasum="977894db19d38941f7840314e429d53d92b519cc308b17d4adee6f6eec9117f0"
pkg_filename="${pkg_distname}-${pkg_version}.tar.bz2"
pkg_dirname="${pkg_distname}-${pkg_version}"

pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/git)

pkg_bin_dirs=(bin)


do_setup_environment() {
  set_buildtime_env GOPATH "${CACHE_PATH}.go"
}

do_build() {
  go get ./...
  go build -ldflags "-X 'main.versionString=${pkg_version}'" -o cloud_sql_proxy ./cmd/cloud_sql_proxy
}

do_install() {
  cp -v "cloud_sql_proxy" "${pkg_prefix}/bin/"
}
