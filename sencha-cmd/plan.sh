pkg_name=sencha-cmd
pkg_origin=jarvus
pkg_version=6.6.0.13
pkg_source=http://cdn.sencha.com/cmd/${pkg_version}/no-jre/SenchaCmd-${pkg_version}-linux-amd64.sh.zip
pkg_shasum=e45e7a0806165da462857af26c37e360b8b2c37a2c011e71ba02a0d0eb64b0b3
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/zip
  core/gzip
  core/which
  core/patchelf
  core/patch
)
pkg_deps=(
  core/jre8
  core/coreutils
  core/sed
  core/gawk
  core/ruby
  core/glibc
  core/zlib
  core/fontconfig
  core/freetype
  core/gcc-libs
  core/expat
)

do_unpack() {
  local source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}

  mkdir "$source_dir"
  unzip "$HAB_CACHE_SRC_PATH/$pkg_filename" -d "$source_dir"

  return 0
}

do_build() {
  return 0
}

do_install() {
  mkdir "$pkg_prefix/dist"
  ./SenchaCmd-*.sh -Dall=true -q -dir "$pkg_prefix/dist"

  build_line "Creating command wrapper"
    cat > "$pkg_prefix/bin/sencha" <<- EOM
#!/bin/sh

exec $pkg_prefix/dist/sencha \$@
EOM
  chmod +x "$pkg_prefix/bin/sencha"

  build_line "Patching ELF binaries:"
  find "$pkg_prefix/dist" -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  build_line "Creating repo/.sencha directory"
  mkdir -p "${pkg_prefix}/repo"
  chmod 777 "${pkg_prefix}/repo"

  build_line "Applying patches"
  patch -p0 -i "${PLAN_CONTEXT}/cache.patch" -d "${pkg_prefix}/dist"

  return 0
}

do_strip() {
  return 0
}
