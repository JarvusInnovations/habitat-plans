pkg_name=postgrest
pkg_origin=jarvus
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_upstream_url=https://github.com/begriffs/postgrest
pkg_source=https://github.com/begriffs/postgrest.git
pkg_version=master
pkg_bin_dirs=(bin)

pkg_build_deps=(
  jarvus/haskell-stack
  core/git
  core/patchelf
  core/gcc
  core/zlib
)
pkg_deps=(
  core/postgresql
)

do_begin() {
  export GIT_DIR="${HAB_CACHE_SRC_PATH}/${pkg_name}.git"
}

do_download() {
  if [ -d "${GIT_DIR}" ]; then
    git fetch --all
  else
    git clone --bare "${pkg_source}" "${GIT_DIR}"
  fi

  #pkg_version="$(git describe ${pkg_version} --always --tags)"
  pkg_dirname="${pkg_name}-${pkg_version}"
  pkg_prefix="$HAB_PKG_PATH/${pkg_origin}/${pkg_name}/${pkg_version}/${pkg_release}"
  pkg_artifact="$HAB_CACHE_ARTIFACT_PATH/${pkg_origin}-${pkg_name}-${pkg_version}-${pkg_release}-${pkg_target}.${_artifact_ext}"

  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  mkdir "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"

  pushd "${HAB_CACHE_SRC_PATH}/${pkg_dirname}" > /dev/null
  git --work-tree=. checkout --force "${pkg_version}"
  git --work-tree=. submodule update --init --recursive
  popd > /dev/null

  return $?
}

do_build() {
  export LIBRARY_PATH="${LIBRARY_PATH}:$(pkg_path_for postgresql)/lib"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$(pkg_path_for postgresql)/lib"

  mkdir "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/bin"

  stack build \
    --extra-include-dirs="$(pkg_path_for zlib)/include" \
    --copy-bins \
    --local-bin-path="${HAB_CACHE_SRC_PATH}/${pkg_dirname}/bin" \
    && return 0

  return 1
}

do_install() {
  cp -vr ./bin "${pkg_prefix}"

  return 0
}
