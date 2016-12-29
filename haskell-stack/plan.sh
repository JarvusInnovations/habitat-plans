pkg_name=haskell-stack
pkg_origin=jarvus
pkg_version=1.3.2
pkg_source=https://github.com/commercialhaskell/stack/releases/download/v${pkg_version}/stack-${pkg_version}-linux-x86_64-static.tar.gz
pkg_shasum=ebeb76744c85b7cd5504b6e29f8912b920a247b7895a2d4a1fe9564f5c5ec164
pkg_bin_dirs=(bin)
pkg_deps=(core/cacerts)

do_unpack() {
  local source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}

  mkdir "$source_dir"

  pushd "$source_dir" >/dev/null
  tar xz --strip-components=1 -f "$HAB_CACHE_SRC_PATH/$pkg_filename"
  popd > /dev/null

  return 0
}

do_build() {
  return 0
}

do_install() {
  cp -vr ./* "$pkg_prefix"

  # generate wrapper script to provide path to root certificates
  mkdir $pkg_prefix/bin
  local stack_wrapper=$pkg_prefix/bin/stack
  echo "#!/bin/sh" > $stack_wrapper
  echo "export SYSTEM_CERTIFICATE_PATH=\"$(pkg_path_for core/cacerts)/ssl/certs\"" >> $stack_wrapper
  echo "exec $pkg_prefix/stack \$@" >> $stack_wrapper
  chmod +x $stack_wrapper
}
