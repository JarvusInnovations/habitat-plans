# TODO: rebuild with jre8 that has xorg deps
pkg_name=sencha-cmd
pkg_origin=jarvus
pkg_version=5.1.3.61
pkg_source=http://cdn.sencha.com/cmd/${pkg_version}/SenchaCmd-${pkg_version}-linux-x64.run.zip
pkg_shasum=171ae9f69bde80f663778b68a59a72bb08c72758e7f366556c5f53adab18a6df
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/zip
  core/gzip
  core/which
  core/patchelf
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
  ln -sf "`hab pkg path core/glibc`/lib/ld-linux-x86-64.so.2" /lib64/

  chmod +x ./SenchaCmd-*.run
  ./SenchaCmd-*.run --mode unattended --prefix "$pkg_prefix"
  mv "$pkg_prefix/Sencha/Cmd"/5.* "$pkg_prefix/dist"
  rm -R "$pkg_prefix/Sencha"
  find "$pkg_prefix/dist/bin" -type f -exec chmod +x {} \;

  build_line "Patching ELF binaries:"
  find "$pkg_prefix/dist" -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  build_line "Generating wrapper script"
  cat > "$pkg_prefix/bin/sencha" <<- EOM
#!/bin/sh

exec $pkg_prefix/dist/sencha \$@
EOM

    chmod +x "$pkg_prefix/bin/sencha"


  build_line "Creating repo/.sencha directory"
  mkdir -p "${pkg_prefix}/repo"
  chmod 777 "${pkg_prefix}/repo"

  return 0
}

do_strip() {
  return 0
}
