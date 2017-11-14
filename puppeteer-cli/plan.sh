pkg_name=puppeteer
pkg_origin=jarvus
pkg_version="0.1.0"
pkg_deps=(
  core/node
)
pkg_bin_dirs=(bin)


do_prepare() {
  cp -v index.js package.json "${CACHE_PATH}/"
}

do_build () {
  pushd "${CACHE_PATH}" > /dev/null
  npm install
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