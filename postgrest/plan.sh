pkg_name=postgrest
pkg_origin=jarvus
pkg_version=0.x.x
pkg_source=https://github.com/begriffs/postgrest.git
pkg_build_deps=(
  core/git
  jarvus/haskell-stack
  jarvus/ghc
  core/patchelf
  core/gmp
  core/libffi
  core/gcc
  core/gcc-libs
  core/glibc
  core/gawk
  core/gzip
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
  cat > stack.yaml <<- EOM
resolver: ghc-8.0.1
compiler: ghc-8.0.1
ghc-variant: habitat-ghc
setup-info:
  ghc:
    linux64-custom-habitat-ghc:
      8.0.1:
        url: "/src/ghc.tar.xz"
EOM

  export LD_LIBRARY_PATH="$(pkg_path_for gmp)/lib:$(pkg_path_for libffi)/lib:$(pkg_path_for gcc-libs)/lib"
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
