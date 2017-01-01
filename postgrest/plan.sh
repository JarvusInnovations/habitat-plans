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
  core/zlib
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
  export LIBRARY_PATH="$LIBRARY_PATH:$(pkg_path_for postgresql)/lib"
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$(pkg_path_for postgresql)/lib"

  stack build --extra-include-dirs="$(pkg_path_for zlib)/include" && return 0

  return 1
}

do_install() {
  return 0
}