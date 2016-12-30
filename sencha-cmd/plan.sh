pkg_name=sencha-cmd
pkg_origin=jarvus
pkg_version=6.2.0
pkg_source=http://cdn.sencha.com/cmd/${pkg_version}/no-jre/SenchaCmd-${pkg_version}-linux-amd64.sh.zip
pkg_shasum=138dcb49df72fff322706036e21b2e5db11df741db8b325f39a8360c85f62bdf
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/zip
  core/gzip
  core/which
)
pkg_deps=(
  core/jre8
  core/coreutils
  core/sed
  core/gawk
  core/ruby
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
  mkdir "$pkg_prefix/bin" "$pkg_prefix/dist"
  ./SenchaCmd-*.sh -q -a -dir "$pkg_prefix/dist"
  ln -s ../dist/sencha "$pkg_prefix/bin/"
}
