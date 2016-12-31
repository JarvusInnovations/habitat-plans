pkg_name=postgrest
pkg_origin=jarvus
pkg_version=0.x.x
pkg_source=https://github.com/begriffs/postgrest.git

pkg_build_deps=(
  jarvus/haskell-stack
  core/git
  core/patchelf
  core/gcc
  core/postgresql
)
pkg_deps=(
)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  git clone ${pkg_source} "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_build() {
  attach
  stack build && return 0
  attach
  return 1
}

do_install() {
  return 0
}