pkg_name=hyper
pkg_origin=jarvus
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("custom")
pkg_source="https://hyper-install.s3.amazonaws.com/hyper-linux-x86_64.tar.gz"
pkg_shasum="24d69441ebf826bd5be63f2552924dbd6792898d40639031610bf9d38687ba34"
pkg_build_deps=(
  core/sed
  core/patchelf
)
pkg_deps=(
  core/glibc
)

pkg_bin_dirs=(bin)


# implement git-based dynamic version strings
pkg_version() {
  "${HAB_CACHE_SRC_PATH}/hyper" --version | sed -e 's/^Hyper version \([0-9.]\+\).*/\1/'
}


do_unpack() {
  do_default_unpack

  patchelf \
    --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    --set-rpath "$(pkg_path_for glibc)/lib" \
    ./hyper \;

  update_pkg_version
}

do_build() {
  return 0
}

do_install() {
  cp -v "${HAB_CACHE_SRC_PATH}/hyper" "${pkg_prefix}/bin/"
}
