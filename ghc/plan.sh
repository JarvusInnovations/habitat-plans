pkg_name=ghc
pkg_origin=jarvus
pkg_version=8.0.1
pkg_source=http://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-x86_64-deb7-linux.tar.xz
pkg_shasum=86a8109dfa4ec000e0048ed9d072c0d232affeb1069ca96b3995cb5cef2230a7
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/patchelf
)
pkg_deps=(
  core/glibc
  core/gmp
  core/perl
  core/gcc
  core/make
  core/libffi
  jarvus/ncurses5-compat-libs
)

do_build() {
  echo "Patching ELF binaries:"
  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

# DOESN'T WORK BECAUSE INSTALL PROCESS TRIES TO STRIP THEM LATER
#  echo "Patching shared libraries:"
#  find . -type f -name "*.so" \
#    -print \
#    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;

# SUGGESTED BY BUILT-IN STRIPPER BUT DOES NOTHING
#  export LDFLAGS="$LDFLAGS -N"

  # instead of using patchelf on libraries or making headers ok to patch with -N, just stick everything containing a .so in LD_LIBRARY_PATH
  export LD_LIBRARY_PATH="$LD_RUN_PATH$(find $HAB_CACHE_SRC_PATH/$pkg_dirname -name '*.so' -printf ':%h')"
attach
  ./configure --prefix=${pkg_prefix}
}

do_install() {
  do_default_install

  # insert our monster LD_LIBRARY_PATH into each script
  local PKG_LD_LIBRARY_PATH="$LD_RUN_PATH$(find $pkg_prefix/lib -name '*.so' -printf ':%h')"

  echo "Patching wrapper scripts:"
  find $pkg_prefix/bin -type f \
    -exec sh -c 'file -i "$1" | grep -q "text/x-shellscript"' _ {} \; \
    -print \
    -exec sed -i "2i export LD_LIBRARY_PATH=\"$LD_LIBRARY_PATH:$PKG_LD_LIBRARY_PATH\"" {} \;
}

do_strip() {
  return 0
}
