pkg_name=mysql-remote
pkg_origin=core
pkg_version="0.1.0"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=("MIT")
pkg_deps=(
  core/mysql-client
)


pkg_exports=(
  [host]=host
  [port]=port
  [password]=password
  [username]=username
  [server_id]=server_id
)


do_build() {
  return 0
}

do_install() {
  return 0
}
