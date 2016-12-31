pkg_name=postgrest
pkg_origin=jarvus
pkg_version=0.x.x
pkg_source=https://github.com/begriffs/postgrest.git
ghc_version=8.0.1
pkg_build_deps=(
  core/git
  jarvus/haskell-stack
  jarvus/ghc-archive/${ghc_version}
  core/patchelf
)
pkg_deps=(
  core/gcc
  core/glibc
  core/gmp
  core/libffi
  core/gawk
  core/perl
)

do_prepare() {
  # stack will extract and run ghc and we won't be able to run patchelf on it
  if [[ ! -r /lib/ld-linux-x86-64.so.2 ]]; then
    ln -s "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" /lib/
    _clean_lib=true
  fi
}

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
  export LD_LIBRARY_PATH="$LD_RUN_PATH"
  export STACK_YAML="$(pkg_path_for ghc-archive)/stack.yaml"
  export AWK="$(pkg_path_for gawk)/bin/awk"

  attach
  hab pkg exec jarvus/haskell-stack stack build --install-ghc && return 0
  attach
  return 1
}

do_install() {
  return 0
}

do_end() {
  # Clean up the `lib` link, if we set it up.
  if [[ -n "$_clean_lib" ]]; then
    rm -fv /lib/ld-linux-x86-64.so.2
  fi
}
