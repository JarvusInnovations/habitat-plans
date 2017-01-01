pkg_name=postgrest
pkg_origin=jarvus
pkg_version=0.x.x
pkg_source=https://github.com/begriffs/postgrest.git
pkg_bin_dirs=(bin)

pkg_build_deps=(
  jarvus/haskell-stack
  core/git
  core/patchelf
  core/gcc
  core/zlib
)
pkg_deps=(
  core/postgresql
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

  mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin"

  stack build \
    --extra-include-dirs="$(pkg_path_for zlib)/include" \
    --copy-bins \
    --local-bin-path="$HAB_CACHE_SRC_PATH/$pkg_dirname/bin" \
    && return 0

  return 1
}

do_install() {
  cp -vr ./bin "$pkg_prefix"

  return 0
}