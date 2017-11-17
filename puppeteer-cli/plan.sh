pkg_name=puppeteer
pkg_origin=jarvus
pkg_version="0.1.0"
pkg_build_deps=(
  core/patchelf
)
pkg_deps=(
  core/glib
  core/glibc
  core/gcc-libs
  core/node
  core/xlib
  core/libxext
  core/libxcb
  core/libxrender
  core/libxi
  core/libxtst
  core/libxau
  core/cairo
  core/pango
  core/fontconfig
  core/expat
  core/dbus
  core/nss
  core/nspr
  core/libxfixes
  core/atk
  core/gdk-pixbuf
  core/libxrandr

  # under development:
  #jarvus/gconf2
)
pkg_bin_dirs=(bin)


do_prepare() {
  cp -v index.js package.json "${CACHE_PATH}/"
}

do_build () {
  pushd "${CACHE_PATH}" > /dev/null

  build_line "Installing dependencies with NPM"
  npm install

  build_line "Patching ELF binaries:"
  find "./node_modules" -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q -E "x-(sharedlib|executable); charset=binary"' _ {} \; \
    -print \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  # DEBUG DEPENDENCIES:
  ldd node_modules/puppeteer/.local-chromium/linux-515411/chrome-linux/chrome > /src/puppeteer-cli/chrome-ldd.txt
  cat /src/puppeteer-cli/chrome-ldd.txt
  return 1
  # END DEBUG

  popd > /dev/null
}

do_install() {
  pushd "${CACHE_PATH}" > /dev/null
  cp -r ./* "${pkg_prefix}/"
  popd > /dev/null

  cat > "${pkg_prefix}/bin/puppeteer" <<- EOM
#!/bin/sh

exec $(pkg_path_for node)/bin/node ${pkg_prefix}/index.js \$@
EOM

  chmod +x "${pkg_prefix}/bin/puppeteer"
}

do_strip() {
  return 0
}