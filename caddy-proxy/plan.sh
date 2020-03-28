pkg_name=caddy-proxy
pkg_origin=jarvus
pkg_version=1.0.4
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=("MIT")
pkg_description="Service and config wrapper around Caddy for providing a simple proxy to a web application"
pkg_deps=(
  "core/caddy/${pkg_version}"
)

pkg_svc_run="caddy -conf ${pkg_svc_config_path}/Caddyfile"
pkg_svc_user="root"

pkg_binds=(
  [backend]="port"
)

do_build() {
  return 0
}

do_install() {
  return 0
}

do_strip() {
  return 0
}
