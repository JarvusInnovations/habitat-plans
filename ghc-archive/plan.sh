pkg_name=ghc-archive
pkg_origin=jarvus
pkg_version=8.0.1
pkg_source=http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-x86_64-deb7-linux.tar.xz
pkg_shasum=86a8109dfa4ec000e0048ed9d072c0d232affeb1069ca96b3995cb5cef2230a7
pkg_dirname=ghc-${pkg_version}
pkg_build_deps=(
  core/patchelf
  core/make
)
pkg_deps=(
  core/gcc
  core/glibc
  core/gmp
  core/libffi
  core/gawk
  core/perl
  jarvus/ncurses5-compat-libs
)

ghc_patch_executable() {
  RELATIVE_TO=$(dirname $1)
  RELATIVE_PATHS=$((for LIB_PATH in ${@:3}; do echo '$ORIGIN/'$(realpath --relative-to="$RELATIVE_TO" "$LIB_PATH"); done) | paste -sd ':')
  patchelf --interpreter "$2" --set-rpath "${LD_RUN_PATH}:$RELATIVE_PATHS" $1
}
export -f ghc_patch_executable

do_build() {
  local INTERPRETER="$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2"
  local GHC_LIB_PATHS=$(find . -name '*.so' -printf '%h\n' | uniq)

  build_line "Patching ELF binaries:"

  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -print \
    -exec bash -c 'ghc_patch_executable $1 $2 $3' _ "{}" "$INTERPRETER" "$GHC_LIB_PATHS" \;
}

do_install() {
  build_line "Building ghc archive..."
  pushd "${HAB_CACHE_SRC_PATH}" > /dev/null
  XZ_OPT="-0" tar -cJf "${pkg_prefix}/ghc-${pkg_version}.tar.xz" "${pkg_dirname}"
  popd > /dev/null

  cat > "${pkg_prefix}/stack.yaml" <<- EOM
resolver: ghc-${pkg_version}
compiler: ghc-${pkg_version}
ghc-variant: habitat-ghc
setup-info:
  ghc:
    linux64-custom-habitat-ghc:
      ${pkg_version}:
        url: "${pkg_prefix}/ghc-${pkg_version}.tar.xz"
EOM
}

do_strip() {
  return 0
}

