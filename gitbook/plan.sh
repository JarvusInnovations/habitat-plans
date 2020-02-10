pkg_name="gitbook"
pkg_origin="jarvus"
pkg_version="2.3.4"
pkg_description="GitBook's command line interface"
pkg_upstream_url="https://github.com/mrac/gitbook-updated-cli"
pkg_license=("Apache-2.0")
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_source="https://github.com/mrac/gitbook-updated-cli/archive/v${pkg_version}.tar.gz"
pkg_shasum="9378d49023a64bbab36b3784f985eb0d58bdd2efaba2b107dccfd779d1632ee2"

pkg_bin_dirs=(bin)

# override because the repo name doesn't match this package's name
pkg_filename="gitbook-updated-cli-${pkg_version}.tar.gz"
pkg_dirname="gitbook-updated-cli-${pkg_version}"

pkg_deps=(
  core/git
  core/node/12.8.0
)


gitbook_version="3.2.3"


do_setup_environment() {
  push_runtime_env GITBOOK_DIR "${pkg_prefix}"
}

# implement build workflow
do_build() {
  pushd "${CACHE_PATH}" > /dev/null

  build_line "Applying known-good package-lock.json"
  cp -v "${PLAN_CONTEXT}/package-lock.gitbook-cli.json" "./package-lock.json"

  build_line "Installing dependencies with NPM"
  npm install --no-progress --quiet --no-audit --production

  build_line "Renaming bin command"
  mv -v "bin/gitbook.js" "bin/gitbook"

  build_line "Fixing interpreter"
  sed -e "s#\#\!\s*/usr/bin/env node#\#\!$(pkg_path_for node)/bin/node#" --in-place "bin/gitbook"

  popd > /dev/null
}

do_install() {
  pushd "${CACHE_PATH}" > /dev/null
  cp -r ./* "${pkg_prefix}/"
  popd > /dev/null

  build_line "Installing engine version ${gitbook_version}"
  pushd "${pkg_prefix}" > /dev/null
  npm install --no-progress --quiet --no-audit --save "gitbook@${gitbook_version}"
  mkdir "versions"
  ln -s ../node_modules/gitbook "versions/${gitbook_version}"
  popd > /dev/null

  pushd "${pkg_prefix}/node_modules/gitbook" > /dev/null

  build_line "Applying known-good package-lock.json"
  cp -v "${PLAN_CONTEXT}/package-lock.gitbook.json" "./package-lock.json"

  build_line "Upgrading NPM"
  npm install --no-progress --quiet --no-audit --save npm@6 npmi@4

  popd > /dev/null
}

do_strip() {
  return 0
}
